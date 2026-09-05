package com.sbsg.contingencias.dto;

public class HorarioClaseDTO {

    private Long id;
    private Long docenteId;
    private String docenteNombre;
    private String diaSemana;
    private Long franjaHorariaId;
    private String franjaHorariaEtiqueta;
    private Long cursoId;
    private String cursoNombre;
    private Long materiaId;
    private String materiaNombre;
    private String actividad;
    private boolean esClase;

    public HorarioClaseDTO() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getDocenteId() {
        return docenteId;
    }

    public void setDocenteId(Long docenteId) {
        this.docenteId = docenteId;
    }

    public String getDocenteNombre() {
        return docenteNombre;
    }

    public void setDocenteNombre(String docenteNombre) {
        this.docenteNombre = docenteNombre;
    }

    public String getDiaSemana() {
        return diaSemana;
    }

    public void setDiaSemana(String diaSemana) {
        this.diaSemana = diaSemana;
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

    public String getActividad() {
        return actividad;
    }

    public void setActividad(String actividad) {
        this.actividad = actividad;
    }

    public boolean isEsClase() {
        return esClase;
    }

    public void setEsClase(boolean esClase) {
        this.esClase = esClase;
    }
}

