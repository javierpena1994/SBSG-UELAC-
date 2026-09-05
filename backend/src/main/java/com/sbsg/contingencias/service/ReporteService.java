package com.sbsg.contingencias.service;

import com.sbsg.contingencias.dto.ContingenciaDTO;
import com.sbsg.contingencias.dto.DocenteEstadisticaDTO;
import com.sbsg.contingencias.dto.ReporteResponseDTO;
import com.sbsg.contingencias.model.Contingencia;
import com.sbsg.contingencias.repository.ContingenciaRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ReporteService {

    private final ContingenciaRepository contingenciaRepository;
    private final ContingenciaService contingenciaService;

    public ReporteService(ContingenciaRepository contingenciaRepository, ContingenciaService contingenciaService) {
        this.contingenciaRepository = contingenciaRepository;
        this.contingenciaService = contingenciaService;
    }

    public ReporteResponseDTO generarReporte(
            LocalDate fechaInicio,
            LocalDate fechaFin,
            Long docenteAusenteId,
            Long docenteReemplazoId,
            Long cursoId,
            Long materiaId) {

        List<Contingencia> lista = contingenciaRepository.filtrarContingencias(
                fechaInicio, fechaFin, docenteAusenteId, docenteReemplazoId, cursoId, materiaId
        );

        ReporteResponseDTO reporte = new ReporteResponseDTO();
        reporte.setFechaInicio(fechaInicio);
        reporte.setFechaFin(fechaFin);
        reporte.setTotalContingencias((long) lista.size());

        BigDecimal totalPeriodos = BigDecimal.ZERO;
        long conRecursos = 0;
        long sinRecursos = 0;

        Map<String, BigDecimal> horasPorReemplazo = new HashMap<>();
        Map<String, Long> conteoPorReemplazo = new HashMap<>();

        Map<String, BigDecimal> horasPorAusente = new HashMap<>();
        Map<String, Long> conteoPorAusente = new HashMap<>();

        List<ContingenciaDTO> dtos = new ArrayList<>();

        for (Contingencia c : lista) {
            BigDecimal per = c.getPeriodos() != null ? c.getPeriodos() : BigDecimal.valueOf(1.0);
            totalPeriodos = totalPeriodos.add(per);

            if ("SI".equalsIgnoreCase(c.getRecursos())) {
                conRecursos++;
            } else {
                sinRecursos++;
            }

            // Agrupación reemplazantes
            String nomReemplazo = c.getDocenteReemplazo() != null ? c.getDocenteReemplazo().getNombreCompleto() : "Desconocido";
            horasPorReemplazo.put(nomReemplazo, horasPorReemplazo.getOrDefault(nomReemplazo, BigDecimal.ZERO).add(per));
            conteoPorReemplazo.put(nomReemplazo, conteoPorReemplazo.getOrDefault(nomReemplazo, 0L) + 1);

            // Agrupación ausentes
            String nomAusente = c.getDocenteAusente() != null ? c.getDocenteAusente().getNombreCompleto() : "Desconocido";
            horasPorAusente.put(nomAusente, horasPorAusente.getOrDefault(nomAusente, BigDecimal.ZERO).add(per));
            conteoPorAusente.put(nomAusente, conteoPorAusente.getOrDefault(nomAusente, 0L) + 1);

            dtos.add(contingenciaService.toDTO(c));
        }

        reporte.setTotalPeriodos(totalPeriodos);
        reporte.setTotalConRecursos(conRecursos);
        reporte.setTotalSinRecursos(sinRecursos);
        reporte.setDetalles(dtos);

        // Convertir resúmenes a lista ordenada
        List<DocenteEstadisticaDTO> resumenReemplazo = horasPorReemplazo.entrySet().stream()
                .map(e -> new DocenteEstadisticaDTO(e.getKey(), e.getValue(), conteoPorReemplazo.get(e.getKey())))
                .sorted((a, b) -> b.getTotalPeriodos().compareTo(a.getTotalPeriodos()))
                .collect(Collectors.toList());
        reporte.setResumenDocentesReemplazo(resumenReemplazo);

        List<DocenteEstadisticaDTO> resumenAusente = horasPorAusente.entrySet().stream()
                .map(e -> new DocenteEstadisticaDTO(e.getKey(), e.getValue(), conteoPorAusente.get(e.getKey())))
                .sorted((a, b) -> b.getTotalPeriodos().compareTo(a.getTotalPeriodos()))
                .collect(Collectors.toList());
        reporte.setResumenDocentesAusentes(resumenAusente);

        return reporte;
    }
}

