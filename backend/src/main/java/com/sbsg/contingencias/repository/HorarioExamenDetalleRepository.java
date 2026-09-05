package com.sbsg.contingencias.repository;

import com.sbsg.contingencias.model.HorarioExamenDetalle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HorarioExamenDetalleRepository extends JpaRepository<HorarioExamenDetalle, Long> {
    List<HorarioExamenDetalle> findByHorarioExamenIdOrderByDiaNumeroAscOrdenDiaAsc(Long horarioExamenId);
}

