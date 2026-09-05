package com.sbsg.contingencias.controller;

import com.sbsg.contingencias.model.Docente;
import com.sbsg.contingencias.service.DocenteService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/docentes")
@CrossOrigin(origins = "*")
public class DocenteController {

    private final DocenteService docenteService;

    public DocenteController(DocenteService docenteService) {
        this.docenteService = docenteService;
    }

    @GetMapping
    public ResponseEntity<List<Docente>> listar() {
        return ResponseEntity.ok(docenteService.obtenerTodosActivos());
    }

    @GetMapping("/todos")
    public ResponseEntity<List<Docente>> listarTodos() {
        return ResponseEntity.ok(docenteService.obtenerTodos());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Docente> obtenerPorId(@PathVariable Long id) {
        return docenteService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Docente> crear(@RequestBody Docente docente) {
        return ResponseEntity.ok(docenteService.guardar(docente));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Docente> actualizar(@PathVariable Long id, @RequestBody Docente docente) {
        return ResponseEntity.ok(docenteService.actualizar(id, docente));
    }

    @PatchMapping("/{id}/toggle-estado")
    public ResponseEntity<Map<String, Object>> toggleEstado(@PathVariable Long id) {
        boolean nuevoEstado = docenteService.toggleActivo(id);
        Map<String, Object> resp = new HashMap<>();
        resp.put("id", id);
        resp.put("activo", nuevoEstado);
        resp.put("message", nuevoEstado ? "Docente activado exitosamente." : "Docente desactivado exitosamente.");
        return ResponseEntity.ok(resp);
    }
}
