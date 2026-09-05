package com.sbsg.contingencias.service;

import com.sbsg.contingencias.dto.DocenteDisponibleDTO;
import com.sbsg.contingencias.dto.HorarioSlotDTO;
import com.sbsg.contingencias.model.Contingencia;
import com.sbsg.contingencias.model.Docente;
import com.sbsg.contingencias.model.FranjaHoraria;
import com.sbsg.contingencias.model.HorarioDisponibilidad;
import com.sbsg.contingencias.repository.ContingenciaRepository;
import com.sbsg.contingencias.repository.DocenteRepository;
import com.sbsg.contingencias.repository.FranjaHorariaRepository;
import com.sbsg.contingencias.repository.HorarioDisponibilidadRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class DisponibilidadService {

    private final HorarioDisponibilidadRepository disponibilidadRepository;
    private final ContingenciaRepository contingenciaRepository;
    private final DocenteRepository docenteRepository;
    private final FranjaHorariaRepository franjaHorariaRepository;
    private final com.sbsg.contingencias.repository.HorarioClaseRepository horarioClaseRepository;
    private final com.sbsg.contingencias.repository.CursoRepository cursoRepository;

    public DisponibilidadService(
            HorarioDisponibilidadRepository disponibilidadRepository,
            ContingenciaRepository contingenciaRepository,
            DocenteRepository docenteRepository,
            FranjaHorariaRepository franjaHorariaRepository,
            com.sbsg.contingencias.repository.HorarioClaseRepository horarioClaseRepository,
            com.sbsg.contingencias.repository.CursoRepository cursoRepository) {
        this.disponibilidadRepository = disponibilidadRepository;
        this.contingenciaRepository = contingenciaRepository;
        this.docenteRepository = docenteRepository;
        this.franjaHorariaRepository = franjaHorariaRepository;
        this.horarioClaseRepository = horarioClaseRepository;
        this.cursoRepository = cursoRepository;
    }

    public static String obtenerDiaSemanaEnEspanol(LocalDate fecha) {
        DayOfWeek dow = fecha.getDayOfWeek();
        return switch (dow) {
            case MONDAY -> "Lunes";
            case TUESDAY -> "Martes";
            case WEDNESDAY -> "Miércoles";
            case THURSDAY -> "Jueves";
            case FRIDAY -> "Viernes";
            case SATURDAY -> "Sábado";
            case SUNDAY -> "Domingo";
        };
    }

    public List<DocenteDisponibleDTO> buscarDocentesParaReemplazo(LocalDate fecha, Long franjaHorariaId, Long docenteAusenteId) {
        return buscarDocentesParaReemplazo(fecha, franjaHorariaId, docenteAusenteId, null);
    }

    public List<DocenteDisponibleDTO> buscarDocentesParaReemplazo(LocalDate fecha, Long franjaHorariaId, Long docenteAusenteId, Long cursoId) {
        if (fecha == null || franjaHorariaId == null) {
            return Collections.emptyList();
        }

        String diaSemana = obtenerDiaSemanaEnEspanol(fecha);

        // Nivel pedagógico del curso para el que se busca reemplazo
        String nivelCursoReemplazo = null;
        if (cursoId != null) {
            nivelCursoReemplazo = cursoRepository.findById(cursoId)
                    .map(com.sbsg.contingencias.model.Curso::getNivel)
                    .orElse(null);
        }

        // 1. Obtener todos los docentes que tienen libre esa franja según el horario (Filtro)
        List<HorarioDisponibilidad> libresPorHorario = disponibilidadRepository.findDisponiblesPorDiaYFranja(diaSemana, franjaHorariaId);
        Set<Long> idsLibresPorHorario = libresPorHorario.stream()
                .map(h -> h.getDocente().getId())
                .collect(Collectors.toSet());

        // 2. Obtener contingencias ya registradas en esa misma fecha y franja horaria
        List<Contingencia> contingenciasEnMismaHora = contingenciaRepository.findByFechaAndFranjaHorariaId(fecha, franjaHorariaId);
        Set<Long> idsOcupadosPorContingencia = contingenciasEnMismaHora.stream()
                .map(c -> c.getDocenteReemplazo().getId())
                .collect(Collectors.toSet());

        // 3. Obtener todos los docentes activos
        List<Docente> todosDocentes = docenteRepository.findByActivoTrueOrderByNombreCompletoAsc();

        LocalDate hace30Dias = fecha.minusDays(30);

        List<DocenteDisponibleDTO> resultado = new ArrayList<>();

        for (Docente d : todosDocentes) {
            // Ignorar al docente ausente
            if (docenteAusenteId != null && d.getId().equals(docenteAusenteId)) {
                continue;
            }

            boolean libreHorario = idsLibresPorHorario.contains(d.getId());
            boolean ocupadoContingencia = idsOcupadosPorContingencia.contains(d.getId());

            // Contar reemplazos en los últimos 30 días para balancear carga
            Long reemplazosRecientes = contingenciaRepository.countReemplazosRecientes(d.getId(), hace30Dias);

            // Analizar el nivel del docente según sus clases activas
            List<com.sbsg.contingencias.model.HorarioClase> clasesDocente = horarioClaseRepository.findByDocenteId(d.getId());
            List<com.sbsg.contingencias.model.HorarioClase> clasesActivas = clasesDocente.stream()
                    .filter(c -> c.isEsClase() && c.getCurso() != null)
                    .toList();

            long totalHorasClaseDocente = clasesDocente.stream()
                    .filter(com.sbsg.contingencias.model.HorarioClase::isEsClase)
                    .count();

            String categoriaPrioridad;
            int ordenPrioridad;
            String nivelDocente;
            String explicacionPrioridad;

            if (totalHorasClaseDocente == 0) {
                // Caso 3: Autoridad / Personal con todo el horario libre (0 horas clase en la semana)
                categoriaPrioridad = "AUTORIDAD";
                ordenPrioridad = 3;
                nivelDocente = "Autoridad / Apoyo";
                explicacionPrioridad = "Autoridad / Horario administrativo libre";
            } else if (clasesActivas.isEmpty()) {
                // Docente que tiene horas de clase pero aún no tiene curso específico en las celdas
                categoriaPrioridad = "OTRO_NIVEL";
                ordenPrioridad = 2;
                nivelDocente = "Docente de Aula";
                explicacionPrioridad = "Docente activo";
            } else {
                Set<String> nivelesImparte = clasesActivas.stream()
                        .map(c -> c.getCurso().getNivel())
                        .filter(Objects::nonNull)
                        .collect(Collectors.toCollection(TreeSet::new));

                nivelDocente = String.join(" / ", nivelesImparte);

                if (nivelCursoReemplazo != null && nivelesImparte.contains(nivelCursoReemplazo)) {
                    // Caso 1: Prioridad Máxima (Docente del mismo nivel)
                    categoriaPrioridad = "MISMO_NIVEL";
                    ordenPrioridad = 1;
                    explicacionPrioridad = "Docente del mismo nivel (Nivel " + nivelCursoReemplazo + ")";
                } else {
                    // Caso 2: Docente activo de otro nivel
                    categoriaPrioridad = "OTRO_NIVEL";
                    ordenPrioridad = 2;
                    explicacionPrioridad = "Docente de otro nivel (" + nivelDocente + ")";
                }
            }

            String estado;
            if (ocupadoContingencia) {
                estado = "OCUPADO (En otra contingencia)";
            } else if (libreHorario) {
                estado = "DISPONIBLE (" + explicacionPrioridad + ")";
            } else {
                estado = "NO DISPONIBLE (En clases regulares)";
            }

            DocenteDisponibleDTO dto = new DocenteDisponibleDTO(
                    d.getId(),
                    d.getNombreCompleto(),
                    d.getNombreCorto(),
                    libreHorario,
                    ocupadoContingencia,
                    reemplazosRecientes,
                    estado,
                    categoriaPrioridad,
                    ordenPrioridad,
                    nivelDocente,
                    explicacionPrioridad
            );
            resultado.add(dto);
        }

        // Ordenar con la jerarquía estricta:
        // 1. Docentes disponibles según horario y no en otra contingencia primero
        // 2. Por orden de prioridad pedagógica: MISMO_NIVEL (1) -> OTRO_NIVEL (2) -> AUTORIDAD (3)
        // 3. Por carga de trabajo reciente: menos reemplazos primero (rotación justa)
        // 4. Por nombre alfabético
        resultado.sort((a, b) -> {
            boolean aApto = a.isDisponibleSegunHorario() && !a.isOcupadoPorOtraContingencia();
            boolean bApto = b.isDisponibleSegunHorario() && !b.isOcupadoPorOtraContingencia();

            if (aApto && !bApto) return -1;
            if (!aApto && bApto) return 1;

            if (aApto && bApto) {
                // Comparar prioridad de nivel
                int compPrioridad = Integer.compare(a.getOrdenPrioridad(), b.getOrdenPrioridad());
                if (compPrioridad != 0) return compPrioridad;

                // Comparar carga reciente
                int compCarga = Long.compare(a.getTotalReemplazosRecientes(), b.getTotalReemplazosRecientes());
                if (compCarga != 0) return compCarga;
            }

            return a.getNombreCompleto().compareToIgnoreCase(b.getNombreCompleto());
        });

        return resultado;
    }

    public List<HorarioDisponibilidad> obtenerDisponibilidadPorDocente(Long docenteId) {
        return disponibilidadRepository.findByDocenteIdOrderByDiaSemanaAsc(docenteId);
    }

    public List<HorarioDisponibilidad> obtenerTodosLosHorarios() {
        return disponibilidadRepository.findAll();
    }

    @Transactional
    public void guardarHorarioDocente(Long docenteId, List<HorarioSlotDTO> slots) {
        Docente docente = docenteRepository.findById(docenteId)
                .orElseThrow(() -> new RuntimeException("Docente no encontrado con ID: " + docenteId));

        disponibilidadRepository.deleteByDocenteId(docenteId);

        if (slots != null && !slots.isEmpty()) {
            for (HorarioSlotDTO slot : slots) {
                FranjaHoraria franja = franjaHorariaRepository.findById(slot.getFranjaHorariaId())
                        .orElseThrow(() -> new RuntimeException("Franja horaria no encontrada: " + slot.getFranjaHorariaId()));
                disponibilidadRepository.save(new HorarioDisponibilidad(docente, slot.getDiaSemana(), franja));
            }
        }
    }

    @Transactional
    public boolean toggleSlot(Long docenteId, String diaSemana, Long franjaHorariaId) {
        Docente docente = docenteRepository.findById(docenteId)
                .orElseThrow(() -> new RuntimeException("Docente no encontrado con ID: " + docenteId));
        FranjaHoraria franja = franjaHorariaRepository.findById(franjaHorariaId)
                .orElseThrow(() -> new RuntimeException("Franja horaria no encontrada: " + franjaHorariaId));

        Optional<HorarioDisponibilidad> opt = disponibilidadRepository.findByDocenteIdAndDiaSemanaIgnoreCaseAndFranjaHorariaId(
                docenteId, diaSemana, franjaHorariaId
        );

        if (opt.isPresent()) {
            disponibilidadRepository.delete(opt.get());
            return false; // Ahora está ocupado/desmarcado
        } else {
            disponibilidadRepository.save(new HorarioDisponibilidad(docente, diaSemana, franja));
            return true; // Ahora está libre/marcado
        }
    }

    @Transactional
    public void limpiarTodosLosHorarios() {
        disponibilidadRepository.deleteAll();
    }
}
