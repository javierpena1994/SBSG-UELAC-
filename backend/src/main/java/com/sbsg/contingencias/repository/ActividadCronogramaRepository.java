package com.sbsg.contingencias.repository;

import com.sbsg.contingencias.model.ActividadCronograma;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ActividadCronogramaRepository extends JpaRepository<ActividadCronograma, Long> {

    List<ActividadCronograma> findAllByOrderByFechaInicioAscHoraInicioAsc();

    @Query("SELECT a FROM ActividadCronograma a WHERE " +
           "(a.fechaInicio <= :fechaFin AND (a.fechaFin IS NULL OR a.fechaFin >= :fechaInicio)) " +
           "ORDER BY a.fechaInicio ASC, a.horaInicio ASC")
    List<ActividadCronograma> findActividadesEnRango(@Param("fechaInicio") LocalDate fechaInicio, @Param("fechaFin") LocalDate fechaFin);

    @Query("SELECT a FROM ActividadCronograma a WHERE " +
           "(:categoria IS NULL OR a.categoria = :categoria) AND " +
           "(:estado IS NULL OR a.estado = :estado) AND " +
           "(:dirigidoA IS NULL OR a.dirigidoA = :dirigidoA) " +
           "ORDER BY a.fechaInicio ASC, a.horaInicio ASC")
    List<ActividadCronograma> filtrarActividades(
            @Param("categoria") String categoria,
            @Param("estado") String estado,
            @Param("dirigidoA") String dirigidoA
    );
}

