package com.sbsg.contingencias.repository;

import com.sbsg.contingencias.model.HorarioDisponibilidad;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface HorarioDisponibilidadRepository extends JpaRepository<HorarioDisponibilidad, Long> {

    List<HorarioDisponibilidad> findByDiaSemanaIgnoreCase(String diaSemana);

    List<HorarioDisponibilidad> findByDocenteIdOrderByDiaSemanaAsc(Long docenteId);

    @Query("SELECT h FROM HorarioDisponibilidad h WHERE LOWER(h.diaSemana) = LOWER(:diaSemana) AND h.franjaHoraria.id = :franjaId AND h.docente.activo = true")
    List<HorarioDisponibilidad> findDisponiblesPorDiaYFranja(@Param("diaSemana") String diaSemana, @Param("franjaId") Long franjaId);

    @Query("SELECT h FROM HorarioDisponibilidad h WHERE LOWER(h.diaSemana) = LOWER(:diaSemana) AND h.franjaHoraria.id = :franjaId AND h.docente.id <> :docenteAusenteId AND h.docente.activo = true")
    List<HorarioDisponibilidad> findDisponiblesParaReemplazo(@Param("diaSemana") String diaSemana, @Param("franjaId") Long franjaId, @Param("docenteAusenteId") Long docenteAusenteId);

    Optional<HorarioDisponibilidad> findByDocenteIdAndDiaSemanaIgnoreCaseAndFranjaHorariaId(Long docenteId, String diaSemana, Long franjaHorariaId);

    @org.springframework.data.jpa.repository.Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("DELETE FROM HorarioDisponibilidad h WHERE h.docente.id = :docenteId")
    void deleteByDocenteId(@Param("docenteId") Long docenteId);
}

