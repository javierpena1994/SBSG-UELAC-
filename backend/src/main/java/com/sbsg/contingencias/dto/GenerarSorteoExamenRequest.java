package com.sbsg.contingencias.dto;

import java.time.LocalDate;
import java.util.List;

public class GenerarSorteoExamenRequest {
    private Long cursoId;
    private String titulo;
    private LocalDate fechaInicio;
    private Integer numDias;
    private Integer materiasPorDia = 2;
    private List<MateriaEvaluacionDTO> materias;
    private boolean saltarFinesDeSemana = true;
    private String horaInicio1 = "07h30";
    private String horaFin1 = "08h50";
    private String horaInicio2 = "09h10";
    private String horaFin2 = "10h30";

    public GenerarSorteoExamenRequest() {}

    public Long getCursoId() {
        return cursoId;
    }

    public void setCursoId(Long cursoId) {
        this.cursoId = cursoId;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public LocalDate getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(LocalDate fechaInicio) {
        this.fechaInicio = fechaInicio;
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

    public List<MateriaEvaluacionDTO> getMaterias() {
        return materias;
    }

    public void setMaterias(List<MateriaEvaluacionDTO> materias) {
        this.materias = materias;
    }

    public boolean isSaltarFinesDeSemana() {
        return saltarFinesDeSemana;
    }

    public void setSaltarFinesDeSemana(boolean saltarFinesDeSemana) {
        this.saltarFinesDeSemana = saltarFinesDeSemana;
    }

    public String getHoraInicio1() {
        return horaInicio1;
    }

    public void setHoraInicio1(String horaInicio1) {
        this.horaInicio1 = horaInicio1;
    }

    public String getHoraFin1() {
        return horaFin1;
    }

    public void setHoraFin1(String horaFin1) {
        this.horaFin1 = horaFin1;
    }

    public String getHoraInicio2() {
        return horaInicio2;
    }

    public void setHoraInicio2(String horaInicio2) {
        this.horaInicio2 = horaInicio2;
    }

    public String getHoraFin2() {
        return horaFin2;
    }

    public void setHoraFin2(String horaFin2) {
        this.horaFin2 = horaFin2;
    }
}

