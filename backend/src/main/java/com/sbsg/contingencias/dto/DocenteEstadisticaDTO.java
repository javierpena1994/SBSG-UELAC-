package com.sbsg.contingencias.dto;

import java.math.BigDecimal;

public class DocenteEstadisticaDTO {
    private String nombreDocente;
    private BigDecimal totalPeriodos;
    private Long cantidadContingencias;

    public DocenteEstadisticaDTO() {}

    public DocenteEstadisticaDTO(String nombreDocente, BigDecimal totalPeriodos, Long cantidadContingencias) {
        this.nombreDocente = nombreDocente;
        this.totalPeriodos = totalPeriodos;
        this.cantidadContingencias = cantidadContingencias;
    }

    public String getNombreDocente() {
        return nombreDocente;
    }

    public void setNombreDocente(String nombreDocente) {
        this.nombreDocente = nombreDocente;
    }

    public BigDecimal getTotalPeriodos() {
        return totalPeriodos;
    }

    public void setTotalPeriodos(BigDecimal totalPeriodos) {
        this.totalPeriodos = totalPeriodos;
    }

    public Long getCantidadContingencias() {
        return cantidadContingencias;
    }

    public void setCantidadContingencias(Long cantidadContingencias) {
        this.cantidadContingencias = cantidadContingencias;
    }
}

