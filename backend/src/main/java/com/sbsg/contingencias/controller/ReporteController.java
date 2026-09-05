package com.sbsg.contingencias.controller;

import com.sbsg.contingencias.dto.ReporteResponseDTO;
import com.sbsg.contingencias.service.ExcelExportService;
import com.sbsg.contingencias.service.ReporteService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.time.LocalDate;

@RestController
@RequestMapping("/api/reportes")
@CrossOrigin(origins = "*")
public class ReporteController {

    private final ReporteService reporteService;
    private final ExcelExportService excelExportService;

    public ReporteController(ReporteService reporteService, ExcelExportService excelExportService) {
        this.reporteService = reporteService;
        this.excelExportService = excelExportService;
    }

    @GetMapping
    public ResponseEntity<ReporteResponseDTO> generarReporte(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaInicio,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaFin,
            @RequestParam(required = false) Long docenteAusenteId,
            @RequestParam(required = false) Long docenteReemplazoId,
            @RequestParam(required = false) Long cursoId,
            @RequestParam(required = false) Long materiaId) {
        return ResponseEntity.ok(reporteService.generarReporte(fechaInicio, fechaFin, docenteAusenteId, docenteReemplazoId, cursoId, materiaId));
    }

    @GetMapping("/exportar-excel")
    public ResponseEntity<byte[]> exportarExcel(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaInicio,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaFin,
            @RequestParam(required = false) Long docenteAusenteId,
            @RequestParam(required = false) Long docenteReemplazoId,
            @RequestParam(required = false) Long cursoId,
            @RequestParam(required = false) Long materiaId) throws IOException {

        ReporteResponseDTO reporte = reporteService.generarReporte(fechaInicio, fechaFin, docenteAusenteId, docenteReemplazoId, cursoId, materiaId);
        byte[] excelBytes = excelExportService.exportarReporteAExcel(reporte);

        String filename = "Reporte_Contingencias_SBSG_" + (fechaInicio != null ? fechaInicio : "Inicio") + "_al_" + (fechaFin != null ? fechaFin : "Fin") + ".xlsx";

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .body(excelBytes);
    }
}

