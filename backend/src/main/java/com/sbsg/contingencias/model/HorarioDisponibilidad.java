package com.sbsg.contingencias.model;

import jakarta.persistence.*;

@Entity
@Table(name = "horarios_disponibilidad", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"docente_id", "dia_semana", "franja_horaria_id"})
})
public class HorarioDisponibilidad {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "docente_id", nullable = false)
    private Docente docente;

    @Column(name = "dia_semana", nullable = false, length = 20)
    private String diaSemana; // "Lunes", "Martes", "Miércoles", "Jueves", "Viernes"

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "franja_horaria_id", nullable = false)
    private FranjaHoraria franjaHoraria;

    public HorarioDisponibilidad() {}

    public HorarioDisponibilidad(Docente docente, String diaSemana, FranjaHoraria franjaHoraria) {
        this.docente = docente;
        this.diaSemana = diaSemana;
        this.franjaHoraria = franjaHoraria;
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
}

