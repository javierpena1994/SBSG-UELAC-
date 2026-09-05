package com.sbsg.contingencias.model;

import jakarta.persistence.*;

@Entity
@Table(name = "franjas_horarias")
public class FranjaHoraria {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "etiqueta", nullable = false, unique = true, length = 50)
    private String etiqueta; // ej: "07h10 - 07h50"

    @Column(name = "hora_inicio", length = 10)
    private String horaInicio;

    @Column(name = "hora_fin", length = 10)
    private String horaFin;

    @Column(name = "orden", nullable = false)
    private Integer orden = 0;

    public FranjaHoraria() {}

    public FranjaHoraria(String etiqueta, String horaInicio, String horaFin, Integer orden) {
        this.etiqueta = etiqueta;
        this.horaInicio = horaInicio;
        this.horaFin = horaFin;
        this.orden = orden != null ? orden : calcularOrdenPorDefecto(etiqueta);
    }

    private static int calcularOrdenPorDefecto(String etiqueta) {
        if (etiqueta == null) return 99;
        return switch (etiqueta.trim()) {
            case "07h10 - 07h50" -> 1;
            case "07h50 - 08h30" -> 2;
            case "08h30 - 09h10" -> 3;
            case "09h10 - 09h50" -> 4;
            case "09h50 - 10h30" -> 5;
            case "09h50 - 10h20" -> 6;
            case "10h20 - 11h00" -> 7;
            case "10h30 - 11h00" -> 8;
            case "11h00 - 11h40" -> 9;
            case "11h40 - 12h20" -> 10;
            case "12h20 - 13h00" -> 11;
            case "13h00 - 13h40" -> 12;
            case "13h40 - 14h20", "13:40 - 14:20" -> 13;
            default -> 99;
        };
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEtiqueta() {
        return etiqueta;
    }

    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    public String getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(String horaInicio) {
        this.horaInicio = horaInicio;
    }

    public String getHoraFin() {
        return horaFin;
    }

    public void setHoraFin(String horaFin) {
        this.horaFin = horaFin;
    }

    public Integer getOrden() {
        return orden;
    }

    public void setOrden(Integer orden) {
        this.orden = orden;
    }

    @Transient
    public String getSeccion() {
        if (etiqueta == null) return "AMBOS";
        String et = etiqueta.trim();
        if (et.equals("09h50 - 10h30") || et.equals("13h00 - 13h40") || et.equals("10h30 - 11h00")) {
            return "COLEGIO";
        } else if (et.equals("10h20 - 11h00") || et.equals("09h50 - 10h20")) {
            return "ESCUELA";
        }
        return "AMBOS";
    }

    @Transient
    public String getDescripcionPeriodo() {
        if (etiqueta == null) return "";
        return switch (etiqueta.trim()) {
            case "07h10 - 07h50" -> "1° Hora (07h10 - 07h50)";
            case "07h50 - 08h30" -> "2° Hora (07h50 - 08h30)";
            case "08h30 - 09h10" -> "3° Hora (08h30 - 09h10)";
            case "09h10 - 09h50" -> "4° Hora (09h10 - 09h50)";
            case "09h50 - 10h30" -> "5° Hora Colegio (09h50 - 10h30)";
            case "09h50 - 10h20" -> "☕ Recreo Escuela (09h50 - 10h20)";
            case "10h20 - 11h00" -> "5° Hora Escuela (10h20 - 11h00)";
            case "10h30 - 11h00" -> "☕ Recreo Colegio (10h30 - 11h00)";
            case "11h00 - 11h40" -> "6° Hora (11h00 - 11h40)";
            case "11h40 - 12h20" -> "7° Hora (11h40 - 12h20)";
            case "12h20 - 13h00" -> "8° Hora (12h20 - 13h00 / Salida Escuela)";
            case "13h00 - 13h40" -> "9° Hora (13h00 - 13h40)";
            case "13h40 - 14h20", "13:40 - 14:20" -> "10° Hora (13h40 - 14h20 / Salida General)";
            default -> etiqueta;
        };
    }
}
