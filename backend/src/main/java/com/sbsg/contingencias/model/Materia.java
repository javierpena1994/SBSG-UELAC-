package com.sbsg.contingencias.model;

import jakarta.persistence.*;

@Entity
@Table(name = "materias")
public class Materia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nombre", nullable = false, unique = true, length = 150)
    private String nombre;

    @Column(name = "aplica_examen", nullable = false)
    private boolean aplicaExamen = true;

    public Materia() {}

    public Materia(String nombre) {
        this.nombre = nombre;
        this.aplicaExamen = true;
    }

    public Materia(String nombre, boolean aplicaExamen) {
        this.nombre = nombre;
        this.aplicaExamen = aplicaExamen;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public boolean isAplicaExamen() {
        return aplicaExamen;
    }

    public void setAplicaExamen(boolean aplicaExamen) {
        this.aplicaExamen = aplicaExamen;
    }
}

