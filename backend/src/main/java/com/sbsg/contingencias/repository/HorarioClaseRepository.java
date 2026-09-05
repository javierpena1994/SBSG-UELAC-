package com.sbsg.contingencias.repository;

import com.sbsg.contingencias.model.HorarioClase;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface HorarioClaseRepository extends JpaRepository<HorarioClase, Long> {

    List<HorarioClase> findByDocenteId(Long docenteId);

    List<HorarioClase> findByCursoId(Long cursoId);

    Optional<HorarioClase> findByDocenteIdAndDiaSemanaAndFranjaHorariaId(Long docenteId, String diaSemana, Long franjaHorariaId);

    Optional<HorarioClase> findByCursoIdAndDiaSemanaAndFranjaHorariaId(Long cursoId, String diaSemana, Long franjaHorariaId);

    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("DELETE FROM HorarioClase h WHERE h.docente.id = :docenteId")
    void deleteByDocenteId(@Param("docenteId") Long docenteId);

    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query("DELETE FROM HorarioClase h WHERE h.curso.id = :cursoId")
    void deleteByCursoId(@Param("cursoId") Long cursoId);

    @Query("SELECT h FROM HorarioClase h WHERE h.diaSemana = :diaSemana AND h.franjaHoraria.id = :franjaHorariaId AND h.esClase = true")
    List<HorarioClase> findOcupadosEnFranja(@Param("diaSemana") String diaSemana, @Param("franjaHorariaId") Long franjaHorariaId);

    long countByMateriaId(Long materiaId);
}

