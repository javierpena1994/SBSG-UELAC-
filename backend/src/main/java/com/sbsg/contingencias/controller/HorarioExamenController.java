package com.sbsg.contingencias.controller;

import com.sbsg.contingencias.dto.GenerarSorteoExamenRequest;
import com.sbsg.contingencias.dto.HorarioExamenDTO;
import com.sbsg.contingencias.dto.MateriaEvaluacionDTO;
import com.sbsg.contingencias.service.HorarioExamenService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/examenes")
@CrossOrigin(origins = "*")
public class HorarioExamenController {

    private final HorarioExamenService horarioExamenService;

    public HorarioExamenController(HorarioExamenService horarioExamenService) {
        this.horarioExamenService = horarioExamenService;
    }

    @GetMapping("/materias-curso/{cursoId}")
    public ResponseEntity<List<MateriaEvaluacionDTO>> obtenerMateriasPorCurso(@PathVariable Long cursoId) {
        return ResponseEntity.ok(horarioExamenService.obtenerMateriasPorCurso(cursoId));
    }

    @PostMapping("/generar-sorteo")
    public ResponseEntity<HorarioExamenDTO> generarSorteo(@RequestBody GenerarSorteoExamenRequest request) {
        return ResponseEntity.ok(horarioExamenService.generarSorteoAleatorio(request));
    }

    @PostMapping("/guardar")
    public ResponseEntity<HorarioExamenDTO> guardar(@RequestBody HorarioExamenDTO dto) {
        return ResponseEntity.ok(horarioExamenService.guardar(dto));
    }

    @GetMapping("/historial")
    public ResponseEntity<List<HorarioExamenDTO>> obtenerHistorial() {
        return ResponseEntity.ok(horarioExamenService.obtenerHistorial());
    }

    @GetMapping("/{id}")
    public ResponseEntity<HorarioExamenDTO> obtenerPorId(@PathVariable Long id) {
        return ResponseEntity.ok(horarioExamenService.obtenerPorId(id));
    }

    @PostMapping("/curso-materias/{cursoId}/guardar")
    public ResponseEntity<List<MateriaEvaluacionDTO>> guardarConfiguracionMateriasCurso(
            @PathVariable Long cursoId,
            @RequestBody List<MateriaEvaluacionDTO> materias) {
        return ResponseEntity.ok(horarioExamenService.guardarConfiguracionMateriasCurso(cursoId, materias));
    }

    @PostMapping("/curso-materias/{cursoId}/asignar")
    public ResponseEntity<MateriaEvaluacionDTO> asignarMateria(
            @PathVariable Long cursoId,
            @RequestParam Long materiaId,
            @RequestParam(required = false) String tipoComplejidad) {
        return ResponseEntity.ok(horarioExamenService.asignarMateriaACurso(cursoId, materiaId, tipoComplejidad));
    }

    @DeleteMapping("/curso-materias/{cursoId}/materia/{materiaId}")
    public ResponseEntity<Map<String, Object>> desasignarMateria(
            @PathVariable Long cursoId,
            @PathVariable Long materiaId) {
        horarioExamenService.desasignarMateriaDeCurso(cursoId, materiaId);
        Map<String, Object> resp = new HashMap<>();
        resp.put("status", "SUCCESS");
        resp.put("message", "Materia desasignada del curso.");
        return ResponseEntity.ok(resp);
    }

    @PatchMapping("/curso-materias/{cursoId}/materia/{materiaId}/complejidad")
    public ResponseEntity<MateriaEvaluacionDTO> cambiarComplejidad(
            @PathVariable Long cursoId,
            @PathVariable Long materiaId,
            @RequestParam String tipoComplejidad) {
        return ResponseEntity.ok(horarioExamenService.cambiarComplejidadMateriaCurso(cursoId, materiaId, tipoComplejidad));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, Object>> eliminar(@PathVariable Long id) {
        horarioExamenService.eliminar(id);
        Map<String, Object> resp = new HashMap<>();
        resp.put("status", "SUCCESS");
        resp.put("message", "Horario de examen eliminado exitosamente.");
        return ResponseEntity.ok(resp);
    }
}

