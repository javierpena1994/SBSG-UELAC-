package com.sbsg.contingencias.repository;

import com.sbsg.contingencias.model.FranjaHoraria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FranjaHorariaRepository extends JpaRepository<FranjaHoraria, Long> {
    Optional<FranjaHoraria> findByEtiquetaIgnoreCase(String etiqueta);
    List<FranjaHoraria> findAllByOrderByOrdenAsc();
}

