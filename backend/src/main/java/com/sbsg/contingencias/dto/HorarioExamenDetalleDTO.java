package com.sbsg.contingencias.dto;

import java.time.LocalDate;

public class HorarioExamenDetalleDTO {
    private Long id;
    private Integer diaNumero;
    private LocalDate fecha;
    private String diaSemana;
    private Integer ordenDia; // 1 o 2
    private Long materiaId;
    private String materiaNombre;
    private String tipoComplejidad; // "COMPLEJA" | "NO_COMPLEJA"
    private String horaInicio;
    private String horaFin;
    private String docenteSupervisor;

    public HorarioExamenDetalleDTO() {}

    public HorarioExamenDetalleDTO(Long id, Integer diaNumero, LocalDate fecha, String diaSemana, Integer ordenDia, Long materiaId, String materiaNombre, String tipoComplejidad, String horaInicio, String horaFin, String docenteSupervisor) {
        this.id = id;
        this.diaNumero = diaNumero;
        this.fecha = fecha;
        this.diaSemana = diaSemana;
        this.ordenDia = ordenDia;
        this.materiaId = materiaId;
        this.materiaNombre = materiaNombre;
        this.tipoComplejidad = tipoComplejidad;
        this.horaInicio = horaInicio;
        this.horaFin = horaFin;
        this.docenteSupervisor = docenteSupervisor;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getDiaNumero() {
        return diaNumero;
    }

    public void setDiaNumero(Integer diaNumero) {
        this.diaNumero = diaNumero;
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

    public Integer getOrdenDia() {
        return ordenDia;
    }

    public void setOrdenDia(Integer ordenDia) {
        this.ordenDia = ordenDia;
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

    public String getTipoComplejidad() {
        return tipoComplejidad;
    }

    public void setTipoComplejidad(String tipoComplejidad) {
        this.tipoComplejidad = tipoComplejidad;
    }

    public String getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(String horaInicio) {
        this.horaInicio = horaInicio;
    }

    public String getHoraFin() {
        return horaFin;
    }

    public void setHoraFin(String horaFin) {
        this.horaFin = horaFin;
    }

    public String getDocenteSupervisor() {
        return docenteSupervisor;
    }

    public void setDocenteSupervisor(String docenteSupervisor) {
        this.docenteSupervisor = docenteSupervisor;
    }
}

