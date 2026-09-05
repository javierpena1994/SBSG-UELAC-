package com.sbsg.contingencias.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "contingencias")
public class Contingencia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "fecha", nullable = false)
    private LocalDate fecha;

    @Column(name = "dia_semana", nullable = false, length = 20)
    private String diaSemana;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "docente_ausente_id", nullable = false)
    private Docente docenteAusente;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "docente_reemplazo_id", nullable = false)
    private Docente docenteReemplazo;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "franja_horaria_id", nullable = false)
    private FranjaHoraria franjaHoraria;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "curso_id", nullable = false)
    private Curso curso;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "materia_id", nullable = false)
    private Materia materia;

    @Column(name = "recursos", length = 10)
    private String recursos = "NO"; // "SI" o "NO"

    @Column(name = "periodos", precision = 4, scale = 1)
    private BigDecimal periodos = BigDecimal.valueOf(1.0);

    @Column(name = "observacion", columnDefinition = "TEXT")
    private String observacion;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    public Contingencia() {}

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

    public Docente getDocenteAusente() {
        return docenteAusente;
    }

    public void setDocenteAusente(Docente docenteAusente) {
        this.docenteAusente = docenteAusente;
    }

    public Docente getDocenteReemplazo() {
        return docenteReemplazo;
    }

    public void setDocenteReemplazo(Docente docenteReemplazo) {
        this.docenteReemplazo = docenteReemplazo;
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

