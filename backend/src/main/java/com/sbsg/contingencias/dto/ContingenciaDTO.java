package com.sbsg.contingencias.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class ContingenciaDTO {
    private Long id;
    private LocalDate fecha;
    private String diaSemana;
    private Long docenteAusenteId;
    private String docenteAusenteNombre;
    private Long docenteReemplazoId;
    private String docenteReemplazoNombre;
    private Long franjaHorariaId;
    private String franjaHorariaEtiqueta;
    private Long cursoId;
    private String cursoNombre;
    private Long materiaId;
    private String materiaNombre;
    private String recursos;
    private BigDecimal periodos;
    private String observacion;
    private LocalDateTime createdAt;

    public ContingenciaDTO() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public String getDocenteAusenteNombre() {
        return docenteAusenteNombre;
    }

    public void setDocenteAusenteNombre(String docenteAusenteNombre) {
        this.docenteAusenteNombre = docenteAusenteNombre;
    }

    public Long getDocenteReemplazoId() {
        return docenteReemplazoId;
    }

    public void setDocenteReemplazoId(Long docenteReemplazoId) {
        this.docenteReemplazoId = docenteReemplazoId;
    }

    public String getDocenteReemplazoNombre() {
        return docenteReemplazoNombre;
    }

    public void setDocenteReemplazoNombre(String docenteReemplazoNombre) {
        this.docenteReemplazoNombre = docenteReemplazoNombre;
    }

    public Long getFranjaHorariaId() {
        return franjaHorariaId;
    }

    public void setFranjaHorariaId(Long franjaHorariaId) {
        this.franjaHorariaId = franjaHorariaId;
    }

    public String getFranjaHorariaEtiqueta() {
        return franjaHorariaEtiqueta;
    }

    public void setFranjaHorariaEtiqueta(String franjaHorariaEtiqueta) {
        this.franjaHorariaEtiqueta = franjaHorariaEtiqueta;
    }

    public Long getCursoId() {
        return cursoId;
    }

    public void setCursoId(Long cursoId) {
        this.cursoId = cursoId;
    }

    public String getCursoNombre() {
        return cursoNombre;
    }

    public void setCursoNombre(String cursoNombre) {
        this.cursoNombre = cursoNombre;
    }

    public Long getMateriaId() {
        return materiaId;
    }

    public void setMateriaId(Long materiaId) {
        this.materiaId = materiaId;
    }

    public String getMateriaNombre() {
        return materiaNombre;
    }

    public void setMateriaNombre(String materiaNombre) {
        this.materiaNombre = materiaNombre;
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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}

