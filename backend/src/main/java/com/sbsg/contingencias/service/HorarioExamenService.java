package com.sbsg.contingencias.service;

import com.sbsg.contingencias.dto.GenerarSorteoExamenRequest;
import com.sbsg.contingencias.dto.HorarioExamenDTO;
import com.sbsg.contingencias.dto.HorarioExamenDetalleDTO;
import com.sbsg.contingencias.dto.MateriaEvaluacionDTO;
import com.sbsg.contingencias.model.*;
import com.sbsg.contingencias.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class HorarioExamenService {

    private final HorarioExamenRepository horarioExamenRepository;
    private final HorarioExamenDetalleRepository horarioExamenDetalleRepository;
    private final MateriaCursoConfigRepository materiaCursoConfigRepository;
    private final CursoRepository cursoRepository;
    private final MateriaRepository materiaRepository;
    private final HorarioClaseRepository horarioClaseRepository;

    public HorarioExamenService(
            HorarioExamenRepository horarioExamenRepository,
            HorarioExamenDetalleRepository horarioExamenDetalleRepository,
            MateriaCursoConfigRepository materiaCursoConfigRepository,
            CursoRepository cursoRepository,
            MateriaRepository materiaRepository,
            HorarioClaseRepository horarioClaseRepository) {
        this.horarioExamenRepository = horarioExamenRepository;
        this.horarioExamenDetalleRepository = horarioExamenDetalleRepository;
        this.materiaCursoConfigRepository = materiaCursoConfigRepository;
        this.cursoRepository = cursoRepository;
        this.materiaRepository = materiaRepository;
        this.horarioClaseRepository = horarioClaseRepository;
    }

    public List<MateriaEvaluacionDTO> obtenerMateriasPorCurso(Long cursoId) {
        Map<Long, MateriaEvaluacionDTO> map = new LinkedHashMap<>();

        // 1. Cruzar primero con configuraciones guardadas explícitas en materias_cursos_config
        if (cursoId != null) {
            List<MateriaCursoConfig> configs = materiaCursoConfigRepository.findByCursoIdAndActivoTrue(cursoId);
            for (MateriaCursoConfig cfg : configs) {
                Materia m = cfg.getMateria();
                map.put(m.getId(), new MateriaEvaluacionDTO(cfg.getId(), m.getId(), m.getNombre(), cfg.getTipoComplejidad(), true, ""));
            }
        }

        // 2. Si no hay configuración previa, derivar automáticamente de los horarios de clases reales
        if (map.isEmpty() && cursoId != null) {
            List<HorarioClase> clasesCurso = horarioClaseRepository.findByCursoId(cursoId);
            for (HorarioClase hc : clasesCurso) {
                if (hc.isEsClase() && hc.getMateria() != null) {
                    Materia m = hc.getMateria();
                    if (!map.containsKey(m.getId())) {
                        String docenteNom = hc.getDocente() != null ? hc.getDocente().getNombreCompleto() : "";
                        String complejidad = sugerirComplejidadPorNombre(m.getNombre());
                        map.put(m.getId(), new MateriaEvaluacionDTO(null, m.getId(), m.getNombre(), complejidad, true, docenteNom));
                    }
                }
            }
        }

        // 3. Si aún está vacío, cargar las materias del catálogo general
        if (map.isEmpty()) {
            List<Materia> todas = materiaRepository.findAllByOrderByNombreAsc();
            for (Materia m : todas) {
                String complejidad = sugerirComplejidadPorNombre(m.getNombre());
                map.put(m.getId(), new MateriaEvaluacionDTO(null, m.getId(), m.getNombre(), complejidad, true, ""));
            }
        }

        return new ArrayList<>(map.values());
    }

    @Transactional
    public MateriaEvaluacionDTO asignarMateriaACurso(Long cursoId, Long materiaId, String tipoComplejidad) {
        Curso curso = cursoRepository.findById(cursoId)
                .orElseThrow(() -> new RuntimeException("Curso no encontrado con ID: " + cursoId));
        Materia materia = materiaRepository.findById(materiaId)
                .orElseThrow(() -> new RuntimeException("Materia no encontrada con ID: " + materiaId));

        String complejidad = tipoComplejidad != null ? tipoComplejidad : sugerirComplejidadPorNombre(materia.getNombre());

        Optional<MateriaCursoConfig> opt = materiaCursoConfigRepository.findByCursoIdAndMateriaId(cursoId, materiaId);
        MateriaCursoConfig cfg;
        if (opt.isPresent()) {
            cfg = opt.get();
            cfg.setTipoComplejidad(complejidad);
            cfg.setActivo(true);
        } else {
            cfg = new MateriaCursoConfig(curso, materia, complejidad, true);
        }

        MateriaCursoConfig guardado = materiaCursoConfigRepository.save(cfg);
        return new MateriaEvaluacionDTO(guardado.getId(), materia.getId(), materia.getNombre(), guardado.getTipoComplejidad(), true, "");
    }

    @Transactional
    public void desasignarMateriaDeCurso(Long cursoId, Long materiaId) {
        Optional<MateriaCursoConfig> opt = materiaCursoConfigRepository.findByCursoIdAndMateriaId(cursoId, materiaId);
        if (opt.isPresent()) {
            materiaCursoConfigRepository.delete(opt.get());
        }
    }

    @Transactional
    public MateriaEvaluacionDTO cambiarComplejidadMateriaCurso(Long cursoId, Long materiaId, String tipoComplejidad) {
        return asignarMateriaACurso(cursoId, materiaId, tipoComplejidad);
    }

    @Transactional
    public List<MateriaEvaluacionDTO> guardarConfiguracionMateriasCurso(Long cursoId, List<MateriaEvaluacionDTO> materias) {
        Curso curso = cursoRepository.findById(cursoId)
                .orElseThrow(() -> new RuntimeException("Curso no encontrado con ID: " + cursoId));

        // Obtener configs existentes y eliminarlas para reemplazar con la nueva lista exacta
        List<MateriaCursoConfig> existentes = materiaCursoConfigRepository.findByCursoIdAndActivoTrue(cursoId);
        materiaCursoConfigRepository.deleteAll(existentes);

        List<MateriaEvaluacionDTO> resultado = new ArrayList<>();
        for (MateriaEvaluacionDTO dto : materias) {
            if (dto.getMateriaId() != null) {
                Materia m = materiaRepository.findById(dto.getMateriaId()).orElse(null);
                if (m != null) {
                    String compl = dto.getTipoComplejidad() != null ? dto.getTipoComplejidad() : sugerirComplejidadPorNombre(m.getNombre());
                    MateriaCursoConfig guardado = materiaCursoConfigRepository.save(new MateriaCursoConfig(curso, m, compl, true));
                    resultado.add(new MateriaEvaluacionDTO(guardado.getId(), m.getId(), m.getNombre(), guardado.getTipoComplejidad(), true, ""));
                }
            }
        }
        return resultado;
    }

    public static String sugerirComplejidadPorNombre(String nombreMateria) {
        if (nombreMateria == null) return "COMPLEJA";
        String n = nombreMateria.toUpperCase().trim();

        // Patrones de materias menos complejas
        if (n.contains("FÍSICA") && n.contains("EDUCACIÓN")) return "NO_COMPLEJA";
        if (n.contains("EDUCACION FISICA") || n.contains("EDUCACIÓN FÍSICA") || n.contains("ED. FISICA") || n.contains("ED. FÍSICA")) return "NO_COMPLEJA";
        if (n.contains("CULTURAL") || n.contains("ARTÍSTICA") || n.contains("ARTISTICA") || n.contains("ECA") || n.contains("ARTE")) return "NO_COMPLEJA";
        if (n.contains("INGLÉS") || n.contains("INGLES") || n.contains("ENGLISH")) return "NO_COMPLEJA";
        if (n.contains("INFORMÁTICA") || n.contains("INFORMATICA") || n.contains("COMPUTACIÓN") || n.contains("COMPUTACION") || n.contains("TIC")) return "NO_COMPLEJA";
        if (n.contains("EMPRENDIMIENTO") || n.contains("GESTIÓN") || n.contains("GESTION")) return "NO_COMPLEJA";
        if (n.contains("CIUDADANÍA") || n.contains("CIUDADANIA") || n.contains("CÍVICA") || n.contains("CIVICA")) return "NO_COMPLEJA";
        if (n.contains("RELIGIÓN") || n.contains("RELIGION") || n.contains("VALORES") || n.contains("PASTORAL")) return "NO_COMPLEJA";
        if (n.contains("TUTORÍA") || n.contains("TUTORIA") || n.contains("PROYECTO") || n.contains("LECTURA") || n.contains("ROBÓTICA") || n.contains("ROBOTICA")) return "NO_COMPLEJA";
        if (n.contains("DESARROLLO DEL PENSAMIENTO") || n.contains("DESARROLLO HUMANO")) return "NO_COMPLEJA";

        // Por defecto: Matemática, Física, Química, Biología, Lengua, Historia, Filosofía, etc. son complejas
        return "COMPLEJA";
    }

    public HorarioExamenDTO generarSorteoAleatorio(GenerarSorteoExamenRequest req) {
        if (req.getFechaInicio() == null) {
            req.setFechaInicio(LocalDate.now().plusDays(1));
        }
        int numDias = req.getNumDias() != null && req.getNumDias() > 0 ? req.getNumDias() : 5;
        int materiasPorDia = req.getMateriasPorDia() != null && req.getMateriasPorDia() > 0 ? req.getMateriasPorDia() : 2;

        List<MateriaEvaluacionDTO> seleccionadas = req.getMaterias() != null
                ? req.getMaterias().stream().filter(MateriaEvaluacionDTO::isSeleccionada).collect(Collectors.toList())
                : Collections.emptyList();

        if (seleccionadas.isEmpty()) {
            throw new IllegalArgumentException("Debe seleccionar al menos una materia para sortear el horario de exámenes.");
        }

        // Separar materias en Complejas y Menos Complejas
        List<MateriaEvaluacionDTO> complejas = new ArrayList<>();
        List<MateriaEvaluacionDTO> noComplejas = new ArrayList<>();

        for (MateriaEvaluacionDTO m : seleccionadas) {
            if ("NO_COMPLEJA".equalsIgnoreCase(m.getTipoComplejidad())) {
                noComplejas.add(m);
            } else {
                complejas.add(m);
            }
        }

        // Sorteo aleatorio real mediante SecureRandom (cada ejecución genera una combinación diferente)
        SecureRandom random = new SecureRandom();
        Collections.shuffle(complejas, random);
        Collections.shuffle(noComplejas, random);

        // Generar lista de fechas hábiles (saltando sábados y domingos si corresponde)
        List<LocalDate> fechas = new ArrayList<>();
        LocalDate curDate = req.getFechaInicio();
        while (fechas.size() < numDias) {
            if (req.isSaltarFinesDeSemana()) {
                if (curDate.getDayOfWeek() != DayOfWeek.SATURDAY && curDate.getDayOfWeek() != DayOfWeek.SUNDAY) {
                    fechas.add(curDate);
                }
            } else {
                fechas.add(curDate);
            }
            curDate = curDate.plusDays(1);
        }

        LocalDate fechaFin = fechas.isEmpty() ? req.getFechaInicio() : fechas.get(fechas.size() - 1);

        String nombreCurso = null;
        if (req.getCursoId() != null) {
            nombreCurso = cursoRepository.findById(req.getCursoId()).map(Curso::getNombre).orElse("General");
        } else {
            nombreCurso = "Todos los Cursos";
        }

        HorarioExamenDTO horarioDTO = new HorarioExamenDTO();
        horarioDTO.setTitulo(req.getTitulo() != null && !req.getTitulo().trim().isEmpty() ? req.getTitulo().trim() : "Horario de Exámenes - " + nombreCurso);
        horarioDTO.setCursoId(req.getCursoId());
        horarioDTO.setCursoNombre(nombreCurso);
        horarioDTO.setFechaInicio(req.getFechaInicio());
        horarioDTO.setFechaFin(fechaFin);
        horarioDTO.setNumDias(numDias);
        horarioDTO.setMateriasPorDia(materiasPorDia);

        String hora1Ini = req.getHoraInicio1() != null ? req.getHoraInicio1() : "07h30";
        String hora1Fin = req.getHoraFin1() != null ? req.getHoraFin1() : "08h50";
        String hora2Ini = req.getHoraInicio2() != null ? req.getHoraInicio2() : "09h10";
        String hora2Fin = req.getHoraFin2() != null ? req.getHoraFin2() : "10h30";

        List<HorarioExamenDetalleDTO> detalles = new ArrayList<>();

        int idxCompleja = 0;
        int idxNoCompleja = 0;

        for (int d = 0; d < numDias; d++) {
            int diaNumero = d + 1;
            LocalDate fechaDia = fechas.get(d);
            String diaSemana = DisponibilidadService.obtenerDiaSemanaEnEspanol(fechaDia);

            // Slot 1: Intentar asignar Materia Compleja
            MateriaEvaluacionDTO mSlot1 = null;
            if (idxCompleja < complejas.size()) {
                mSlot1 = complejas.get(idxCompleja++);
            } else if (idxNoCompleja < noComplejas.size()) {
                mSlot1 = noComplejas.get(idxNoCompleja++);
            }

            if (mSlot1 != null) {
                detalles.add(new HorarioExamenDetalleDTO(
                        null,
                        diaNumero,
                        fechaDia,
                        diaSemana,
                        1,
                        mSlot1.getMateriaId(),
                        mSlot1.getMateriaNombre(),
                        mSlot1.getTipoComplejidad(),
                        hora1Ini,
                        hora1Fin,
                        mSlot1.getDocenteNombre()
                ));
            }

            // Slot 2: Intentar asignar Materia Menos Compleja
            if (materiasPorDia >= 2) {
                MateriaEvaluacionDTO mSlot2 = null;
                if (idxNoCompleja < noComplejas.size()) {
                    mSlot2 = noComplejas.get(idxNoCompleja++);
                } else if (idxCompleja < complejas.size()) {
                    mSlot2 = complejas.get(idxCompleja++);
                }

                if (mSlot2 != null) {
                    detalles.add(new HorarioExamenDetalleDTO(
                            null,
                            diaNumero,
                            fechaDia,
                            diaSemana,
                            2,
                            mSlot2.getMateriaId(),
                            mSlot2.getMateriaNombre(),
                            mSlot2.getTipoComplejidad(),
                            hora2Ini,
                            hora2Fin,
                            mSlot2.getDocenteNombre()
                    ));
                }
            }
        }

        // Si aún sobran materias no ubicadas, agregarlas equitativamente
        int extraDia = 1;
        while (idxCompleja < complejas.size() || idxNoCompleja < noComplejas.size()) {
            MateriaEvaluacionDTO extraM = idxCompleja < complejas.size() ? complejas.get(idxCompleja++) : noComplejas.get(idxNoCompleja++);
            LocalDate f = extraDia <= fechas.size() ? fechas.get(extraDia - 1) : fechaFin;
            String diaSem = DisponibilidadService.obtenerDiaSemanaEnEspanol(f);
            detalles.add(new HorarioExamenDetalleDTO(
                    null,
                    extraDia,
                    f,
                    diaSem,
                    3,
                    extraM.getMateriaId(),
                    extraM.getMateriaNombre(),
                    extraM.getTipoComplejidad(),
                    "10h50",
                    "12h10",
                    extraM.getDocenteNombre()
            ));
            extraDia = (extraDia % numDias) + 1;
        }

        horarioDTO.setDetalles(detalles);
        return horarioDTO;
    }

    @Transactional
    public HorarioExamenDTO guardar(HorarioExamenDTO dto) {
        if (dto == null || dto.getDetalles() == null || dto.getDetalles().isEmpty()) {
            throw new IllegalArgumentException("El horario de examen a guardar no puede estar vacío.");
        }

        Curso curso = dto.getCursoId() != null ? cursoRepository.findById(dto.getCursoId()).orElse(null) : null;

        HorarioExamen he = new HorarioExamen();
        if (dto.getId() != null) {
            he = horarioExamenRepository.findById(dto.getId()).orElse(new HorarioExamen());
        }

        he.setTitulo(dto.getTitulo());
        he.setCurso(curso);
        he.setFechaInicio(dto.getFechaInicio());
        he.setFechaFin(dto.getFechaFin());
        he.setNumDias(dto.getNumDias());
        he.setMateriasPorDia(dto.getMateriasPorDia());
        he.setObservaciones(dto.getObservaciones());

        he.getDetalles().clear();

        for (HorarioExamenDetalleDTO dDTO : dto.getDetalles()) {
            Materia mat = dDTO.getMateriaId() != null ? materiaRepository.findById(dDTO.getMateriaId()).orElse(null) : null;
            HorarioExamenDetalle det = new HorarioExamenDetalle(
                    he,
                    dDTO.getDiaNumero(),
                    dDTO.getFecha(),
                    dDTO.getDiaSemana(),
                    dDTO.getOrdenDia(),
                    mat,
                    dDTO.getMateriaNombre(),
                    dDTO.getTipoComplejidad(),
                    dDTO.getHoraInicio(),
                    dDTO.getHoraFin(),
                    dDTO.getDocenteSupervisor()
            );
            he.getDetalles().add(det);
        }

        HorarioExamen guardado = horarioExamenRepository.save(he);
        return toDTO(guardado);
    }

    public List<HorarioExamenDTO> obtenerHistorial() {
        return horarioExamenRepository.findAllByOrderByCreatedAtDesc().stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    public HorarioExamenDTO obtenerPorId(Long id) {
        HorarioExamen he = horarioExamenRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Horario de examen no encontrado con ID: " + id));
        return toDTO(he);
    }

    @Transactional
    public void eliminar(Long id) {
        if (!horarioExamenRepository.existsById(id)) {
            throw new RuntimeException("Horario de examen no encontrado con ID: " + id);
        }
        horarioExamenRepository.deleteById(id);
    }

    public HorarioExamenDTO toDTO(HorarioExamen he) {
        HorarioExamenDTO dto = new HorarioExamenDTO();
        dto.setId(he.getId());
        dto.setTitulo(he.getTitulo());
        if (he.getCurso() != null) {
            dto.setCursoId(he.getCurso().getId());
            dto.setCursoNombre(he.getCurso().getNombre());
        }
        dto.setFechaInicio(he.getFechaInicio());
        dto.setFechaFin(he.getFechaFin());
        dto.setNumDias(he.getNumDias());
        dto.setMateriasPorDia(he.getMateriasPorDia());
        dto.setObservaciones(he.getObservaciones());
        dto.setCreatedAt(he.getCreatedAt());

        List<HorarioExamenDetalleDTO> detDTOs = he.getDetalles().stream().map(d -> new HorarioExamenDetalleDTO(
                d.getId(),
                d.getDiaNumero(),
                d.getFecha(),
                d.getDiaSemana(),
                d.getOrdenDia(),
                d.getMateria() != null ? d.getMateria().getId() : null,
                d.getMateriaNombre() != null ? d.getMateriaNombre() : (d.getMateria() != null ? d.getMateria().getNombre() : null),
                d.getTipoComplejidad(),
                d.getHoraInicio(),
                d.getHoraFin(),
                d.getDocenteSupervisor()
        )).collect(Collectors.toList());

        dto.setDetalles(detDTOs);
        return dto;
    }
}

