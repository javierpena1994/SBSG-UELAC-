package com.sbsg.contingencias.service;

import com.sbsg.contingencias.model.Docente;
import com.sbsg.contingencias.repository.DocenteRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class DocenteService {

    private final DocenteRepository docenteRepository;

    public DocenteService(DocenteRepository docenteRepository) {
        this.docenteRepository = docenteRepository;
    }

    public List<Docente> obtenerTodosActivos() {
        return docenteRepository.findByActivoTrueOrderByNombreCompletoAsc();
    }

    public List<Docente> obtenerTodos() {
        return docenteRepository.findAll();
    }

    public Optional<Docente> obtenerPorId(Long id) {
        return docenteRepository.findById(id);
    }

    public Optional<Docente> obtenerPorNombreCompleto(String nombreCompleto) {
        return docenteRepository.findByNombreCompletoIgnoreCase(nombreCompleto);
    }

    @Transactional
    public Docente guardar(Docente docente) {
        if (docente.getNombreCompleto() == null || docente.getNombreCompleto().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre completo del docente es obligatorio.");
        }
        if (docente.getNombreCorto() == null || docente.getNombreCorto().trim().isEmpty()) {
            docente.setNombreCorto(docente.getNombreCompleto());
        }
        if (docente.getActivo() == null) {
            docente.setActivo(true);
        }
        return docenteRepository.save(docente);
    }

    @Transactional
    public Docente actualizar(Long id, Docente docenteDetalles) {
        Docente docente = docenteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Docente no encontrado con ID: " + id));
        docente.setNombreCompleto(docenteDetalles.getNombreCompleto());
        docente.setNombreCorto(docenteDetalles.getNombreCorto() != null && !docenteDetalles.getNombreCorto().trim().isEmpty()
                ? docenteDetalles.getNombreCorto() : docenteDetalles.getNombreCompleto());
        docente.setEmail(docenteDetalles.getEmail());
        docente.setTelefono(docenteDetalles.getTelefono());
        if (docenteDetalles.getActivo() != null) {
            docente.setActivo(docenteDetalles.getActivo());
        }
        return docenteRepository.save(docente);
    }

    @Transactional
    public boolean toggleActivo(Long id) {
        Docente docente = docenteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Docente no encontrado con ID: " + id));
        docente.setActivo(!Boolean.TRUE.equals(docente.getActivo()));
        docenteRepository.save(docente);
        return docente.getActivo();
    }
}
