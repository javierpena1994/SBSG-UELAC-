package com.sbsg.contingencias.model;

import jakarta.persistence.*;

@Entity
@Table(name = "horarios_clases")
public class HorarioClase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "docente_id", nullable = false)
    private Docente docente;

    @Column(name = "dia_semana", nullable = false, length = 20)
    private String diaSemana;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "franja_horaria_id", nullable = false)
    private FranjaHoraria franjaHoraria;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "curso_id", nullable = true)
    private Curso curso;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "materia_id", nullable = true)
    private Materia materia;

    @Column(name = "actividad", length = 150)
    private String actividad;

    @Column(name = "es_clase", nullable = false)
    private boolean esClase = true;

    public HorarioClase() {}

    public HorarioClase(Docente docente, String diaSemana, FranjaHoraria franjaHoraria, Curso curso, Materia materia, String actividad, boolean esClase) {
        this.docente = docente;
        this.diaSemana = diaSemana;
        this.franjaHoraria = franjaHoraria;
        this.curso = curso;
        this.materia = materia;
        this.actividad = actividad;
        this.esClase = esClase;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Docente getDocente() {
        return docente;
    }

    public void setDocente(Docente docente) {
        this.docente = docente;
    }

    public String getDiaSemana() {
        return diaSemana;
    }

    public void setDiaSemana(String diaSemana) {
        this.diaSemana = diaSemana;
    }

    public FranjaHoraria getFranjaHoraria() {
        return franjaHoraria;
    }

    public void setFranjaHoraria(FranjaHoraria franjaHoraria) {
        this.franjaHoraria = franjaHoraria;
    }

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
    }

    public Materia getMateria() {
        return materia;
    }

    public void setMateria(Materia materia) {
        this.materia = materia;
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

