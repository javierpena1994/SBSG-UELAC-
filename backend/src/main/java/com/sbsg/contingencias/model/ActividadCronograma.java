package com.sbsg.contingencias.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "actividades_cronograma")
public class ActividadCronograma {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "titulo", nullable = false, length = 200)
    private String titulo;

    @Column(name = "descripcion", columnDefinition = "TEXT")
    private String descripcion;

    @Column(name = "fecha_inicio", nullable = false)
    private LocalDate fechaInicio;

    @Column(name = "fecha_fin")
    private LocalDate fechaFin;

    @Column(name = "hora_inicio", length = 20)
    private String horaInicio;

    @Column(name = "hora_fin", length = 20)
    private String horaFin;

    @Column(name = "categoria", nullable = false, length = 50)
    private String categoria = "ACADEMICO"; 
    // "ACADEMICO", "CIVICO_CULTURAL", "DEPORTIVO", "INSTITUCIONAL", "EVALUACION", "FERIADO", "REUNION_PADRES"

    @Column(name = "responsable", length = 200)
    private String responsable;

    @Column(name = "dirigido_a", length = 100)
    private String dirigidoA = "TODOS"; // "TODOS", "ESCUELA", "COLEGIO", "DOCENTES", "PADRES"

    @Column(name = "estado", nullable = false, length = 30)
    private String estado = "PLANIFICADO"; // "PLANIFICADO", "EN_CURSO", "FINALIZADO", "POSPUESTO"

    @Column(name = "color", length = 20)
    private String color = "#2563eb";

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    public ActividadCronograma() {}

    public ActividadCronograma(String titulo, String descripcion, LocalDate fechaInicio, LocalDate fechaFin, String horaInicio, String horaFin, String categoria, String responsable, String dirigidoA, String estado, String color) {
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin != null ? fechaFin : fechaInicio;
        this.horaInicio = horaInicio;
        this.horaFin = horaFin;
        this.categoria = categoria != null ? categoria : "ACADEMICO";
        this.responsable = responsable;
        this.dirigidoA = dirigidoA != null ? dirigidoA : "TODOS";
        this.estado = estado != null ? estado : "PLANIFICADO";
        this.color = color != null ? color : "#2563eb";
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

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
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

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getDirigidoA() {
        return dirigidoA;
    }

    public void setDirigidoA(String dirigidoA) {
        this.dirigidoA = dirigidoA;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}

