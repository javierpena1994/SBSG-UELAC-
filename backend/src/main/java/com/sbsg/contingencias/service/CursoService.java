package com.sbsg.contingencias.service;

import com.sbsg.contingencias.model.Curso;
import com.sbsg.contingencias.repository.CursoRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@Service
public class CursoService {

    private final CursoRepository cursoRepository;

    public CursoService(CursoRepository cursoRepository) {
        this.cursoRepository = cursoRepository;
    }

    public List<Curso> obtenerTodos() {
        List<Curso> cursos = cursoRepository.findAll();
        cursos.sort(Comparator.comparingInt(Curso::getOrdenNivel));
        return cursos;
    }

    public Optional<Curso> obtenerPorId(Long id) {
        return cursoRepository.findById(id);
    }

    @Transactional
    public Curso crear(Curso curso) {
        if (curso.getNombre() == null || curso.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del curso es obligatorio.");
        }
        String nombreNorm = curso.getNombre().trim().toUpperCase();
        if (cursoRepository.findByNombreIgnoreCase(nombreNorm).isPresent()) {
            throw new IllegalArgumentException("Ya existe un curso con el nombre: " + nombreNorm);
        }
        curso.setNombre(nombreNorm);
        return cursoRepository.save(curso);
    }

    @Transactional
    public Curso actualizar(Long id, Curso curso) {
        Curso existente = cursoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Curso no encontrado con ID: " + id));

        if (curso.getNombre() == null || curso.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del curso es obligatorio.");
        }
        String nombreNorm = curso.getNombre().trim().toUpperCase();
        Optional<Curso> duplicado = cursoRepository.findByNombreIgnoreCase(nombreNorm);
        if (duplicado.isPresent() && !duplicado.get().getId().equals(id)) {
            throw new IllegalArgumentException("Ya existe otro curso con el nombre: " + nombreNorm);
        }
        existente.setNombre(nombreNorm);
        return cursoRepository.save(existente);
    }

    @Transactional
    public void eliminar(Long id) {
        if (!cursoRepository.existsById(id)) {
            throw new RuntimeException("Curso no encontrado con ID: " + id);
        }
        cursoRepository.deleteById(id);
    }
}

