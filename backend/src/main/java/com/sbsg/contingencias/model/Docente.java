package com.sbsg.contingencias.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "docentes")
public class Docente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nombre_completo", nullable = false, unique = true, length = 200)
    private String nombreCompleto;

    @Column(name = "nombre_corto", length = 100)
    private String nombreCorto;

    @Column(name = "email", length = 150)
    private String email;

    @Column(name = "telefono", length = 50)
    private String telefono;

    @Column(name = "activo", nullable = false)
    private Boolean activo = true;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    public Docente() {}

    public Docente(String nombreCompleto, String nombreCorto) {
        this.nombreCompleto = nombreCompleto;
        this.nombreCorto = nombreCorto;
        this.activo = true;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getNombreCorto() {
        return nombreCorto;
    }

    public void setNombreCorto(String nombreCorto) {
        this.nombreCorto = nombreCorto;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}

