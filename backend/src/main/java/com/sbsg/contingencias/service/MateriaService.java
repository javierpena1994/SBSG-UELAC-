package com.sbsg.contingencias.service;

import com.sbsg.contingencias.model.Materia;
import com.sbsg.contingencias.repository.ContingenciaRepository;
import com.sbsg.contingencias.repository.HorarioClaseRepository;
import com.sbsg.contingencias.repository.MateriaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class MateriaService {

    private static final Logger log = LoggerFactory.getLogger(MateriaService.class);

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

    @PostConstruct
    @Transactional
    public void inicializarAplicaExamenPorDefecto() {
        try {
            List<Materia> todas = materiaRepository.findAll();
            for (Materia m : todas) {
                if (m.getNombre() != null) {
                    String n = m.getNombre().toUpperCase().trim();
                    boolean esNoEvaluable = n.contains("BIBLIOTECA") ||
                                           n.contains("TUTOR") ||
                                           n.contains("ACOMPAÑAMIENTO") ||
                                           n.contains("PPFF") ||
                                           n.contains("PADRES") ||
                                           n.contains("MISA") ||
                                           n.contains("PASTORAL") ||
                                           n.contains("OVP");
                    if (esNoEvaluable && m.isAplicaExamen()) {
                        m.setAplicaExamen(false);
                        materiaRepository.save(m);
                        log.info("Materia institucional '{}' configurada automáticamente como NO evaluable en examen.", m.getNombre());
                    }
                }
            }
        } catch (Exception e) {
            log.warn("No se pudo autoconfigurar materias no evaluables: {}", e.getMessage());
        }
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
        existente.setAplicaExamen(materiaActualizada.isAplicaExamen());
        return materiaRepository.save(existente);
    }

    @Transactional
    public Materia toggleAplicaExamen(Long id) {
        Materia materia = materiaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Materia no encontrada con ID: " + id));
        materia.setAplicaExamen(!materia.isAplicaExamen());
        return materiaRepository.save(materia);
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
