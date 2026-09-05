package com.sbsg.contingencias.model;

import jakarta.persistence.*;

@Entity
@Table(name = "materias_cursos_config", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"curso_id", "materia_id"})
})
public class MateriaCursoConfig {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "curso_id", nullable = false)
    private Curso curso;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "materia_id", nullable = false)
    private Materia materia;

    @Column(name = "tipo_complejidad", nullable = false, length = 30)
    private String tipoComplejidad = "COMPLEJA"; // "COMPLEJA" o "NO_COMPLEJA"

    @Column(name = "activo", nullable = false)
    private Boolean activo = true;

    public MateriaCursoConfig() {}

    public MateriaCursoConfig(Curso curso, Materia materia, String tipoComplejidad, Boolean activo) {
        this.curso = curso;
        this.materia = materia;
        this.tipoComplejidad = tipoComplejidad != null ? tipoComplejidad : "COMPLEJA";
        this.activo = activo != null ? activo : true;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getTipoComplejidad() {
        return tipoComplejidad;
    }

    public void setTipoComplejidad(String tipoComplejidad) {
        this.tipoComplejidad = tipoComplejidad;
    }

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
    }
}

