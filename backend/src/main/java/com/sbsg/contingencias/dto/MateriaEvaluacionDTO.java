package com.sbsg.contingencias.dto;

public class MateriaEvaluacionDTO {
    private Long id;
    private Long materiaId;
    private String materiaNombre;
    private String tipoComplejidad; // "DIFICIL" | "FACIL" (o "COMPLEJA" | "NO_COMPLEJA")
    private String dificultad;      // "DIFICIL" | "FACIL"
    private boolean seleccionada = true;
    private boolean tomaExamen = true;
    private String docenteNombre;
    private Integer horasSemanales = 1;

    public MateriaEvaluacionDTO() {}

    public MateriaEvaluacionDTO(Long id, Long materiaId, String materiaNombre, String tipoComplejidad, boolean seleccionada, String docenteNombre) {
        this.id = id;
        this.materiaId = materiaId;
        this.materiaNombre = materiaNombre;
        this.tipoComplejidad = tipoComplejidad != null ? tipoComplejidad : "DIFICIL";
        this.dificultad = normalizarDificultad(this.tipoComplejidad);
        this.seleccionada = seleccionada;
        this.tomaExamen = seleccionada;
        this.docenteNombre = docenteNombre;
    }

    public MateriaEvaluacionDTO(Long id, Long materiaId, String materiaNombre, String dificultad, boolean tomaExamen, String docenteNombre, Integer horasSemanales) {
        this.id = id;
        this.materiaId = materiaId;
        this.materiaNombre = materiaNombre;
        this.dificultad = normalizarDificultad(dificultad);
        this.tipoComplejidad = this.dificultad;
        this.tomaExamen = tomaExamen;
        this.seleccionada = tomaExamen;
        this.docenteNombre = docenteNombre;
        this.horasSemanales = horasSemanales != null ? horasSemanales : 1;
    }

    public static String normalizarDificultad(String dif) {
        if (dif == null) return "FACIL";
        String u = dif.trim().toUpperCase();
        if (u.equals("COMPLEJA") || u.equals("DIFICIL") || u.equals("DIFÍCIL")) return "DIFICIL";
        return "FACIL";
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
        return tipoComplejidad != null ? tipoComplejidad : dificultad;
    }

    public void setTipoComplejidad(String tipoComplejidad) {
        this.tipoComplejidad = tipoComplejidad;
        this.dificultad = normalizarDificultad(tipoComplejidad);
    }

    public String getDificultad() {
        return dificultad != null ? dificultad : normalizarDificultad(tipoComplejidad);
    }

    public void setDificultad(String dificultad) {
        this.dificultad = normalizarDificultad(dificultad);
        this.tipoComplejidad = this.dificultad;
    }

    public boolean isSeleccionada() {
        return seleccionada;
    }

    public void setSeleccionada(boolean seleccionada) {
        this.seleccionada = seleccionada;
        this.tomaExamen = seleccionada;
    }

    public boolean isTomaExamen() {
        return tomaExamen;
    }

    public void setTomaExamen(boolean tomaExamen) {
        this.tomaExamen = tomaExamen;
        this.seleccionada = tomaExamen;
    }

    public String getDocenteNombre() {
        return docenteNombre;
    }

    public void setDocenteNombre(String docenteNombre) {
        this.docenteNombre = docenteNombre;
    }

    public Integer getHorasSemanales() {
        return horasSemanales;
    }

    public void setHorasSemanales(Integer horasSemanales) {
        this.horasSemanales = horasSemanales;
    }
}

