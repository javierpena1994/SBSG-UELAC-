package com.sbsg.contingencias.dto;

public class MateriaEvaluacionDTO {
    private Long id;
    private Long materiaId;
    private String materiaNombre;
    private String tipoComplejidad; // "COMPLEJA" | "NO_COMPLEJA"
    private boolean seleccionada = true;
    private String docenteNombre;

    public MateriaEvaluacionDTO() {}

    public MateriaEvaluacionDTO(Long id, Long materiaId, String materiaNombre, String tipoComplejidad, boolean seleccionada, String docenteNombre) {
        this.id = id;
        this.materiaId = materiaId;
        this.materiaNombre = materiaNombre;
        this.tipoComplejidad = tipoComplejidad != null ? tipoComplejidad : "COMPLEJA";
        this.seleccionada = seleccionada;
        this.docenteNombre = docenteNombre;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public boolean isSeleccionada() {
        return seleccionada;
    }

    public void setSeleccionada(boolean seleccionada) {
        this.seleccionada = seleccionada;
    }

    public String getDocenteNombre() {
        return docenteNombre;
    }

    public void setDocenteNombre(String docenteNombre) {
        this.docenteNombre = docenteNombre;
    }
}

