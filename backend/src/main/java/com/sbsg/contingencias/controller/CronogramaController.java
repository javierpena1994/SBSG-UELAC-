package com.sbsg.contingencias.controller;

import com.sbsg.contingencias.dto.ActividadCronogramaDTO;
import com.sbsg.contingencias.service.CronogramaService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/cronograma")
@CrossOrigin(origins = "*")
public class CronogramaController {

    private final CronogramaService cronogramaService;

    public CronogramaController(CronogramaService cronogramaService) {
        this.cronogramaService = cronogramaService;
    }

    @GetMapping
    public ResponseEntity<List<ActividadCronogramaDTO>> obtenerActividades(
            @RequestParam(value = "categoria", required = false) String categoria,
            @RequestParam(value = "estado", required = false) String estado,
            @RequestParam(value = "dirigidoA", required = false) String dirigidoA) {
        return ResponseEntity.ok(cronogramaService.filtrar(categoria, estado, dirigidoA));
    }

    @GetMapping("/rango")
    public ResponseEntity<List<ActividadCronogramaDTO>> obtenerPorRango(
            @RequestParam("fechaInicio") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaInicio,
            @RequestParam("fechaFin") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaFin) {
        return ResponseEntity.ok(cronogramaService.obtenerPorRango(fechaInicio, fechaFin));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ActividadCronogramaDTO> obtenerPorId(@PathVariable Long id) {
        return ResponseEntity.ok(cronogramaService.obtenerPorId(id));
    }

    @PostMapping
    public ResponseEntity<ActividadCronogramaDTO> guardar(@RequestBody ActividadCronogramaDTO dto) {
        return ResponseEntity.ok(cronogramaService.guardar(dto));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ActividadCronogramaDTO> actualizar(@PathVariable Long id, @RequestBody ActividadCronogramaDTO dto) {
        return ResponseEntity.ok(cronogramaService.actualizar(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, Object>> eliminar(@PathVariable Long id) {
        cronogramaService.eliminar(id);
        Map<String, Object> resp = new HashMap<>();
        resp.put("status", "SUCCESS");
        resp.put("message", "Actividad eliminada exitosamente del cronograma.");
        return ResponseEntity.ok(resp);
    }
}

