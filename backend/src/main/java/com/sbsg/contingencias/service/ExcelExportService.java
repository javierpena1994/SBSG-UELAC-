package com.sbsg.contingencias.service;

import com.sbsg.contingencias.dto.ContingenciaDTO;
import com.sbsg.contingencias.dto.DocenteEstadisticaDTO;
import com.sbsg.contingencias.dto.ReporteResponseDTO;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

@Service
public class ExcelExportService {

    public byte[] exportarReporteAExcel(ReporteResponseDTO reporte) throws IOException {
        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {

            // Estilos
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.WHITE.getIndex());

            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);

            CellStyle titleStyle = workbook.createCellStyle();
            Font titleFont = workbook.createFont();
            titleFont.setBold(true);
            titleFont.setFontHeightInPoints((short) 14);
            titleStyle.setFont(titleFont);

            // Hoja 1: Registro Detallado
            Sheet sheetDetalles = workbook.createSheet("Detalle Contingencias");
            int rowIdx = 0;

            Row titleRow = sheetDetalles.createRow(rowIdx++);
            Cell titleCell = titleRow.createCell(0);
            titleCell.setCellValue("REPORTE DE CONTINGENCIAS SBSG");
            titleCell.setCellStyle(titleStyle);

            Row subRow = sheetDetalles.createRow(rowIdx++);
            subRow.createCell(0).setCellValue("Período: " + (reporte.getFechaInicio() != null ? reporte.getFechaInicio() : "Inicio") + " al " + (reporte.getFechaFin() != null ? reporte.getFechaFin() : "Fin"));

            rowIdx++; // Espacio

            String[] headers = {"ID", "Fecha", "Día", "Docente Ausente", "Docente Reemplazante", "Hora", "Curso", "Materia", "Recursos", "Períodos (Horas)", "Observación"};
            Row headerRow = sheetDetalles.createRow(rowIdx++);
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            for (ContingenciaDTO c : reporte.getDetalles()) {
                Row row = sheetDetalles.createRow(rowIdx++);
                row.createCell(0).setCellValue(c.getId());
                row.createCell(1).setCellValue(c.getFecha() != null ? c.getFecha().toString() : "");
                row.createCell(2).setCellValue(c.getDiaSemana() != null ? c.getDiaSemana() : "");
                row.createCell(3).setCellValue(c.getDocenteAusenteNombre() != null ? c.getDocenteAusenteNombre() : "");
                row.createCell(4).setCellValue(c.getDocenteReemplazoNombre() != null ? c.getDocenteReemplazoNombre() : "");
                row.createCell(5).setCellValue(c.getFranjaHorariaEtiqueta() != null ? c.getFranjaHorariaEtiqueta() : "");
                row.createCell(6).setCellValue(c.getCursoNombre() != null ? c.getCursoNombre() : "");
                row.createCell(7).setCellValue(c.getMateriaNombre() != null ? c.getMateriaNombre() : "");
                row.createCell(8).setCellValue(c.getRecursos() != null ? c.getRecursos() : "");
                row.createCell(9).setCellValue(c.getPeriodos() != null ? c.getPeriodos().doubleValue() : 0.0);
                row.createCell(10).setCellValue(c.getObservacion() != null ? c.getObservacion() : "");
            }

            for (int i = 0; i < headers.length; i++) {
                sheetDetalles.autoSizeColumn(i);
            }

            // Hoja 2: Resumen por Docentes
            Sheet sheetResumen = workbook.createSheet("Resumen por Docente");
            int rIdx = 0;

            Row rTitle = sheetResumen.createRow(rIdx++);
            Cell rTitleCell = rTitle.createCell(0);
            rTitleCell.setCellValue("TOTALES Y COBERTURA POR DOCENTE REEMPLAZANTE");
            rTitleCell.setCellStyle(titleStyle);
            rIdx++;

            Row rHeader = sheetResumen.createRow(rIdx++);
            String[] rHeaders = {"Docente Reemplazante", "Total Horas / Períodos", "Cantidad de Reemplazos"};
            for (int i = 0; i < rHeaders.length; i++) {
                Cell cell = rHeader.createCell(i);
                cell.setCellValue(rHeaders[i]);
                cell.setCellStyle(headerStyle);
            }

            for (DocenteEstadisticaDTO doc : reporte.getResumenDocentesReemplazo()) {
                Row row = sheetResumen.createRow(rIdx++);
                row.createCell(0).setCellValue(doc.getNombreDocente());
                row.createCell(1).setCellValue(doc.getTotalPeriodos() != null ? doc.getTotalPeriodos().doubleValue() : 0.0);
                row.createCell(2).setCellValue(doc.getCantidadContingencias() != null ? doc.getCantidadContingencias() : 0);
            }

            for (int i = 0; i < rHeaders.length; i++) {
                sheetResumen.autoSizeColumn(i);
            }

            workbook.write(out);
            return out.toByteArray();
        }
    }
}

