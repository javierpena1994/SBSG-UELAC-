package com.sbsg.contingencias.service;

import com.sbsg.contingencias.dto.ContingenciaDTO;
import com.sbsg.contingencias.dto.ContingenciaRequest;
import com.sbsg.contingencias.model.*;
import com.sbsg.contingencias.repository.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ContingenciaService {

    private final ContingenciaRepository contingenciaRepository;
    private final DocenteRepository docenteRepository;
    private final FranjaHorariaRepository franjaHorariaRepository;
    private final CursoRepository cursoRepository;
    private final MateriaRepository materiaRepository;

    public ContingenciaService(
            ContingenciaRepository contingenciaRepository,
            DocenteRepository docenteRepository,
            FranjaHorariaRepository franjaHorariaRepository,
            CursoRepository cursoRepository,
            MateriaRepository materiaRepository) {
        this.contingenciaRepository = contingenciaRepository;
        this.docenteRepository = docenteRepository;
        this.franjaHorariaRepository = franjaHorariaRepository;
        this.cursoRepository = cursoRepository;
        this.materiaRepository = materiaRepository;
    }

    public List<ContingenciaDTO> obtenerRecientes() {
        return contingenciaRepository.findTop20ByOrderByFechaDescFranjaHorariaOrdenAscIdAsc().stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public List<ContingenciaDTO> filtrar(LocalDate fechaInicio, LocalDate fechaFin, Long docenteAusenteId, Long docenteReemplazoId, Long cursoId, Long materiaId) {
        return contingenciaRepository.filtrarContingencias(fechaInicio, fechaFin, docenteAusenteId, docenteReemplazoId, cursoId, materiaId)
                .stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public Page<ContingenciaDTO> filtrarPaginado(LocalDate fechaInicio, LocalDate fechaFin, Long docenteAusenteId, Long docenteReemplazoId, Long cursoId, Long materiaId, Pageable pageable) {
        return contingenciaRepository.filtrarContingenciasPaginado(fechaInicio, fechaFin, docenteAusenteId, docenteReemplazoId, cursoId, materiaId, pageable)
                .map(this::toDTO);
    }

    public ContingenciaDTO obtenerPorId(Long id) {
        Contingencia c = contingenciaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Contingencia no encontrada con ID: " + id));
        return toDTO(c);
    }

    @Transactional
    public ContingenciaDTO guardar(ContingenciaRequest req) {
        if (req.getDocenteAusenteId().equals(req.getDocenteReemplazoId())) {
            throw new IllegalArgumentException("El docente ausente y el docente que reemplaza no pueden ser la misma persona.");
        }

        // 1. Validar que no exista ya un reemplazo para el mismo curso, fecha y hora
        List<Contingencia> conflictoCurso = contingenciaRepository.findByFechaAndCursoIdAndFranjaHorariaId(
                req.getFecha(), req.getCursoId(), req.getFranjaHorariaId());
        if (!conflictoCurso.isEmpty()) {
            Contingencia cExistente = conflictoCurso.get(0);
            String nombreCurso = cExistente.getCurso() != null ? cExistente.getCurso().getNombre() : "seleccionado";
            String franjaHora = cExistente.getFranjaHoraria() != null ? cExistente.getFranjaHoraria().getEtiqueta() : "";
            String docenteAsignado = cExistente.getDocenteReemplazo() != null ? cExistente.getDocenteReemplazo().getNombreCompleto() : "N/A";
            throw new IllegalStateException(String.format(
                    "Ya fue asignado un docente de reemplazo para el curso '%s' en el horario '%s' el día %s (Docente asignado: %s).",
                    nombreCurso, franjaHora, cExistente.getFecha(), docenteAsignado
            ));
        }

        // 2. Validar que el docente que reemplaza no esté asignado a otro curso en esa misma hora y fecha
        List<Contingencia> conflictoDocente = contingenciaRepository.findByFechaAndDocenteReemplazoIdAndFranjaHorariaId(
                req.getFecha(), req.getDocenteReemplazoId(), req.getFranjaHorariaId());
        if (!conflictoDocente.isEmpty()) {
            Contingencia cExistente = conflictoDocente.get(0);
            String docente = cExistente.getDocenteReemplazo() != null ? cExistente.getDocenteReemplazo().getNombreCompleto() : "seleccionado";
            String curso = cExistente.getCurso() != null ? cExistente.getCurso().getNombre() : "";
            String franjaHora = cExistente.getFranjaHoraria() != null ? cExistente.getFranjaHoraria().getEtiqueta() : "";
            throw new IllegalStateException(String.format(
                    "El docente %s ya tiene asignado un reemplazo en el curso '%s' en el horario '%s' el día %s.",
                    docente, curso, franjaHora, cExistente.getFecha()
            ));
        }

        Docente docenteAusente = docenteRepository.findById(req.getDocenteAusenteId())
                .orElseThrow(() -> new RuntimeException("Docente ausente no encontrado con ID: " + req.getDocenteAusenteId()));

        Docente docenteReemplazo = docenteRepository.findById(req.getDocenteReemplazoId())
                .orElseThrow(() -> new RuntimeException("Docente de reemplazo no encontrado con ID: " + req.getDocenteReemplazoId()));

        FranjaHoraria franja = franjaHorariaRepository.findById(req.getFranjaHorariaId())
                .orElseThrow(() -> new RuntimeException("Franja horaria no encontrada con ID: " + req.getFranjaHorariaId()));

        Curso curso = cursoRepository.findById(req.getCursoId())
                .orElseThrow(() -> new RuntimeException("Curso no encontrado con ID: " + req.getCursoId()));

        Materia materia = materiaRepository.findById(req.getMateriaId())
                .orElseThrow(() -> new RuntimeException("Materia no encontrada con ID: " + req.getMateriaId()));

        if (req.getObservacion() == null || req.getObservacion().trim().isEmpty()) {
            throw new IllegalArgumentException("El motivo u observación es obligatorio.");
        }

        BigDecimal periodos = req.getPeriodos() != null
                ? BigDecimal.valueOf(req.getPeriodos().intValue())
                : BigDecimal.valueOf(1);

        Contingencia c = new Contingencia();
        c.setFecha(req.getFecha());
        c.setDiaSemana(DisponibilidadService.obtenerDiaSemanaEnEspanol(req.getFecha()));
        c.setDocenteAusente(docenteAusente);
        c.setDocenteReemplazo(docenteReemplazo);
        c.setFranjaHoraria(franja);
        c.setCurso(curso);
        c.setMateria(materia);
        c.setRecursos(req.getRecursos() != null && req.getRecursos().equalsIgnoreCase("SI") ? "SI" : "NO");
        c.setPeriodos(periodos);
        c.setObservacion(req.getObservacion().trim());

        Contingencia guardada = contingenciaRepository.save(c);
        return toDTO(guardada);
    }

    @Transactional
    public List<ContingenciaDTO> guardarLote(List<ContingenciaRequest> requests) {
        if (requests == null || requests.isEmpty()) {
            throw new IllegalArgumentException("La lista de contingencias a registrar no puede estar vacía.");
        }
        return requests.stream()
                .map(this::guardar)
                .collect(Collectors.toList());
    }

    @Transactional
    public ContingenciaDTO actualizar(Long id, ContingenciaRequest req) {
        Contingencia c = contingenciaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Contingencia no encontrada con ID: " + id));

        if (req.getObservacion() == null || req.getObservacion().trim().isEmpty()) {
            throw new IllegalArgumentException("El motivo u observación es obligatorio.");
        }

        // 1. Validar conflicto de curso
        List<Contingencia> conflictoCurso = contingenciaRepository.findByFechaAndCursoIdAndFranjaHorariaId(
                req.getFecha(), req.getCursoId(), req.getFranjaHorariaId());
        for (Contingencia cExistente : conflictoCurso) {
            if (!cExistente.getId().equals(id)) {
                String nombreCurso = cExistente.getCurso() != null ? cExistente.getCurso().getNombre() : "seleccionado";
                String franjaHora = cExistente.getFranjaHoraria() != null ? cExistente.getFranjaHoraria().getEtiqueta() : "";
                String docenteAsignado = cExistente.getDocenteReemplazo() != null ? cExistente.getDocenteReemplazo().getNombreCompleto() : "N/A";
                throw new IllegalStateException(String.format(
                        "Ya fue asignado un docente de reemplazo para el curso '%s' en el horario '%s' el día %s (Docente asignado: %s).",
                        nombreCurso, franjaHora, cExistente.getFecha(), docenteAsignado
                ));
            }
        }

        // 2. Validar conflicto de docente
        List<Contingencia> conflictoDocente = contingenciaRepository.findByFechaAndDocenteReemplazoIdAndFranjaHorariaId(
                req.getFecha(), req.getDocenteReemplazoId(), req.getFranjaHorariaId());
        for (Contingencia cExistente : conflictoDocente) {
            if (!cExistente.getId().equals(id)) {
                String docente = cExistente.getDocenteReemplazo() != null ? cExistente.getDocenteReemplazo().getNombreCompleto() : "seleccionado";
                String curso = cExistente.getCurso() != null ? cExistente.getCurso().getNombre() : "";
                String franjaHora = cExistente.getFranjaHoraria() != null ? cExistente.getFranjaHoraria().getEtiqueta() : "";
                throw new IllegalStateException(String.format(
                        "El docente %s ya tiene asignado un reemplazo en el curso '%s' en el horario '%s' el día %s.",
                        docente, curso, franjaHora, cExistente.getFecha()
                ));
            }
        }

        Docente docenteAusente = docenteRepository.findById(req.getDocenteAusenteId())
                .orElseThrow(() -> new RuntimeException("Docente ausente no encontrado"));
        Docente docenteReemplazo = docenteRepository.findById(req.getDocenteReemplazoId())
                .orElseThrow(() -> new RuntimeException("Docente de reemplazo no encontrado"));
        FranjaHoraria franja = franjaHorariaRepository.findById(req.getFranjaHorariaId())
                .orElseThrow(() -> new RuntimeException("Franja horaria no encontrada"));
        Curso curso = cursoRepository.findById(req.getCursoId())
                .orElseThrow(() -> new RuntimeException("Curso no encontrado"));
        Materia materia = materiaRepository.findById(req.getMateriaId())
                .orElseThrow(() -> new RuntimeException("Materia no encontrada"));

        BigDecimal periodos = req.getPeriodos() != null
                ? BigDecimal.valueOf(req.getPeriodos().intValue())
                : BigDecimal.valueOf(1);

        c.setFecha(req.getFecha());
        c.setDiaSemana(DisponibilidadService.obtenerDiaSemanaEnEspanol(req.getFecha()));
        c.setDocenteAusente(docenteAusente);
        c.setDocenteReemplazo(docenteReemplazo);
        c.setFranjaHoraria(franja);
        c.setCurso(curso);
        c.setMateria(materia);
        c.setRecursos(req.getRecursos() != null && req.getRecursos().equalsIgnoreCase("SI") ? "SI" : "NO");
        c.setPeriodos(periodos);
        c.setObservacion(req.getObservacion().trim());

        return toDTO(contingenciaRepository.save(c));
    }

    @Transactional
    public void eliminar(Long id) {
        if (!contingenciaRepository.existsById(id)) {
            throw new RuntimeException("Contingencia no encontrada con ID: " + id);
        }
        contingenciaRepository.deleteById(id);
    }

    public ContingenciaDTO toDTO(Contingencia c) {
        ContingenciaDTO dto = new ContingenciaDTO();
        dto.setId(c.getId());
        dto.setFecha(c.getFecha());
        dto.setDiaSemana(c.getDiaSemana());

        if (c.getDocenteAusente() != null) {
            dto.setDocenteAusenteId(c.getDocenteAusente().getId());
            dto.setDocenteAusenteNombre(c.getDocenteAusente().getNombreCompleto());
        }

        if (c.getDocenteReemplazo() != null) {
            dto.setDocenteReemplazoId(c.getDocenteReemplazo().getId());
            dto.setDocenteReemplazoNombre(c.getDocenteReemplazo().getNombreCompleto());
        }

        if (c.getFranjaHoraria() != null) {
            dto.setFranjaHorariaId(c.getFranjaHoraria().getId());
            dto.setFranjaHorariaEtiqueta(c.getFranjaHoraria().getEtiqueta());
        }

        if (c.getCurso() != null) {
            dto.setCursoId(c.getCurso().getId());
            dto.setCursoNombre(c.getCurso().getNombre());
        }

        if (c.getMateria() != null) {
            dto.setMateriaId(c.getMateria().getId());
            dto.setMateriaNombre(c.getMateria().getNombre());
        }

        dto.setRecursos(c.getRecursos());
        dto.setPeriodos(c.getPeriodos());
        dto.setObservacion(c.getObservacion());
        dto.setCreatedAt(c.getCreatedAt());
        return dto;
    }
}

