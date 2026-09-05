package com.sbsg.contingencias.dto;

import java.util.List;

public class GuardarHorarioDocenteRequest {
    private Long docenteId;
    private List<HorarioSlotDTO> slots;

    public GuardarHorarioDocenteRequest() {}

    public GuardarHorarioDocenteRequest(Long docenteId, List<HorarioSlotDTO> slots) {
        this.docenteId = docenteId;
        this.slots = slots;
    }

    public Long getDocenteId() {
        return docenteId;
    }

    public void setDocenteId(Long docenteId) {
        this.docenteId = docenteId;
    }

    public List<HorarioSlotDTO> getSlots() {
        return slots;
    }

    public void setSlots(List<HorarioSlotDTO> slots) {
        this.slots = slots;
    }
}

