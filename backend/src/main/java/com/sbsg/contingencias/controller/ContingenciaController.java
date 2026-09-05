package com.sbsg.contingencias.controller;

import com.sbsg.contingencias.dto.ContingenciaDTO;
import com.sbsg.contingencias.dto.ContingenciaRequest;
import com.sbsg.contingencias.service.ContingenciaService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/contingencias")
@CrossOrigin(origins = "*")
public class ContingenciaController {

    private final ContingenciaService contingenciaService;

    public ContingenciaController(ContingenciaService contingenciaService) {
        this.contingenciaService = contingenciaService;
    }

    @GetMapping
    public ResponseEntity<List<ContingenciaDTO>> listar(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaInicio,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaFin,
            @RequestParam(required = false) Long docenteAusenteId,
            @RequestParam(required = false) Long docenteReemplazoId,
            @RequestParam(required = false) Long cursoId,
            @RequestParam(required = false) Long materiaId) {
        return ResponseEntity.ok(contingenciaService.filtrar(fechaInicio, fechaFin, docenteAusenteId, docenteReemplazoId, cursoId, materiaId));
    }

    @GetMapping("/paginado")
    public ResponseEntity<Page<ContingenciaDTO>> listarPaginado(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaInicio,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaFin,
            @RequestParam(required = false) Long docenteAusenteId,
            @RequestParam(required = false) Long docenteReemplazoId,
            @RequestParam(required = false) Long cursoId,
            @RequestParam(required = false) Long materiaId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "15") int size) {
        return ResponseEntity.ok(contingenciaService.filtrarPaginado(fechaInicio, fechaFin, docenteAusenteId, docenteReemplazoId, cursoId, materiaId, PageRequest.of(page, size)));
    }

    @GetMapping("/recientes")
    public ResponseEntity<List<ContingenciaDTO>> recientes() {
        return ResponseEntity.ok(contingenciaService.obtenerRecientes());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ContingenciaDTO> obtenerPorId(@PathVariable Long id) {
        return ResponseEntity.ok(contingenciaService.obtenerPorId(id));
    }

    @PostMapping
    public ResponseEntity<ContingenciaDTO> registrar(@Valid @RequestBody ContingenciaRequest request) {
        ContingenciaDTO creada = contingenciaService.guardar(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(creada);
    }

    @PostMapping("/lote")
    public ResponseEntity<List<ContingenciaDTO>> registrarLote(@Valid @RequestBody List<ContingenciaRequest> requests) {
        List<ContingenciaDTO> creadas = contingenciaService.guardarLote(requests);
        return ResponseEntity.status(HttpStatus.CREATED).body(creadas);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ContingenciaDTO> actualizar(@PathVariable Long id, @Valid @RequestBody ContingenciaRequest request) {
        return ResponseEntity.ok(contingenciaService.actualizar(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        contingenciaService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}

