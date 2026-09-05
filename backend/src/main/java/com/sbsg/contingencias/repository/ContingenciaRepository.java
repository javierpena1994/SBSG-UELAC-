package com.sbsg.contingencias.repository;

import com.sbsg.contingencias.model.Contingencia;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface ContingenciaRepository extends JpaRepository<Contingencia, Long> {

    List<Contingencia> findByFechaBetweenOrderByFechaDesc(LocalDate fechaInicio, LocalDate fechaFin);

    List<Contingencia> findByFechaAndFranjaHorariaId(LocalDate fecha, Long franjaHorariaId);

    List<Contingencia> findByFechaAndCursoIdAndFranjaHorariaId(LocalDate fecha, Long cursoId, Long franjaHorariaId);

    List<Contingencia> findByFechaAndDocenteReemplazoIdAndFranjaHorariaId(LocalDate fecha, Long docenteReemplazoId, Long franjaHorariaId);

    List<Contingencia> findTop20ByOrderByFechaDescFranjaHorariaOrdenAscIdAsc();

    @Query("SELECT c FROM Contingencia c WHERE " +
           "(:fechaInicio IS NULL OR c.fecha >= :fechaInicio) AND " +
           "(:fechaFin IS NULL OR c.fecha <= :fechaFin) AND " +
           "(:docenteAusenteId IS NULL OR c.docenteAusente.id = :docenteAusenteId) AND " +
           "(:docenteReemplazoId IS NULL OR c.docenteReemplazo.id = :docenteReemplazoId) AND " +
           "(:cursoId IS NULL OR c.curso.id = :cursoId) AND " +
           "(:materiaId IS NULL OR c.materia.id = :materiaId) " +
           "ORDER BY c.fecha DESC, c.franjaHoraria.orden ASC, c.id ASC")
    List<Contingencia> filtrarContingencias(
            @Param("fechaInicio") LocalDate fechaInicio,
            @Param("fechaFin") LocalDate fechaFin,
            @Param("docenteAusenteId") Long docenteAusenteId,
            @Param("docenteReemplazoId") Long docenteReemplazoId,
            @Param("cursoId") Long cursoId,
            @Param("materiaId") Long materiaId
    );

    @Query("SELECT c FROM Contingencia c WHERE " +
           "(:fechaInicio IS NULL OR c.fecha >= :fechaInicio) AND " +
           "(:fechaFin IS NULL OR c.fecha <= :fechaFin) AND " +
           "(:docenteAusenteId IS NULL OR c.docenteAusente.id = :docenteAusenteId) AND " +
           "(:docenteReemplazoId IS NULL OR c.docenteReemplazo.id = :docenteReemplazoId) AND " +
           "(:cursoId IS NULL OR c.curso.id = :cursoId) AND " +
           "(:materiaId IS NULL OR c.materia.id = :materiaId) " +
           "ORDER BY c.fecha DESC, c.franjaHoraria.orden ASC, c.id ASC")
    Page<Contingencia> filtrarContingenciasPaginado(
            @Param("fechaInicio") LocalDate fechaInicio,
            @Param("fechaFin") LocalDate fechaFin,
            @Param("docenteAusenteId") Long docenteAusenteId,
            @Param("docenteReemplazoId") Long docenteReemplazoId,
            @Param("cursoId") Long cursoId,
            @Param("materiaId") Long materiaId,
            Pageable pageable
    );

    @Query("SELECT COALESCE(SUM(c.periodos), 0) FROM Contingencia c WHERE (:fechaInicio IS NULL OR c.fecha >= :fechaInicio) AND (:fechaFin IS NULL OR c.fecha <= :fechaFin)")
    BigDecimal sumTotalPeriodos(@Param("fechaInicio") LocalDate fechaInicio, @Param("fechaFin") LocalDate fechaFin);

    @Query("SELECT c.docenteReemplazo.nombreCompleto, SUM(c.periodos), COUNT(c) FROM Contingencia c " +
           "WHERE (:fechaInicio IS NULL OR c.fecha >= :fechaInicio) AND (:fechaFin IS NULL OR c.fecha <= :fechaFin) " +
           "GROUP BY c.docenteReemplazo.nombreCompleto ORDER BY SUM(c.periodos) DESC")
    List<Object[]> findResumenDocentesReemplazo(@Param("fechaInicio") LocalDate fechaInicio, @Param("fechaFin") LocalDate fechaFin);

    @Query("SELECT c.docenteAusente.nombreCompleto, SUM(c.periodos), COUNT(c) FROM Contingencia c " +
           "WHERE (:fechaInicio IS NULL OR c.fecha >= :fechaInicio) AND (:fechaFin IS NULL OR c.fecha <= :fechaFin) " +
           "GROUP BY c.docenteAusente.nombreCompleto ORDER BY SUM(c.periodos) DESC")
    List<Object[]> findResumenDocentesAusentes(@Param("fechaInicio") LocalDate fechaInicio, @Param("fechaFin") LocalDate fechaFin);

    @Query("SELECT COUNT(c) FROM Contingencia c WHERE c.docenteReemplazo.id = :docenteId AND c.fecha >= :hace30Dias")
    Long countReemplazosRecientes(@Param("docenteId") Long docenteId, @Param("hace30Dias") LocalDate hace30Dias);

    long countByMateriaId(Long materiaId);
}
