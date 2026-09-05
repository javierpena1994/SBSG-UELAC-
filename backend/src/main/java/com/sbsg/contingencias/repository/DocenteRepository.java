package com.sbsg.contingencias.repository;

import com.sbsg.contingencias.model.Docente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DocenteRepository extends JpaRepository<Docente, Long> {
    Optional<Docente> findByNombreCompletoIgnoreCase(String nombreCompleto);
    Optional<Docente> findByNombreCortoIgnoreCase(String nombreCorto);
    List<Docente> findByActivoTrueOrderByNombreCompletoAsc();
}

