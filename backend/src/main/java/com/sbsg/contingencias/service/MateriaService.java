package com.sbsg.contingencias.service;

import com.sbsg.contingencias.model.Materia;
import com.sbsg.contingencias.repository.ContingenciaRepository;
import com.sbsg.contingencias.repository.HorarioClaseRepository;
import com.sbsg.contingencias.repository.MateriaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class MateriaService {

    private final MateriaRepository materiaRepository;
    private final HorarioClaseRepository horarioClaseRepository;
    private final ContingenciaRepository contingenciaRepository;

    public MateriaService(
            MateriaRepository materiaRepository,
            HorarioClaseRepository horarioClaseRepository,
            ContingenciaRepository contingenciaRepository) {
        this.materiaRepository = materiaRepository;
        this.horarioClaseRepository = horarioClaseRepository;
        this.contingenciaRepository = contingenciaRepository;
    }

    public List<Materia> obtenerTodas() {
        return materiaRepository.findAllByOrderByNombreAsc();
    }

    public Optional<Materia> obtenerPorId(Long id) {
        return materiaRepository.findById(id);
    }

    @Transactional
    public Materia guardar(Materia materia) {
        if (materia == null || materia.getNombre() == null || materia.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre de la materia es obligatorio.");
        }

        String nombreNormalizado = materia.getNombre().trim().toUpperCase();
        if (materiaRepository.existsByNombreIgnoreCase(nombreNormalizado)) {
            throw new IllegalArgumentException("Ya existe una materia registrada con el nombre: " + nombreNormalizado);
        }

        materia.setNombre(nombreNormalizado);
        return materiaRepository.save(materia);
    }

    @Transactional
    public Materia actualizar(Long id, Materia materiaActualizada) {
        Materia existente = materiaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Materia no encontrada con ID: " + id));

        if (materiaActualizada == null || materiaActualizada.getNombre() == null || materiaActualizada.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre de la materia es obligatorio.");
        }

        String nuevoNombre = materiaActualizada.getNombre().trim().toUpperCase();
        if (materiaRepository.existsByNombreIgnoreCaseAndIdNot(nuevoNombre, id)) {
            throw new IllegalArgumentException("Ya existe otra materia con el nombre: " + nuevoNombre);
        }

        existente.setNombre(nuevoNombre);
        return materiaRepository.save(existente);
    }

    @Transactional
    public void eliminar(Long id) {
        Materia materia = materiaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Materia no encontrada con ID: " + id));

        long referenciasHorario = horarioClaseRepository.countByMateriaId(id);
        long referenciasContingencia = contingenciaRepository.countByMateriaId(id);

        if (referenciasHorario > 0 || referenciasContingencia > 0) {
            throw new IllegalStateException("No se puede eliminar la materia '" + materia.getNombre() +
                    "' porque está asignada en horarios de clases o registros de contingencias. " +
                    "Puede editar su nombre si desea corregirlo.");
        }

        materiaRepository.delete(materia);
    }
}
