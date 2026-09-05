package com.sbsg.contingencias.repository;

import com.sbsg.contingencias.model.MateriaCursoConfig;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MateriaCursoConfigRepository extends JpaRepository<MateriaCursoConfig, Long> {
    List<MateriaCursoConfig> findByCursoIdAndActivoTrue(Long cursoId);
    Optional<MateriaCursoConfig> findByCursoIdAndMateriaId(Long cursoId, Long materiaId);
}

