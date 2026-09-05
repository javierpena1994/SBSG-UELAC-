package com.sbsg.contingencias.dto;

public class HorarioSlotDTO {
    private String diaSemana;
    private Long franjaHorariaId;

    public HorarioSlotDTO() {}

    public HorarioSlotDTO(String diaSemana, Long franjaHorariaId) {
        this.diaSemana = diaSemana;
        this.franjaHorariaId = franjaHorariaId;
    }

    public String getDiaSemana() {
        return diaSemana;
    }

    public void setDiaSemana(String diaSemana) {
        this.diaSemana = diaSemana;
    }

    public Long getFranjaHorariaId() {
        return franjaHorariaId;
    }

    public void setFranjaHorariaId(Long franjaHorariaId) {
        this.franjaHorariaId = franjaHorariaId;
    }
}

