package com.sbsg.contingencias.service;

import com.sbsg.contingencias.dto.GuardarHorarioClaseRequest;
import com.sbsg.contingencias.dto.HorarioClaseDTO;
import com.sbsg.contingencias.model.*;
import com.sbsg.contingencias.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class HorarioClaseService {

    private final HorarioClaseRepository horarioClaseRepository;
    private final DocenteRepository docenteRepository;
    private final CursoRepository cursoRepository;
    private final MateriaRepository materiaRepository;
    private final FranjaHorariaRepository franjaHorariaRepository;
    private final HorarioDisponibilidadRepository horarioDisponibilidadRepository;

    public HorarioClaseService(HorarioClaseRepository horarioClaseRepository,
                               DocenteRepository docenteRepository,
                               CursoRepository cursoRepository,
                               MateriaRepository materiaRepository,
                               FranjaHorariaRepository franjaHorariaRepository,
                               HorarioDisponibilidadRepository horarioDisponibilidadRepository) {
        this.horarioClaseRepository = horarioClaseRepository;
        this.docenteRepository = docenteRepository;
        this.cursoRepository = cursoRepository;
        this.materiaRepository = materiaRepository;
        this.franjaHorariaRepository = franjaHorariaRepository;
        this.horarioDisponibilidadRepository = horarioDisponibilidadRepository;
    }

    public List<HorarioClaseDTO> obtenerHorarioDocente(Long docenteId) {
        return horarioClaseRepository.findByDocenteId(docenteId)
                .stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public List<HorarioClaseDTO> obtenerHorarioCurso(Long cursoId) {
        return horarioClaseRepository.findByCursoId(cursoId)
                .stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public Optional<HorarioClaseDTO> detectarClase(Long docenteId, LocalDate fecha, Long franjaHorariaId) {
        if (docenteId == null || fecha == null || franjaHorariaId == null) {
            return Optional.empty();
        }
        String diaSemana = DisponibilidadService.obtenerDiaSemanaEnEspanol(fecha);
        return horarioClaseRepository.findByDocenteIdAndDiaSemanaAndFranjaHorariaId(docenteId, diaSemana, franjaHorariaId)
                .map(this::toDTO);
    }

    public java.util.Map<String, Object> validarConflictoCurso(Long cursoId, String diaSemana, Long franjaHorariaId, Long docenteIdExcluir) {
        java.util.Map<String, Object> resp = new java.util.HashMap<>();
        if (cursoId == null || diaSemana == null || franjaHorariaId == null) {
            resp.put("hayConflicto", false);
            return resp;
        }

        List<HorarioClase> existentes = horarioClaseRepository.findByCursoIdAndDiaSemanaAndFranjaHorariaId(
                cursoId, diaSemana.trim(), franjaHorariaId
        );

        for (HorarioClase hc : existentes) {
            if (hc.isEsClase() && hc.getDocente() != null && (docenteIdExcluir == null || !hc.getDocente().getId().equals(docenteIdExcluir))) {
                resp.put("hayConflicto", true);
                resp.put("docenteId", hc.getDocente().getId());
                resp.put("docenteNombre", hc.getDocente().getNombreCompleto());
                resp.put("materiaId", hc.getMateria() != null ? hc.getMateria().getId() : null);
                resp.put("materiaNombre", hc.getMateria() != null ? hc.getMateria().getNombre() : (hc.getActividad() != null ? hc.getActividad() : "Clase"));
                resp.put("cursoId", hc.getCurso() != null ? hc.getCurso().getId() : cursoId);
                resp.put("cursoNombre", hc.getCurso() != null ? hc.getCurso().getNombre() : "");
                resp.put("diaSemana", hc.getDiaSemana());
                resp.put("franjaHorariaId", hc.getFranjaHoraria() != null ? hc.getFranjaHoraria().getId() : franjaHorariaId);
                resp.put("franjaHorariaEtiqueta", hc.getFranjaHoraria() != null ? hc.getFranjaHoraria().getEtiqueta() : "");
                resp.put("mensaje", "Ya fue asignado el maestro " + hc.getDocente().getNombreCompleto()
                        + ", con la materia " + (hc.getMateria() != null ? hc.getMateria().getNombre() : (hc.getActividad() != null ? hc.getActividad() : "Clase"))
                        + " en el curso " + (hc.getCurso() != null ? hc.getCurso().getNombre() : "")
                        + " y ese horario (" + hc.getDiaSemana() + " " + (hc.getFranjaHoraria() != null ? hc.getFranjaHoraria().getEtiqueta() : "") + ").");
                return resp;
            }
        }

        resp.put("hayConflicto", false);
        return resp;
    }

    @Transactional
    public List<HorarioClaseDTO> guardarHorarioDocente(GuardarHorarioClaseRequest req) {
        if (req.getDocenteId() == null) {
            throw new IllegalArgumentException("El ID del docente es obligatorio.");
        }
        Docente docente = docenteRepository.findById(req.getDocenteId())
                .orElseThrow(() -> new RuntimeException("Docente no encontrado con ID: " + req.getDocenteId()));

        // 1. Validar que ningún slot colisione con otro docente ya asignado a ese curso y horario
        if (req.getSlots() != null) {
            for (GuardarHorarioClaseRequest.HorarioClaseItemRequest slot : req.getSlots()) {
                if (slot.getFranjaHorariaId() == null || slot.getDiaSemana() == null) continue;
                if (!slot.isEsClase() || slot.getCursoId() == null) continue;

                List<HorarioClase> existentes = horarioClaseRepository.findByCursoIdAndDiaSemanaAndFranjaHorariaId(
                        slot.getCursoId(), slot.getDiaSemana().trim(), slot.getFranjaHorariaId()
                );
                for (HorarioClase hc : existentes) {
                    if (hc.isEsClase() && hc.getDocente() != null && !hc.getDocente().getId().equals(docente.getId())) {
                        String docNom = hc.getDocente().getNombreCompleto();
                        String matNom = hc.getMateria() != null ? hc.getMateria().getNombre() : (hc.getActividad() != null ? hc.getActividad() : "Clase");
                        String curNom = hc.getCurso() != null ? hc.getCurso().getNombre() : "el curso";
                        String franjaEti = hc.getFranjaHoraria() != null ? hc.getFranjaHoraria().getEtiqueta() : "";
                        throw new IllegalStateException("Conflicto de horario: Ya fue asignado el maestro " + docNom
                                + ", con la materia " + matNom
                                + " en el curso " + curNom
                                + " y ese horario (" + slot.getDiaSemana() + " " + franjaEti + ").");
                    }
                }
            }
        }

        horarioClaseRepository.deleteByDocenteId(docente.getId());
        horarioDisponibilidadRepository.deleteByDocenteId(docente.getId());
        horarioClaseRepository.flush();
        horarioDisponibilidadRepository.flush();

        java.util.Map<String, HorarioClase> nuevasClasesMap = new java.util.LinkedHashMap<>();
        java.util.Map<String, HorarioDisponibilidad> nuevasDispMap = new java.util.LinkedHashMap<>();

        if (req.getSlots() != null) {
            for (GuardarHorarioClaseRequest.HorarioClaseItemRequest slot : req.getSlots()) {
                if (slot.getFranjaHorariaId() == null || slot.getDiaSemana() == null) continue;
                FranjaHoraria franja = franjaHorariaRepository.findById(slot.getFranjaHorariaId())
                        .orElse(null);
                if (franja == null) continue;

                String slotKey = slot.getDiaSemana().trim().toLowerCase() + "_" + franja.getId();

                Curso curso = slot.getCursoId() != null ? cursoRepository.findById(slot.getCursoId()).orElse(null) : null;
                Materia materia = slot.getMateriaId() != null ? materiaRepository.findById(slot.getMateriaId()).orElse(null) : null;

                HorarioClase hc = new HorarioClase(
                        docente,
                        slot.getDiaSemana(),
                        franja,
                        curso,
                        materia,
                        slot.getActividad(),
                        slot.isEsClase()
                );
                nuevasClasesMap.put(slotKey, hc);

                // Si NO es clase (es libre/disponible), registrar en disponibilidad para contingencias
                if (!slot.isEsClase()) {
                    nuevasDispMap.put(slotKey, new HorarioDisponibilidad(docente, slot.getDiaSemana(), franja));
                }
            }
        }

        List<HorarioClase> guardadas = horarioClaseRepository.saveAll(nuevasClasesMap.values());
        horarioDisponibilidadRepository.saveAll(nuevasDispMap.values());
        horarioClaseRepository.flush();
        horarioDisponibilidadRepository.flush();

        return guardadas.stream().map(this::toDTO).collect(Collectors.toList());
    }

    @Transactional
    public List<HorarioClaseDTO> guardarHorarioCurso(GuardarHorarioClaseRequest req) {
        if (req.getCursoId() == null) {
            throw new IllegalArgumentException("El ID del curso es obligatorio.");
        }
        Curso curso = cursoRepository.findById(req.getCursoId())
                .orElseThrow(() -> new RuntimeException("Curso no encontrado con ID: " + req.getCursoId()));

        horarioClaseRepository.deleteByCursoId(curso.getId());
        horarioClaseRepository.flush();

        java.util.Map<String, HorarioClase> nuevasClasesMap = new java.util.LinkedHashMap<>();
        if (req.getSlots() != null) {
            for (GuardarHorarioClaseRequest.HorarioClaseItemRequest slot : req.getSlots()) {
                if (slot.getFranjaHorariaId() == null || slot.getDiaSemana() == null) continue;
                FranjaHoraria franja = franjaHorariaRepository.findById(slot.getFranjaHorariaId())
                        .orElse(null);
                Docente docente = slot.getDocenteId() != null ? docenteRepository.findById(slot.getDocenteId()).orElse(null) : null;
                Materia materia = slot.getMateriaId() != null ? materiaRepository.findById(slot.getMateriaId()).orElse(null) : null;

                if (franja != null && docente != null) {
                    String slotKey = slot.getDiaSemana().trim().toLowerCase() + "_" + franja.getId();
                    HorarioClase hc = new HorarioClase(
                            docente,
                            slot.getDiaSemana(),
                            franja,
                            curso,
                            materia,
                            slot.getActividad(),
                            true
                    );
                    nuevasClasesMap.put(slotKey, hc);
                }
            }
        }

        List<HorarioClase> guardadas = horarioClaseRepository.saveAll(nuevasClasesMap.values());
        horarioClaseRepository.flush();
        return guardadas.stream().map(this::toDTO).collect(Collectors.toList());
    }

    public HorarioClaseDTO toDTO(HorarioClase hc) {
        HorarioClaseDTO dto = new HorarioClaseDTO();
        dto.setId(hc.getId());
        if (hc.getDocente() != null) {
            dto.setDocenteId(hc.getDocente().getId());
            dto.setDocenteNombre(hc.getDocente().getNombreCompleto());
        }
        dto.setDiaSemana(hc.getDiaSemana());
        if (hc.getFranjaHoraria() != null) {
            dto.setFranjaHorariaId(hc.getFranjaHoraria().getId());
            dto.setFranjaHorariaEtiqueta(hc.getFranjaHoraria().getEtiqueta());
        }
        if (hc.getCurso() != null) {
            dto.setCursoId(hc.getCurso().getId());
            dto.setCursoNombre(hc.getCurso().getNombre());
        }
        if (hc.getMateria() != null) {
            dto.setMateriaId(hc.getMateria().getId());
            dto.setMateriaNombre(hc.getMateria().getNombre());
        }
        dto.setActividad(hc.getActividad());
        dto.setEsClase(hc.isEsClase());
        return dto;
    }
}

