package com.sbsg.contingencias.model;

import jakarta.persistence.*;

@Entity
@Table(name = "cursos")
public class Curso {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nombre", nullable = false, unique = true, length = 100)
    private String nombre;

    public Curso() {}

    public Curso(String nombre) {
        this.nombre = nombre;
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

    @Transient
    public String getNivel() {
        if (this.nombre == null) return "BÁSICO";
        String n = this.nombre.toUpperCase().trim();
        // Nivel Superior: 8° a 10° EGB y 1° a 3° BGU
        if (n.contains("BGU") || n.contains("BACH") || n.startsWith("8") || n.startsWith("9") || n.startsWith("10")
                || n.startsWith("8°") || n.startsWith("9°") || n.startsWith("10°")) {
            return "SUPERIOR";
        }
        // Nivel Básico: Inicial 2, 1° a 3° EGB
        if (n.contains("INICIAL") || n.startsWith("1°") || n.startsWith("1 ") || n.startsWith("1RO") || n.startsWith("PRIMERO")
                || n.startsWith("2°") || n.startsWith("2 ") || n.startsWith("2DO") || n.startsWith("SEGUNDO")
                || n.startsWith("3°") || n.startsWith("3 ") || n.startsWith("3RO") || n.startsWith("TERCERO")) {
            return "BÁSICO";
        }
        // Nivel Medio: 4° a 7° EGB
        if (n.startsWith("4°") || n.startsWith("4 ") || n.startsWith("4TO") || n.startsWith("CUARTO")
                || n.startsWith("5°") || n.startsWith("5 ") || n.startsWith("5TO") || n.startsWith("QUINTO")
                || n.startsWith("6°") || n.startsWith("6 ") || n.startsWith("6TO") || n.startsWith("SEXTO")
                || n.startsWith("7°") || n.startsWith("7 ") || n.startsWith("7MO") || n.startsWith("SEPTIMO") || n.startsWith("SÉPTIMO")) {
            return "MEDIO";
        }
        return "SUPERIOR";
    }

    @Transient
    public int getOrdenNivel() {
        if (this.nombre == null) return 99;
        String n = this.nombre.toUpperCase().trim();
        if (n.contains("INICIAL")) return 1;
        // BGU check first before 1°, 2°, 3°
        if (n.contains("1° BGU") || n.contains("1 BGU") || n.contains("1RO BGU") || n.contains("PRIMERO BGU")) return 12;
        if (n.contains("2° BGU") || n.contains("2 BGU") || n.contains("2DO BGU") || n.contains("SEGUNDO BGU")) return 13;
        if (n.contains("3° BGU") || n.contains("3 BGU") || n.contains("3RO BGU") || n.contains("TERCERO BGU")) return 14;

        if (n.startsWith("1°") || n.startsWith("1 ") || n.startsWith("1RO") || n.startsWith("PRIMERO")) return 2;
        if (n.startsWith("2°") || n.startsWith("2 ") || n.startsWith("2DO") || n.startsWith("SEGUNDO")) return 3;
        if (n.startsWith("3°") || n.startsWith("3 ") || n.startsWith("3RO") || n.startsWith("TERCERO")) return 4;
        if (n.startsWith("4°") || n.startsWith("4 ") || n.startsWith("4TO") || n.startsWith("CUARTO")) return 5;
        if (n.startsWith("5°") || n.startsWith("5 ") || n.startsWith("5TO") || n.startsWith("QUINTO")) return 6;
        if (n.startsWith("6°") || n.startsWith("6 ") || n.startsWith("6TO") || n.startsWith("SEXTO")) return 7;
        if (n.startsWith("7°") || n.startsWith("7 ") || n.startsWith("7MO") || n.startsWith("SEPTIMO") || n.startsWith("SÉPTIMO")) return 8;
        if (n.startsWith("8°") || n.startsWith("8 ") || n.startsWith("8VO") || n.startsWith("OCTAVO")) return 9;
        if (n.startsWith("9°") || n.startsWith("9 ") || n.startsWith("9NO") || n.startsWith("NOVENO")) return 10;
        if (n.startsWith("10°") || n.startsWith("10 ") || n.startsWith("10MO") || n.startsWith("DECIMO") || n.startsWith("DÉCIMO")) return 11;
        return 99;
    }

    @Transient
    public String getSeccion() {
        if (this.nombre == null) return "ESCUELA";
        String n = this.nombre.toUpperCase().trim();
        if (n.startsWith("8") || n.startsWith("9") || n.startsWith("10") || n.contains("BGU") || n.contains("BACH")) {
            return "COLEGIO";
        }
        return "ESCUELA";
    }
}
