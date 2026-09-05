package com.sbsg.contingencias.repository;

import com.sbsg.contingencias.model.HorarioExamen;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HorarioExamenRepository extends JpaRepository<HorarioExamen, Long> {
    List<HorarioExamen> findAllByOrderByCreatedAtDesc();
    List<HorarioExamen> findByCursoIdOrderByCreatedAtDesc(Long cursoId);
}

