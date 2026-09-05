package com.sbsg.contingencias.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ReporteResponseDTO {
    private LocalDate fechaInicio;
    private LocalDate fechaFin;
    private Long totalContingencias = 0L;
    private BigDecimal totalPeriodos = BigDecimal.ZERO;
    private Long totalConRecursos = 0L;
    private Long totalSinRecursos = 0L;
    private List<DocenteEstadisticaDTO> resumenDocentesReemplazo = new ArrayList<>();
    private List<DocenteEstadisticaDTO> resumenDocentesAusentes = new ArrayList<>();
    private List<ContingenciaDTO> detalles = new ArrayList<>();

    public ReporteResponseDTO() {}

    public LocalDate getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(LocalDate fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public LocalDate getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(LocalDate fechaFin) {
        this.fechaFin = fechaFin;
    }

    public Long getTotalContingencias() {
        return totalContingencias;
    }

    public void setTotalContingencias(Long totalContingencias) {
        this.totalContingencias = totalContingencias;
    }

    public BigDecimal getTotalPeriodos() {
        return totalPeriodos;
    }

    public void setTotalPeriodos(BigDecimal totalPeriodos) {
        this.totalPeriodos = totalPeriodos;
    }

    public Long getTotalConRecursos() {
        return totalConRecursos;
    }

    public void setTotalConRecursos(Long totalConRecursos) {
        this.totalConRecursos = totalConRecursos;
    }

    public Long getTotalSinRecursos() {
        return totalSinRecursos;
    }

    public void setTotalSinRecursos(Long totalSinRecursos) {
        this.totalSinRecursos = totalSinRecursos;
    }

    public List<DocenteEstadisticaDTO> getResumenDocentesReemplazo() {
        return resumenDocentesReemplazo;
    }

    public void setResumenDocentesReemplazo(List<DocenteEstadisticaDTO> resumenDocentesReemplazo) {
        this.resumenDocentesReemplazo = resumenDocentesReemplazo;
    }

    public List<DocenteEstadisticaDTO> getResumenDocentesAusentes() {
        return resumenDocentesAusentes;
    }

    public void setResumenDocentesAusentes(List<DocenteEstadisticaDTO> resumenDocentesAusentes) {
        this.resumenDocentesAusentes = resumenDocentesAusentes;
    }

    public List<ContingenciaDTO> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<ContingenciaDTO> detalles) {
        this.detalles = detalles;
    }
}

