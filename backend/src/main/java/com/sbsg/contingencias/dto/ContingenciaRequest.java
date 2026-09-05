package com.sbsg.contingencias.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDate;

public class ContingenciaRequest {

    @NotNull(message = "La fecha es obligatoria")
    private LocalDate fecha;

    private String diaSemana;

    @NotNull(message = "El docente ausente es obligatorio")
    private Long docenteAusenteId;

    @NotNull(message = "El docente reemplazante es obligatorio")
    private Long docenteReemplazoId;

    @NotNull(message = "La franja horaria es obligatoria")
    private Long franjaHorariaId;

    @NotNull(message = "El curso es obligatorio")
    private Long cursoId;

    @NotNull(message = "La materia es obligatoria")
    private Long materiaId;

    private String recursos = "NO";

    private BigDecimal periodos = BigDecimal.valueOf(1);

    @NotBlank(message = "El motivo u observación es obligatorio")
    private String observacion;

    public ContingenciaRequest() {}

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public String getDiaSemana() {
        return diaSemana;
    }

    public void setDiaSemana(String diaSemana) {
        this.diaSemana = diaSemana;
    }

    public Long getDocenteAusenteId() {
        return docenteAusenteId;
    }

    public void setDocenteAusenteId(Long docenteAusenteId) {
        this.docenteAusenteId = docenteAusenteId;
    }

    public Long getDocenteReemplazoId() {
        return docenteReemplazoId;
    }

    public void setDocenteReemplazoId(Long docenteReemplazoId) {
        this.docenteReemplazoId = docenteReemplazoId;
    }

    public Long getFranjaHorariaId() {
        return franjaHorariaId;
    }

    public void setFranjaHorariaId(Long franjaHorariaId) {
        this.franjaHorariaId = franjaHorariaId;
    }

    public Long getCursoId() {
        return cursoId;
    }

    public void setCursoId(Long cursoId) {
        this.cursoId = cursoId;
    }

    public Long getMateriaId() {
        return materiaId;
    }

    public void setMateriaId(Long materiaId) {
        this.materiaId = materiaId;
    }

    public String getRecursos() {
        return recursos;
    }

    public void setRecursos(String recursos) {
        this.recursos = recursos;
    }

    public BigDecimal getPeriodos() {
        return periodos;
    }

    public void setPeriodos(BigDecimal periodos) {
        this.periodos = periodos;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }
}

