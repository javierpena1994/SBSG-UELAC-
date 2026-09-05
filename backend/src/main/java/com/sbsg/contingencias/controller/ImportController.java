package com.sbsg.contingencias.controller;

import com.sbsg.contingencias.repository.*;
import com.sbsg.contingencias.service.ExcelDataLoaderService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/import")
@CrossOrigin(origins = "*")
public class ImportController {

    private final ExcelDataLoaderService excelDataLoaderService;
    private final DocenteRepository docenteRepository;
    private final CursoRepository cursoRepository;
    private final MateriaRepository materiaRepository;
    private final FranjaHorariaRepository franjaHorariaRepository;
    private final HorarioDisponibilidadRepository disponibilidadRepository;
    private final ContingenciaRepository contingenciaRepository;

    @Value("${app.excel.file-path:../Contingencias 2026.xlsx}")
    private String excelFilePath;

    public ImportController(
            ExcelDataLoaderService excelDataLoaderService,
            DocenteRepository docenteRepository,
            CursoRepository cursoRepository,
            MateriaRepository materiaRepository,
            FranjaHorariaRepository franjaHorariaRepository,
            HorarioDisponibilidadRepository disponibilidadRepository,
            ContingenciaRepository contingenciaRepository) {
        this.excelDataLoaderService = excelDataLoaderService;
        this.docenteRepository = docenteRepository;
        this.cursoRepository = cursoRepository;
        this.materiaRepository = materiaRepository;
        this.franjaHorariaRepository = franjaHorariaRepository;
        this.disponibilidadRepository = disponibilidadRepository;
        this.contingenciaRepository = contingenciaRepository;
    }

    @PostMapping("/excel-default")
    public ResponseEntity<Map<String, Object>> importarExcelPorDefecto() {
        try {
            String[] possiblePaths = {
                excelFilePath,
                "../" + excelFilePath,
                "recursos/documentos_fuente/Contingencias 2026.xlsx",
                "../recursos/documentos_fuente/Contingencias 2026.xlsx",
                "Contingencias 2026.xlsx",
                "../Contingencias 2026.xlsx"
            };

            File file = null;
            for (String p : possiblePaths) {
                if (p == null) continue;
                File f = new File(p);
                if (f.exists() && f.isFile()) {
                    file = f;
                    break;
                }
            }

            if (file == null || !file.exists()) {
                Map<String, Object> error = new HashMap<>();
                error.put("error", "No se encontró el archivo Excel en las rutas configuradas.");
                return ResponseEntity.badRequest().body(error);
            }

            try (InputStream is = new FileInputStream(file)) {
                Map<String, Object> res = excelDataLoaderService.importarExcel(is);
                return ResponseEntity.ok(res);
            }
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("error", "Error al procesar el archivo Excel: " + e.getMessage());
            return ResponseEntity.internalServerError().body(error);
        }
    }

    @PostMapping("/upload")
    public ResponseEntity<Map<String, Object>> subirEImportarExcel(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            Map<String, Object> error = new HashMap<>();
            error.put("error", "El archivo cargado está vacío.");
            return ResponseEntity.badRequest().body(error);
        }

        try (InputStream is = file.getInputStream()) {
            Map<String, Object> res = excelDataLoaderService.importarExcel(is);
            return ResponseEntity.ok(res);
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("error", "Error al procesar el archivo Excel subido: " + e.getMessage());
            return ResponseEntity.internalServerError().body(error);
        }
    }

    @GetMapping("/status")
    public ResponseEntity<Map<String, Object>> obtenerEstadoBaseDatos() {
        Map<String, Object> status = new HashMap<>();
        status.put("totalDocentes", docenteRepository.count());
        status.put("totalCursos", cursoRepository.count());
        status.put("totalMaterias", materiaRepository.count());
        status.put("totalFranjasHorarias", franjaHorariaRepository.count());
        status.put("totalDisponibilidades", disponibilidadRepository.count());
        status.put("totalContingencias", contingenciaRepository.count());
        return ResponseEntity.ok(status);
    }
}

