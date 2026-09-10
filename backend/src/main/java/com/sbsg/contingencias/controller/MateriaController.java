package com.sbsg.contingencias.controller;

import com.sbsg.contingencias.model.Materia;
import com.sbsg.contingencias.service.MateriaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/materias")
@CrossOrigin(origins = "*")
public class MateriaController {

    private final MateriaService materiaService;

    public MateriaController(MateriaService materiaService) {
        this.materiaService = materiaService;
    }

    @GetMapping
    public ResponseEntity<List<Materia>> listar() {
        return ResponseEntity.ok(materiaService.obtenerTodas());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Materia> obtenerPorId(@PathVariable("id") Long id) {
        return materiaService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Materia> crear(@RequestBody Materia materia) {
        return ResponseEntity.ok(materiaService.guardar(materia));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Materia> actualizar(@PathVariable("id") Long id, @RequestBody Materia materia) {
        return ResponseEntity.ok(materiaService.actualizar(id, materia));
    }

    @PatchMapping("/{id}/toggle-examen")
    public ResponseEntity<Materia> toggleAplicaExamen(@PathVariable("id") Long id) {
        return ResponseEntity.ok(materiaService.toggleAplicaExamen(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, Object>> eliminar(@PathVariable("id") Long id) {
        materiaService.eliminar(id);
        Map<String, Object> resp = new HashMap<>();
        resp.put("id", id);
        resp.put("message", "Materia eliminada correctamente.");
        return ResponseEntity.ok(resp);
    }
}
