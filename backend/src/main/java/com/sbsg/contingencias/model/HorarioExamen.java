package com.sbsg.contingencias.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "horarios_examenes")
public class HorarioExamen {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "titulo", nullable = false, length = 200)
    private String titulo;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "curso_id", nullable = true)
    private Curso curso;

    @Column(name = "fecha_inicio", nullable = false)
    private LocalDate fechaInicio;

    @Column(name = "fecha_fin", nullable = false)
    private LocalDate fechaFin;

    @Column(name = "num_dias", nullable = false)
    private Integer numDias;

    @Column(name = "materias_por_dia", nullable = false)
    private Integer materiasPorDia = 2;

    @Column(name = "observaciones", columnDefinition = "TEXT")
    private String observaciones;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @OneToMany(mappedBy = "horarioExamen", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("diaNumero ASC, ordenDia ASC")
    private List<HorarioExamenDetalle> detalles = new ArrayList<>();

    public HorarioExamen() {}

    public HorarioExamen(String titulo, Curso curso, LocalDate fechaInicio, LocalDate fechaFin, Integer numDias, Integer materiasPorDia, String observaciones) {
        this.titulo = titulo;
        this.curso = curso;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.numDias = numDias;
        this.materiasPorDia = materiasPorDia != null ? materiasPorDia : 2;
        this.observaciones = observaciones;
    }

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

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
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

    public List<HorarioExamenDetalle> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<HorarioExamenDetalle> detalles) {
        this.detalles = detalles;
    }
}

