package com.sbsg.contingencias.controller;

import com.sbsg.contingencias.dto.CatalogoResponseDTO;
import com.sbsg.contingencias.model.Curso;
import com.sbsg.contingencias.model.Docente;
import com.sbsg.contingencias.model.FranjaHoraria;
import com.sbsg.contingencias.model.Materia;
import com.sbsg.contingencias.repository.CursoRepository;
import com.sbsg.contingencias.repository.DocenteRepository;
import com.sbsg.contingencias.repository.FranjaHorariaRepository;
import com.sbsg.contingencias.repository.MateriaRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/catalogos")
@CrossOrigin(origins = "*")
public class CatalogoController {

    private final DocenteRepository docenteRepository;
    private final CursoRepository cursoRepository;
    private final MateriaRepository materiaRepository;
    private final FranjaHorariaRepository franjaHorariaRepository;

    public CatalogoController(
            DocenteRepository docenteRepository,
            CursoRepository cursoRepository,
            MateriaRepository materiaRepository,
            FranjaHorariaRepository franjaHorariaRepository) {
        this.docenteRepository = docenteRepository;
        this.cursoRepository = cursoRepository;
        this.materiaRepository = materiaRepository;
        this.franjaHorariaRepository = franjaHorariaRepository;
    }

    @GetMapping
    public ResponseEntity<CatalogoResponseDTO> obtenerTodosLosCatalogos() {
        List<Docente> docentes = docenteRepository.findByActivoTrueOrderByNombreCompletoAsc();
        List<Curso> cursos = cursoRepository.findAll();
        cursos.sort(java.util.Comparator.comparingInt(Curso::getOrdenNivel));
        List<Materia> materias = materiaRepository.findAllByOrderByNombreAsc();
        List<FranjaHoraria> franjas = franjaHorariaRepository.findAllByOrderByOrdenAsc();

        return ResponseEntity.ok(new CatalogoResponseDTO(docentes, cursos, materias, franjas));
    }

    @GetMapping("/cursos")
    public ResponseEntity<List<Curso>> obtenerCursos() {
        List<Curso> cursos = cursoRepository.findAll();
        cursos.sort(java.util.Comparator.comparingInt(Curso::getOrdenNivel));
        return ResponseEntity.ok(cursos);
    }

    @GetMapping("/materias")
    public ResponseEntity<List<Materia>> obtenerMaterias() {
        return ResponseEntity.ok(materiaRepository.findAllByOrderByNombreAsc());
    }

    @GetMapping("/franjas")
    public ResponseEntity<List<FranjaHoraria>> obtenerFranjas() {
        return ResponseEntity.ok(franjaHorariaRepository.findAllByOrderByOrdenAsc());
    }
}

