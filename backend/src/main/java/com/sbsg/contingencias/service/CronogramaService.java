package com.sbsg.contingencias.service;

import com.sbsg.contingencias.dto.ActividadCronogramaDTO;
import com.sbsg.contingencias.model.ActividadCronograma;
import com.sbsg.contingencias.repository.ActividadCronogramaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CronogramaService {

    private final ActividadCronogramaRepository actividadRepository;

    public CronogramaService(ActividadCronogramaRepository actividadRepository) {
        this.actividadRepository = actividadRepository;
    }

    public List<ActividadCronogramaDTO> obtenerTodas() {
        return actividadRepository.findAllByOrderByFechaInicioAscHoraInicioAsc().stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public List<ActividadCronogramaDTO> obtenerPorRango(LocalDate fechaInicio, LocalDate fechaFin) {
        if (fechaInicio == null || fechaFin == null) {
            return obtenerTodas();
        }
        return actividadRepository.findActividadesEnRango(fechaInicio, fechaFin).stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public List<ActividadCronogramaDTO> filtrar(String categoria, String estado, String dirigidoA) {
        String cat = (categoria != null && !categoria.trim().isEmpty() && !categoria.equalsIgnoreCase("TODAS")) ? categoria.trim() : null;
        String est = (estado != null && !estado.trim().isEmpty() && !estado.equalsIgnoreCase("TODOS")) ? estado.trim() : null;
        String dir = (dirigidoA != null && !dirigidoA.trim().isEmpty() && !dirigidoA.equalsIgnoreCase("TODOS")) ? dirigidoA.trim() : null;

        return actividadRepository.filtrarActividades(cat, est, dir).stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public ActividadCronogramaDTO obtenerPorId(Long id) {
        ActividadCronograma a = actividadRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Actividad no encontrada con ID: " + id));
        return toDTO(a);
    }

    @Transactional
    public ActividadCronogramaDTO guardar(ActividadCronogramaDTO dto) {
        if (dto.getTitulo() == null || dto.getTitulo().trim().isEmpty()) {
            throw new IllegalArgumentException("El título de la actividad es obligatorio.");
        }
        if (dto.getFechaInicio() == null) {
            throw new IllegalArgumentException("La fecha de inicio es obligatoria.");
        }

        LocalDate fFin = dto.getFechaFin() != null ? dto.getFechaFin() : dto.getFechaInicio();
        if (fFin.isBefore(dto.getFechaInicio())) {
            fFin = dto.getFechaInicio();
        }

        String color = dto.getColor() != null && !dto.getColor().trim().isEmpty()
                ? dto.getColor().trim()
                : sugerirColorPorCategoria(dto.getCategoria());

        ActividadCronograma a = new ActividadCronograma(
                dto.getTitulo().trim(),
                dto.getDescripcion(),
                dto.getFechaInicio(),
                fFin,
                dto.getHoraInicio(),
                dto.getHoraFin(),
                dto.getCategoria() != null ? dto.getCategoria() : "ACADEMICO",
                dto.getResponsable(),
                dto.getDirigidoA() != null ? dto.getDirigidoA() : "TODOS",
                dto.getEstado() != null ? dto.getEstado() : "PLANIFICADO",
                color
        );

        ActividadCronograma guardada = actividadRepository.save(a);
        return toDTO(guardada);
    }

    @Transactional
    public ActividadCronogramaDTO actualizar(Long id, ActividadCronogramaDTO dto) {
        ActividadCronograma a = actividadRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Actividad no encontrada con ID: " + id));

        if (dto.getTitulo() == null || dto.getTitulo().trim().isEmpty()) {
            throw new IllegalArgumentException("El título de la actividad es obligatorio.");
        }
        if (dto.getFechaInicio() == null) {
            throw new IllegalArgumentException("La fecha de inicio es obligatoria.");
        }

        LocalDate fFin = dto.getFechaFin() != null ? dto.getFechaFin() : dto.getFechaInicio();
        if (fFin.isBefore(dto.getFechaInicio())) {
            fFin = dto.getFechaInicio();
        }

        a.setTitulo(dto.getTitulo().trim());
        a.setDescripcion(dto.getDescripcion());
        a.setFechaInicio(dto.getFechaInicio());
        a.setFechaFin(fFin);
        a.setHoraInicio(dto.getHoraInicio());
        a.setHoraFin(dto.getHoraFin());
        a.setCategoria(dto.getCategoria() != null ? dto.getCategoria() : a.getCategoria());
        a.setResponsable(dto.getResponsable());
        a.setDirigidoA(dto.getDirigidoA() != null ? dto.getDirigidoA() : a.getDirigidoA());
        a.setEstado(dto.getEstado() != null ? dto.getEstado() : a.getEstado());

        if (dto.getColor() != null && !dto.getColor().trim().isEmpty()) {
            a.setColor(dto.getColor().trim());
        }

        return toDTO(actividadRepository.save(a));
    }

    @Transactional
    public void eliminar(Long id) {
        if (!actividadRepository.existsById(id)) {
            throw new RuntimeException("Actividad no encontrada con ID: " + id);
        }
        actividadRepository.deleteById(id);
    }

    private String sugerirColorPorCategoria(String categoria) {
        if (categoria == null) return "#2563eb";
        return switch (categoria.toUpperCase()) {
            case "ACADEMICO", "EVALUACION" -> "#2563eb"; // Azul
            case "CIVICO_CULTURAL" -> "#16a34a"; // Verde
            case "DEPORTIVO" -> "#ea580c"; // Naranja
            case "PASTORAL", "INSTITUCIONAL" -> "#9333ea"; // Morado
            case "FERIADO" -> "#dc2626"; // Rojo
            case "REUNION_PADRES" -> "#ca8a04"; // Amarillo/Dorado
            default -> "#0284c7";
        };
    }

    public ActividadCronogramaDTO toDTO(ActividadCronograma a) {
        ActividadCronogramaDTO dto = new ActividadCronogramaDTO();
        dto.setId(a.getId());
        dto.setTitulo(a.getTitulo());
        dto.setDescripcion(a.getDescripcion());
        dto.setFechaInicio(a.getFechaInicio());
        dto.setFechaFin(a.getFechaFin());
        dto.setHoraInicio(a.getHoraInicio());
        dto.setHoraFin(a.getHoraFin());
        dto.setCategoria(a.getCategoria());
        dto.setResponsable(a.getResponsable());
        dto.setDirigidoA(a.getDirigidoA());
        dto.setEstado(a.getEstado());
        dto.setColor(a.getColor());
        dto.setCreatedAt(a.getCreatedAt());
        return dto;
    }
}

