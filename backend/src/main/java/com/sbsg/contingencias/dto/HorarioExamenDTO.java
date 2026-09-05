package com.sbsg.contingencias.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class HorarioExamenDTO {
    private Long id;
    private String titulo;
    private Long cursoId;
    private String cursoNombre;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;
    private Integer numDias;
    private Integer materiasPorDia = 2;
    private String observaciones;
    private LocalDateTime createdAt;
    private List<HorarioExamenDetalleDTO> detalles = new ArrayList<>();

    public HorarioExamenDTO() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
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

    public Integer getNumDias() {
        return numDias;
    }

    public void setNumDias(Integer numDias) {
        this.numDias = numDias;
    }

    public Integer getMateriasPorDia() {
        return materiasPorDia;
    }

    public void setMateriasPorDia(Integer materiasPorDia) {
        this.materiasPorDia = materiasPorDia;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public List<HorarioExamenDetalleDTO> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<HorarioExamenDetalleDTO> detalles) {
        this.detalles = detalles;
    }
}

