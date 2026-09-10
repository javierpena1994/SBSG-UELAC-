package com.sbsg.contingencias.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "horarios_examenes_detalles")
public class HorarioExamenDetalle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "horario_examen_id", nullable = false)
    @JsonIgnore
    private HorarioExamen horarioExamen;

    @Column(name = "dia_numero", nullable = false)
    private Integer diaNumero; // 1, 2, 3...

    @Column(name = "fecha", nullable = false)
    private LocalDate fecha;

    @Column(name = "dia_semana", length = 20)
    private String diaSemana; // "Lunes", "Martes", etc.

    @Column(name = "orden_dia", nullable = false)
    private Integer ordenDia; // 1 (1ra materia), 2 (2da materia)

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "materia_id", nullable = true)
    private Materia materia;

    @Column(name = "materia_nombre", length = 150)
    private String materiaNombre;

    @Column(name = "tipo_complejidad", nullable = false, length = 30)
    private String tipoComplejidad = "COMPLEJA"; // "COMPLEJA" o "NO_COMPLEJA"

    @Column(name = "hora_inicio", length = 20)
    private String horaInicio;

    @Column(name = "hora_fin", length = 20)
    private String horaFin;

    @Column(name = "docente_supervisor", length = 200)
    private String docenteSupervisor;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "curso_id", nullable = true)
    private Curso curso;

    @Column(name = "curso_nombre", length = 100)
    private String cursoNombre;

    public HorarioExamenDetalle() {}

    public HorarioExamenDetalle(HorarioExamen horarioExamen, Integer diaNumero, LocalDate fecha, String diaSemana, Integer ordenDia, Materia materia, String materiaNombre, String tipoComplejidad, String horaInicio, String horaFin, String docenteSupervisor) {
        this(horarioExamen, null, null, diaNumero, fecha, diaSemana, ordenDia, materia, materiaNombre, tipoComplejidad, horaInicio, horaFin, docenteSupervisor);
    }

    public HorarioExamenDetalle(HorarioExamen horarioExamen, Curso curso, String cursoNombre, Integer diaNumero, LocalDate fecha, String diaSemana, Integer ordenDia, Materia materia, String materiaNombre, String tipoComplejidad, String horaInicio, String horaFin, String docenteSupervisor) {
        this.horarioExamen = horarioExamen;
        this.curso = curso;
        this.cursoNombre = cursoNombre != null ? cursoNombre : (curso != null ? curso.getNombre() : null);
        this.diaNumero = diaNumero;
        this.fecha = fecha;
        this.diaSemana = diaSemana;
        this.ordenDia = ordenDia;
        this.materia = materia;
        this.materiaNombre = materiaNombre != null ? materiaNombre : (materia != null ? materia.getNombre() : null);
        this.tipoComplejidad = tipoComplejidad != null ? tipoComplejidad : "COMPLEJA";
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

    public HorarioExamen getHorarioExamen() {
        return horarioExamen;
    }

    public void setHorarioExamen(HorarioExamen horarioExamen) {
        this.horarioExamen = horarioExamen;
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

    public Materia getMateria() {
        return materia;
    }

    public void setMateria(Materia materia) {
        this.materia = materia;
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

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
    }

    public String getCursoNombre() {
        return cursoNombre;
    }

    public void setCursoNombre(String cursoNombre) {
        this.cursoNombre = cursoNombre;
    }
}

