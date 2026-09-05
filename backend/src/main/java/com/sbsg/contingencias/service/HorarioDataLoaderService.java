package com.sbsg.contingencias.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sbsg.contingencias.model.*;
import com.sbsg.contingencias.repository.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Order(2)
public class HorarioDataLoaderService implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(HorarioDataLoaderService.class);

    private final HorarioClaseRepository horarioClaseRepository;
    private final HorarioDisponibilidadRepository horarioDisponibilidadRepository;
    private final DocenteRepository docenteRepository;
    private final CursoRepository cursoRepository;
    private final MateriaRepository materiaRepository;
    private final FranjaHorariaRepository franjaHorariaRepository;

    public HorarioDataLoaderService(HorarioClaseRepository horarioClaseRepository,
                                    HorarioDisponibilidadRepository horarioDisponibilidadRepository,
                                    DocenteRepository docenteRepository,
                                    CursoRepository cursoRepository,
                                    MateriaRepository materiaRepository,
                                    FranjaHorariaRepository franjaHorariaRepository) {
        this.horarioClaseRepository = horarioClaseRepository;
        this.horarioDisponibilidadRepository = horarioDisponibilidadRepository;
        this.docenteRepository = docenteRepository;
        this.cursoRepository = cursoRepository;
        this.materiaRepository = materiaRepository;
        this.franjaHorariaRepository = franjaHorariaRepository;
    }

    @Override
    public void run(String... args) {
        try {
            asegurarFranjasHorarias();
            long count = horarioClaseRepository.count();
            if (count == 0) {
                log.info("Tabla de horarios_clases vacía. Cargando horarios de clases iniciales desde JSON...");
                cargarHorariosDesdeJson();
            } else {
                log.info("Base de datos ya cuenta con {} horarios de clases registrados.", count);
            }
        } catch (Exception e) {
            log.error("Error al cargar horarios de clases: {}", e.getMessage(), e);
        }
    }

    private void asegurarFranjasHorarias() {
        Optional<FranjaHoraria> opt13 = franjaHorariaRepository.findByEtiquetaIgnoreCase("13h40 - 14h20");
        if (opt13.isEmpty()) {
            opt13 = franjaHorariaRepository.findByEtiquetaIgnoreCase("13:40 - 14:20");
        }
        if (opt13.isEmpty()) {
            FranjaHoraria f13 = new FranjaHoraria("13h40 - 14h20", "13h40", "14h20", 13);
            franjaHorariaRepository.save(f13);
            log.info("Franja horaria '13h40 - 14h20' agregada automáticamente a la base de datos.");
        }

        // Asegurar orden cronológico canónico de todas las franjas
        List<FranjaHoraria> todas = franjaHorariaRepository.findAll();
        for (FranjaHoraria f : todas) {
            String et = f.getEtiqueta() != null ? f.getEtiqueta().trim() : "";
            int ordenCorrecto = switch (et) {
                case "07h10 - 07h50", "07:10 - 07:50" -> 1;
                case "07h50 - 08h30", "07:50 - 08:30" -> 2;
                case "08h30 - 09h10", "08:30 - 09:10" -> 3;
                case "09h10 - 09h50", "09:10 - 09:50" -> 4;
                case "09h50 - 10h20", "09:50 - 10:20" -> 5;
                case "09h50 - 10h30", "09:50 - 10:30" -> 6;
                case "10h20 - 11h00", "10:20 - 11h00" -> 7;
                case "10h30 - 11h00", "10:30 - 11:00" -> 8;
                case "11h00 - 11h40", "11:00 - 11:40" -> 9;
                case "11h40 - 12h20", "11:40 - 12:20" -> 10;
                case "12h20 - 13h00", "12:20 - 13:00" -> 11;
                case "13h00 - 13h40", "13:00 - 13:40" -> 12;
                case "13h40 - 14h20", "13:40 - 14:20" -> 13;
                default -> 99;
            };
            if (f.getOrden() == null || f.getOrden() != ordenCorrecto) {
                f.setOrden(ordenCorrecto);
                franjaHorariaRepository.save(f);
            }
        }
    }

    @Transactional
    public void cargarHorariosDesdeJson() {
        try {
            InputStream is = null;
            String[] possibleJsonPaths = {
                "data/horarios_docentes_parsed.json",
                "../data/horarios_docentes_parsed.json",
                "scripts/migracion_datos/horarios_docentes_parsed.json",
                "../scripts/migracion_datos/horarios_docentes_parsed.json"
            };

            for (String p : possibleJsonPaths) {
                File f = new File(p);
                if (f.exists() && f.isFile()) {
                    is = new FileInputStream(f);
                    log.info("Archivo JSON de horarios encontrado en: {}", f.getAbsolutePath());
                    break;
                }
            }

            if (is == null) {
                ClassPathResource resource = new ClassPathResource("data/horarios_docentes_parsed.json");
                if (resource.exists()) {
                    is = resource.getInputStream();
                    log.info("Archivo JSON de horarios cargado desde classpath: data/horarios_docentes_parsed.json");
                }
            }

            if (is == null) {
                log.warn("No se encontró el archivo de horarios data/horarios_docentes_parsed.json en ninguna ruta evaluada.");
                return;
            }

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(is);

            List<HorarioClase> listaClases = new ArrayList<>();
            List<HorarioDisponibilidad> listaDisponibilidad = new ArrayList<>();

            for (JsonNode docNode : root) {
                Long docenteId = docNode.get("docenteId").asLong();
                Docente docente = docenteRepository.findById(docenteId).orElse(null);
                if (docente == null) continue;

                JsonNode slotsNode = docNode.get("slots");
                if (slotsNode != null && slotsNode.isArray()) {
                    for (JsonNode slot : slotsNode) {
                        String diaSemana = slot.get("diaSemana").asText();
                        Long franjaId = slot.get("franjaHorariaId").asLong();
                        FranjaHoraria franja = franjaHorariaRepository.findById(franjaId).orElse(null);
                        if (franja == null) continue;

                        Curso curso = null;
                        if (slot.has("cursoId") && !slot.get("cursoId").isNull()) {
                            curso = cursoRepository.findById(slot.get("cursoId").asLong()).orElse(null);
                        }

                        Materia materia = null;
                        if (slot.has("materiaId") && !slot.get("materiaId").isNull()) {
                            materia = materiaRepository.findById(slot.get("materiaId").asLong()).orElse(null);
                        }

                        String actividad = slot.has("actividad") ? slot.get("actividad").asText() : "";
                        boolean esClase = slot.has("esClase") && slot.get("esClase").asBoolean();

                        HorarioClase hc = new HorarioClase(docente, diaSemana, franja, curso, materia, actividad, esClase);
                        listaClases.add(hc);

                        if (!esClase) {
                            listaDisponibilidad.add(new HorarioDisponibilidad(docente, diaSemana, franja));
                        }
                    }
                }
            }

            horarioClaseRepository.saveAll(listaClases);

            // Reemplazar disponibilidad con las horas realmente libres
            horarioDisponibilidadRepository.deleteAll();
            horarioDisponibilidadRepository.saveAll(listaDisponibilidad);

            log.info("Cargados exitosamente {} registros de HorarioClase y {} registros de Disponibilidad Libre.",
                    listaClases.size(), listaDisponibilidad.size());

        } catch (Exception e) {
            log.error("Error al procesar JSON de horarios: {}", e.getMessage(), e);
        }
    }
}

