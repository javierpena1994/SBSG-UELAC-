package com.sbsg.contingencias.dto;

import com.sbsg.contingencias.model.Curso;
import com.sbsg.contingencias.model.Docente;
import com.sbsg.contingencias.model.FranjaHoraria;
import com.sbsg.contingencias.model.Materia;

import java.util.List;

public class CatalogoResponseDTO {
    private List<Docente> docentes;
    private List<Curso> cursos;
    private List<Materia> materias;
    private List<FranjaHoraria> franjasHorarias;

    public CatalogoResponseDTO() {}

    public CatalogoResponseDTO(List<Docente> docentes, List<Curso> cursos, List<Materia> materias, List<FranjaHoraria> franjasHorarias) {
        this.docentes = docentes;
        this.cursos = cursos;
        this.materias = materias;
        this.franjasHorarias = franjasHorarias;
    }

    public List<Docente> getDocentes() {
        return docentes;
    }

    public void setDocentes(List<Docente> docentes) {
        this.docentes = docentes;
    }

    public List<Curso> getCursos() {
        return cursos;
    }

    public void setCursos(List<Curso> cursos) {
        this.cursos = cursos;
    }

    public List<Materia> getMateria() {
        return materias;
    }

    public void setMaterias(List<Materia> materias) {
        this.materias = materias;
    }

    public List<Materia> getMaterias() {
        return materias;
    }

    public List<FranjaHoraria> getFranjasHorarias() {
        return franjasHorarias;
    }

    public void setFranjasHorarias(List<FranjaHoraria> franjasHorarias) {
        this.franjasHorarias = franjasHorarias;
    }
}

