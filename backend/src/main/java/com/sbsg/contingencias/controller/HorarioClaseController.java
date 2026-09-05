package com.sbsg.contingencias.controller;

import com.sbsg.contingencias.dto.GuardarHorarioClaseRequest;
import com.sbsg.contingencias.dto.HorarioClaseDTO;
import com.sbsg.contingencias.service.HorarioClaseService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/horarios-clases")
@CrossOrigin(origins = "*")
public class HorarioClaseController {

    private final HorarioClaseService horarioClaseService;

    public HorarioClaseController(HorarioClaseService horarioClaseService) {
        this.horarioClaseService = horarioClaseService;
    }

    @GetMapping("/docente/{docenteId}")
    public ResponseEntity<List<HorarioClaseDTO>> obtenerPorDocente(@PathVariable Long docenteId) {
        return ResponseEntity.ok(horarioClaseService.obtenerHorarioDocente(docenteId));
    }

    @GetMapping("/curso/{cursoId}")
    public ResponseEntity<List<HorarioClaseDTO>> obtenerPorCurso(@PathVariable Long cursoId) {
        return ResponseEntity.ok(horarioClaseService.obtenerHorarioCurso(cursoId));
    }

    @GetMapping("/detectar")
    public ResponseEntity<HorarioClaseDTO> detectarClase(
            @RequestParam("docenteId") Long docenteId,
            @RequestParam("fecha") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fecha,
            @RequestParam("franjaHorariaId") Long franjaHorariaId) {
        return horarioClaseService.detectarClase(docenteId, fecha, franjaHorariaId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.noContent().build());
    }

    @PostMapping("/guardar-docente")
    public ResponseEntity<List<HorarioClaseDTO>> guardarDocente(@RequestBody GuardarHorarioClaseRequest request) {
        return ResponseEntity.ok(horarioClaseService.guardarHorarioDocente(request));
    }

    @PostMapping("/guardar-curso")
    public ResponseEntity<List<HorarioClaseDTO>> guardarCurso(@RequestBody GuardarHorarioClaseRequest request) {
        return ResponseEntity.ok(horarioClaseService.guardarHorarioCurso(request));
    }
}

