package com.sbsg.contingencias.dto;

import java.util.List;

public class GuardarHorarioClaseRequest {

    private Long docenteId;
    private Long cursoId;
    private List<HorarioClaseItemRequest> slots;

    public GuardarHorarioClaseRequest() {}

    public Long getDocenteId() {
        return docenteId;
    }

    public void setDocenteId(Long docenteId) {
        this.docenteId = docenteId;
    }

    public Long getCursoId() {
        return cursoId;
    }

    public void setCursoId(Long cursoId) {
        this.cursoId = cursoId;
    }

    public List<HorarioClaseItemRequest> getSlots() {
        return slots;
    }

    public void setSlots(List<HorarioClaseItemRequest> slots) {
        this.slots = slots;
    }

    public static class HorarioClaseItemRequest {
        private String diaSemana;
        private Long franjaHorariaId;
        private Long docenteId;
        private Long cursoId;
        private Long materiaId;
        private String actividad;
        private boolean esClase = true;

        public HorarioClaseItemRequest() {}

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

        public Long getDocenteId() {
            return docenteId;
        }

        public void setDocenteId(Long docenteId) {
            this.docenteId = docenteId;
        }

        public Long getCursoId() {
            return cursoId;
        }

        public void setCursoId(Long cursoId) {
            this.cursoId = cursoId;
        }

        public Long getMateriaId() {
            return materiaId;
        }

        public void setMateriaId(Long materiaId) {
            this.materiaId = materiaId;
        }

        public String getActividad() {
            return actividad;
        }

        public void setActividad(String actividad) {
            this.actividad = actividad;
        }

        public boolean isEsClase() {
            return esClase;
        }

        public void setEsClase(boolean esClase) {
            this.esClase = esClase;
        }
    }
}

