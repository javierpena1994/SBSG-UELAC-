package com.sbsg.contingencias.controller;

import com.sbsg.contingencias.dto.DocenteDisponibleDTO;
import com.sbsg.contingencias.dto.GuardarHorarioDocenteRequest;
import com.sbsg.contingencias.dto.HorarioSlotDTO;
import com.sbsg.contingencias.model.HorarioDisponibilidad;
import com.sbsg.contingencias.service.DisponibilidadService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/disponibilidad")
@CrossOrigin(origins = "*")
public class DisponibilidadController {

    private final DisponibilidadService disponibilidadService;

    public DisponibilidadController(DisponibilidadService disponibilidadService) {
        this.disponibilidadService = disponibilidadService;
    }

    @GetMapping("/disponibles")
    public ResponseEntity<List<DocenteDisponibleDTO>> buscarDisponibles(
            @RequestParam("fecha") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fecha,
            @RequestParam("franjaHorariaId") Long franjaHorariaId,
            @RequestParam(value = "docenteAusenteId", required = false) Long docenteAusenteId,
            @RequestParam(value = "cursoId", required = false) Long cursoId) {
        return ResponseEntity.ok(disponibilidadService.buscarDocentesParaReemplazo(fecha, franjaHorariaId, docenteAusenteId, cursoId));
    }

    @GetMapping("/docente/{docenteId}")
    public ResponseEntity<List<HorarioDisponibilidad>> obtenerPorDocente(@PathVariable Long docenteId) {
        return ResponseEntity.ok(disponibilidadService.obtenerDisponibilidadPorDocente(docenteId));
    }

    @GetMapping("/todos")
    public ResponseEntity<List<HorarioDisponibilidad>> obtenerTodos() {
        return ResponseEntity.ok(disponibilidadService.obtenerTodosLosHorarios());
    }

    @PostMapping("/guardar")
    public ResponseEntity<Map<String, Object>> guardarHorarioDocente(@RequestBody GuardarHorarioDocenteRequest request) {
        disponibilidadService.guardarHorarioDocente(request.getDocenteId(), request.getSlots());
        Map<String, Object> resp = new HashMap<>();
        resp.put("status", "SUCCESS");
        resp.put("message", "Horario actualizado exitosamente.");
        return ResponseEntity.ok(resp);
    }

    @PostMapping("/toggle")
    public ResponseEntity<Map<String, Object>> toggleSlot(
            @RequestParam Long docenteId,
            @RequestParam String diaSemana,
            @RequestParam Long franjaHorariaId) {
        boolean ahoraLibre = disponibilidadService.toggleSlot(docenteId, diaSemana, franjaHorariaId);
        Map<String, Object> resp = new HashMap<>();
        resp.put("status", "SUCCESS");
        resp.put("ahoraLibre", ahoraLibre);
        return ResponseEntity.ok(resp);
    }

    @PostMapping("/limpiar-todos")
    public ResponseEntity<Map<String, Object>> limpiarTodos() {
        disponibilidadService.limpiarTodosLosHorarios();
        Map<String, Object> resp = new HashMap<>();
        resp.put("status", "SUCCESS");
        resp.put("message", "Todos los horarios de disponibilidad han sido reseteados.");
        return ResponseEntity.ok(resp);
    }
}
