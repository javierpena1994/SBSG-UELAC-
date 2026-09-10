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
        if (cursoId == null) {
            return Collections.emptyList();
        }

        // 1. Obtener todas las configuraciones guardadas para este curso en materias_cursos_config
        Map<Long, MateriaCursoConfig> configMap = materiaCursoConfigRepository.findByCursoId(cursoId).stream()
                .filter(c -> c.getMateria() != null)
                .collect(Collectors.toMap(c -> c.getMateria().getId(), c -> c, (a, b) -> a));

        // 2. Extraer materias alimentadas en el horario real de clases del curso
        List<HorarioClase> clases = horarioClaseRepository.findByCursoId(cursoId);

        Map<Long, Materia> materiasCurso = new LinkedHashMap<>();
        Map<Long, String> docentesPorMateria = new HashMap<>();
        Map<Long, Integer> horasPorMateria = new HashMap<>();

        for (HorarioClase hc : clases) {
            if (hc.getMateria() != null) {
                Materia m = hc.getMateria();
                materiasCurso.putIfAbsent(m.getId(), m);
                horasPorMateria.put(m.getId(), horasPorMateria.getOrDefault(m.getId(), 0) + 1);
                if (hc.getDocente() != null && hc.getDocente().getNombreCompleto() != null && !hc.getDocente().getNombreCompleto().isBlank()) {
                    docentesPorMateria.putIfAbsent(m.getId(), hc.getDocente().getNombreCompleto().trim());
                }
            }
        }

        // Si el curso no tiene clases alimentadas aún, cargar del catálogo o de config
        if (materiasCurso.isEmpty()) {
            for (MateriaCursoConfig cfg : configMap.values()) {
                if (cfg.getMateria() != null) {
                    materiasCurso.putIfAbsent(cfg.getMateria().getId(), cfg.getMateria());
                }
            }
            if (materiasCurso.isEmpty()) {
                List<Materia> todas = materiaRepository.findAllByOrderByNombreAsc();
                for (Materia m : todas) {
                    materiasCurso.put(m.getId(), m);
                }
            }
        }

        // 3. Construir lista de MateriaEvaluacionDTO cruzando con configuraciones
        List<MateriaEvaluacionDTO> resultado = new ArrayList<>();

        for (Materia m : materiasCurso.values()) {
            Long mid = m.getId();
            String docente = docentesPorMateria.getOrDefault(mid, "");
            int horas = horasPorMateria.getOrDefault(mid, 1);

            MateriaCursoConfig cfg = configMap.get(mid);
            boolean tomaExamen;
            String dificultad;

            if (cfg != null) {
                tomaExamen = Boolean.TRUE.equals(cfg.getActivo());
                dificultad = MateriaEvaluacionDTO.normalizarDificultad(cfg.getTipoComplejidad());
            } else {
                // Sugerencias inteligentes según tipo de materia
                tomaExamen = sugerirTomaExamenPorMateria(m);
                dificultad = MateriaEvaluacionDTO.normalizarDificultad(sugerirComplejidadPorNombre(m.getNombre()));
            }

            Long cfgId = (cfg != null) ? cfg.getId() : null;
            resultado.add(new MateriaEvaluacionDTO(
                    cfgId,
                    mid,
                    m.getNombre(),
                    dificultad,
                    tomaExamen,
                    docente,
                    horas
            ));
        }

        // Ordenar alfabéticamente por nombre de materia
        resultado.sort(Comparator.comparing(MateriaEvaluacionDTO::getMateriaNombre));

        return resultado;
    }

    @Transactional
    public MateriaEvaluacionDTO actualizarConfiguracionMateriaCurso(Long cursoId, Long materiaId, Boolean tomaExamen, String dificultad) {
        Curso curso = cursoRepository.findById(cursoId)
                .orElseThrow(() -> new RuntimeException("Curso no encontrado con ID: " + cursoId));
        Materia materia = materiaRepository.findById(materiaId)
                .orElseThrow(() -> new RuntimeException("Materia no encontrada con ID: " + materiaId));

        MateriaCursoConfig cfg = materiaCursoConfigRepository.findByCursoIdAndMateriaId(cursoId, materiaId)
                .orElseGet(() -> {
                    String compl = MateriaEvaluacionDTO.normalizarDificultad(sugerirComplejidadPorNombre(materia.getNombre()));
                    boolean toma = sugerirTomaExamenPorMateria(materia);
                    return new MateriaCursoConfig(curso, materia, compl, toma);
                });

        if (tomaExamen != null) {
            cfg.setActivo(tomaExamen);
        }
        if (dificultad != null && !dificultad.isBlank()) {
            cfg.setTipoComplejidad(MateriaEvaluacionDTO.normalizarDificultad(dificultad));
        }

        MateriaCursoConfig guardado = materiaCursoConfigRepository.save(cfg);

        // Extraer docente y horas desde el horario del curso
        List<HorarioClase> clases = horarioClaseRepository.findByCursoId(cursoId);
        String docente = "";
        int horas = 0;
        for (HorarioClase hc : clases) {
            if (hc.getMateria() != null && hc.getMateria().getId().equals(materiaId)) {
                horas++;
                if (docente.isEmpty() && hc.getDocente() != null && hc.getDocente().getNombreCompleto() != null) {
                    docente = hc.getDocente().getNombreCompleto().trim();
                }
            }
        }

        return new MateriaEvaluacionDTO(
                guardado.getId(),
                materia.getId(),
                materia.getNombre(),
                MateriaEvaluacionDTO.normalizarDificultad(guardado.getTipoComplejidad()),
                Boolean.TRUE.equals(guardado.getActivo()),
                docente,
                horas > 0 ? horas : 1
        );
    }

    @Transactional
    public MateriaEvaluacionDTO asignarMateriaACurso(Long cursoId, Long materiaId, String tipoComplejidad) {
        return actualizarConfiguracionMateriaCurso(cursoId, materiaId, true, tipoComplejidad);
    }

    @Transactional
    public void desasignarMateriaDeCurso(Long cursoId, Long materiaId) {
        Optional<MateriaCursoConfig> opt = materiaCursoConfigRepository.findByCursoIdAndMateriaId(cursoId, materiaId);
        if (opt.isPresent()) {
            MateriaCursoConfig cfg = opt.get();
            cfg.setActivo(false);
            materiaCursoConfigRepository.save(cfg);
        }
    }

    @Transactional
    public MateriaEvaluacionDTO cambiarComplejidadMateriaCurso(Long cursoId, Long materiaId, String tipoComplejidad) {
        return actualizarConfiguracionMateriaCurso(cursoId, materiaId, null, tipoComplejidad);
    }

    @Transactional
    public List<MateriaEvaluacionDTO> guardarConfiguracionMateriasCurso(Long cursoId, List<MateriaEvaluacionDTO> materias) {
        Curso curso = cursoRepository.findById(cursoId)
                .orElseThrow(() -> new RuntimeException("Curso no encontrado con ID: " + cursoId));

        List<MateriaEvaluacionDTO> resultado = new ArrayList<>();
        for (MateriaEvaluacionDTO dto : materias) {
            if (dto.getMateriaId() != null) {
                Materia m = materiaRepository.findById(dto.getMateriaId()).orElse(null);
                if (m != null) {
                    MateriaCursoConfig cfg = materiaCursoConfigRepository.findByCursoIdAndMateriaId(cursoId, m.getId())
                            .orElseGet(() -> new MateriaCursoConfig(curso, m, "FACIL", true));

                    String dif = MateriaEvaluacionDTO.normalizarDificultad(dto.getDificultad());
                    cfg.setTipoComplejidad(dif);
                    cfg.setActivo(dto.isTomaExamen());

                    MateriaCursoConfig guardado = materiaCursoConfigRepository.save(cfg);
                    dto.setId(guardado.getId());
                    dto.setDificultad(dif);
                    dto.setTipoComplejidad(dif);
                    resultado.add(dto);
                }
            }
        }
        return resultado;
    }

    public static boolean sugerirTomaExamenPorMateria(Materia m) {
        if (m == null) return false;
        if (!m.isAplicaExamen()) return false;
        String n = m.getNombre() != null ? m.getNombre().toUpperCase().trim() : "";
        if (n.contains("TUTORÍA") || n.contains("TUTORIA")) return false;
        if (n.contains("BIBLIOTECA")) return false;
        if (n.contains("MISA") || n.contains("PASTORAL")) return false;
        if (n.contains("PPFF") || n.contains("OVP") || n.contains("CONVIVENCIA")) return false;
        if (n.contains("DECE") || n.contains("PROYECTO ESCOLAR")) return false;
        if (n.contains("INSPECCIÓN") || n.contains("INSPECCION")) return false;
        return true;
    }

    public static String sugerirComplejidadPorNombre(String nombreMateria) {
        if (nombreMateria == null) return "DIFICIL";
        String n = nombreMateria.toUpperCase().trim();

        // Materias FÁCILES / Menos complejas
        if (n.contains("FÍSICA") && n.contains("EDUCACIÓN")) return "FACIL";
        if (n.contains("EDUCACION FISICA") || n.contains("EDUCACIÓN FÍSICA") || n.contains("ED. FISICA") || n.contains("ED. FÍSICA") || n.contains("ED FISICA") || n.contains("ED FÍSICA")) return "FACIL";
        if (n.contains("CULTURAL") || n.contains("ARTÍSTICA") || n.contains("ARTISTICA") || n.contains("ECA") || n.contains("ARTE") || n.contains("DIBUJO")) return "FACIL";
        if (n.contains("INFORMÁTICA") || n.contains("INFORMATICA") || n.contains("COMPUTACIÓN") || n.contains("COMPUTACION") || n.contains("TIC") || n.contains("HERRAMIENTAS COMP")) return "FACIL";
        if (n.contains("EMPRENDIMIENTO") || n.contains("GESTIÓN") || n.contains("GESTION")) return "FACIL";
        if (n.contains("CIUDADANÍA") || n.contains("CIUDADANIA") || n.contains("CÍVICA") || n.contains("CIVICA")) return "FACIL";
        if (n.contains("RELIGIÓN") || n.contains("RELIGION") || n.contains("VALORES") || n.contains("PASTORAL")) return "FACIL";
        if (n.contains("TUTORÍA") || n.contains("TUTORIA") || n.contains("PROYECTO") || n.contains("LECTURA") || n.contains("ROBÓTICA") || n.contains("ROBOTICA")) return "FACIL";
        if (n.contains("DESARROLLO DEL PENSAMIENTO") || n.contains("DESARROLLO HUMANO")) return "FACIL";
        if (n.contains("INGLÉS") || n.contains("INGLES") || n.contains("ENGLISH")) return "FACIL";

        // Materias DIFÍCILES: Matemática, Física, Química, Biología, Historia, Filosofía, Lengua y Literatura, Números Complejos, etc.
        return "DIFICIL";
    }

    public HorarioExamenDTO generarSorteoAleatorio(GenerarSorteoExamenRequest req) {
        if (req.getCursoId() == null) {
            return generarSorteoGeneralInstitucional(req);
        }

        Curso cursoSel = cursoRepository.findById(req.getCursoId()).orElse(null);
        boolean isBgu = esBachillerato(cursoSel);

        if (req.getFechaInicio() == null) {
            req.setFechaInicio(LocalDate.now().plusDays(1));
        }

        int defaultDias = isBgu ? 7 : 5;
        int numDias = req.getNumDias() != null && req.getNumDias() > 0 ? req.getNumDias() : defaultDias;
        int materiasPorDia = req.getMateriasPorDia() != null && req.getMateriasPorDia() > 0 ? req.getMateriasPorDia() : 2;

        List<MateriaEvaluacionDTO> seleccionadas = req.getMaterias() != null
                ? req.getMaterias().stream().filter(m -> m.isTomaExamen() && m.isSeleccionada()).collect(Collectors.toList())
                : obtenerMateriasPorCurso(req.getCursoId()).stream().filter(MateriaEvaluacionDTO::isTomaExamen).collect(Collectors.toList());

        if (seleccionadas.isEmpty()) {
            throw new IllegalArgumentException("No hay materias evaluables disponibles (con 'Toma Examen' activo) para sortear el horario de exámenes.");
        }

        // Separar materias en Difíciles (Complejas) y Fáciles (Menos Complejas)
        List<MateriaEvaluacionDTO> complejas = new ArrayList<>();
        List<MateriaEvaluacionDTO> noComplejas = new ArrayList<>();

        for (MateriaEvaluacionDTO m : seleccionadas) {
            if ("FACIL".equalsIgnoreCase(m.getDificultad()) || "NO_COMPLEJA".equalsIgnoreCase(m.getTipoComplejidad())) {
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

        String nombreCurso = (cursoSel != null) ? cursoSel.getNombre() : "General";

        HorarioExamenDTO horarioDTO = new HorarioExamenDTO();
        horarioDTO.setTitulo(req.getTitulo() != null && !req.getTitulo().trim().isEmpty() ? req.getTitulo().trim() : "Horario de Exámenes - " + nombreCurso);
        horarioDTO.setCursoId(req.getCursoId());
        horarioDTO.setCursoNombre(nombreCurso);
        horarioDTO.setFechaInicio(req.getFechaInicio());
        horarioDTO.setFechaFin(fechaFin);
        horarioDTO.setNumDias(numDias);
        horarioDTO.setMateriasPorDia(materiasPorDia);

        boolean isCol = esColegio(cursoSel);
        String hora1Ini = req.getHoraInicio1() != null ? req.getHoraInicio1() : "07h30";
        String hora1Fin = req.getHoraFin1() != null ? req.getHoraFin1() : "08h30";
        String hora2Ini = req.getHoraInicio2() != null ? req.getHoraInicio2() : (isCol ? "09h30" : "08h30");
        String hora2Fin = req.getHoraFin2() != null ? req.getHoraFin2() : (isCol ? "10h30" : "09h30");

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
                        req.getCursoId(),
                        nombreCurso,
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
                            req.getCursoId(),
                            nombreCurso,
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
                    req.getCursoId(),
                    nombreCurso,
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

    public HorarioExamenDTO generarSorteoGeneralInstitucional(GenerarSorteoExamenRequest req) {
        if (req.getFechaInicio() == null) {
            req.setFechaInicio(LocalDate.now().plusDays(1));
        }
        int numDias = 7; // Ciclo total institucional: 7 días
        int materiasPorDia = req.getMateriasPorDia() != null && req.getMateriasPorDia() > 0 ? req.getMateriasPorDia() : 2;

        String hora1Ini = req.getHoraInicio1() != null ? req.getHoraInicio1() : "07h30";
        String hora1Fin = req.getHoraFin1() != null ? req.getHoraFin1() : "08h30";
        String hora2Ini = req.getHoraInicio2() != null ? req.getHoraInicio2() : "09h30";
        String hora2Fin = req.getHoraFin2() != null ? req.getHoraFin2() : "10h30";

        // Generar lista de 7 fechas hábiles (saltando sábados y domingos si corresponde)
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

        List<Curso> todosCursos = cursoRepository.findAll().stream()
                .sorted(Comparator.comparing(Curso::getId))
                .collect(Collectors.toList());

        List<HorarioExamenDetalleDTO> todosDetalles = new ArrayList<>();
        SecureRandom random = new SecureRandom();

        // Control de asignaciones de profesores por slot horario: Clave = "diaNumero_ordenDia"
        Map<String, Set<String>> ocupacionDocentes = new HashMap<>();
        for (int d = 1; d <= numDias; d++) {
            for (int b = 1; b <= 3; b++) {
                ocupacionDocentes.put(d + "_" + b, new HashSet<>());
            }
        }

        // Primero procesar Bachillerato (requiere los 7 días), luego Básica (días 3 al 7)
        List<Curso> bachillerato = todosCursos.stream().filter(this::esBachillerato).collect(Collectors.toList());
        List<Curso> basica = todosCursos.stream().filter(c -> !esBachillerato(c)).collect(Collectors.toList());

        List<Curso> ordenProcesamiento = new ArrayList<>();
        ordenProcesamiento.addAll(bachillerato);
        ordenProcesamiento.addAll(basica);

        for (Curso curso : ordenProcesamiento) {
            boolean isBgu = esBachillerato(curso);
            List<Integer> diasDisponibles = new ArrayList<>();
            if (isBgu) {
                // Bachillerato rinde los 7 días
                for (int d = 1; d <= 7; d++) diasDisponibles.add(d);
            } else {
                // Inicial y Básica rinden los 5 días centrales (días 3 al 7)
                for (int d = 3; d <= 7; d++) diasDisponibles.add(d);
            }

            // Obtener materias evaluables para este curso (excluye tomaExamen = false)
            List<MateriaEvaluacionDTO> materiasCurso = obtenerMateriasPorCurso(curso.getId()).stream()
                    .filter(MateriaEvaluacionDTO::isTomaExamen)
                    .collect(Collectors.toList());
            if (materiasCurso.isEmpty()) {
                continue;
            }

            // Separar difíciles (complejas) y fáciles (no complejas)
            List<MateriaEvaluacionDTO> complejas = new ArrayList<>();
            List<MateriaEvaluacionDTO> noComplejas = new ArrayList<>();
            for (MateriaEvaluacionDTO m : materiasCurso) {
                if ("FACIL".equalsIgnoreCase(m.getDificultad()) || "NO_COMPLEJA".equalsIgnoreCase(m.getTipoComplejidad())) {
                    noComplejas.add(m);
                } else {
                    complejas.add(m);
                }
            }

            Collections.shuffle(complejas, random);
            Collections.shuffle(noComplejas, random);

            // Matriz local para este curso: (dia_ordenDia) -> detalle
            Map<String, HorarioExamenDetalleDTO> asignacionCurso = new HashMap<>();

            // Asignar materias complejas principalmente en Bloque 1
            for (MateriaEvaluacionDTO m : complejas) {
                String docNom = m.getDocenteNombre() != null ? m.getDocenteNombre().trim() : "";
                asignarMateriaASlot(m, docNom, curso, diasDisponibles, 1, 2, asignacionCurso, ocupacionDocentes, fechas, hora1Ini, hora1Fin, hora2Ini, hora2Fin, random);
            }

            // Asignar materias no complejas principalmente en Bloque 2
            for (MateriaEvaluacionDTO m : noComplejas) {
                String docNom = m.getDocenteNombre() != null ? m.getDocenteNombre().trim() : "";
                asignarMateriaASlot(m, docNom, curso, diasDisponibles, 2, 1, asignacionCurso, ocupacionDocentes, fechas, hora1Ini, hora1Fin, hora2Ini, hora2Fin, random);
            }

            todosDetalles.addAll(asignacionCurso.values());
        }

        // Ordenar todos los detalles por cursoId, diaNumero, ordenDia
        todosDetalles.sort(Comparator.comparing((HorarioExamenDetalleDTO d) -> d.getCursoId() != null ? d.getCursoId() : 0L)
                .thenComparing(HorarioExamenDetalleDTO::getDiaNumero)
                .thenComparing(HorarioExamenDetalleDTO::getOrdenDia));

        HorarioExamenDTO horarioDTO = new HorarioExamenDTO();
        horarioDTO.setTitulo(req.getTitulo() != null && !req.getTitulo().trim().isEmpty()
                ? req.getTitulo().trim()
                : "Horario General de Exámenes Institucional (7 Días BGU / 5 Días Básica)");
        horarioDTO.setCursoId(null);
        horarioDTO.setCursoNombre("Todos los Cursos - Institucional");
        horarioDTO.setFechaInicio(req.getFechaInicio());
        horarioDTO.setFechaFin(fechaFin);
        horarioDTO.setNumDias(numDias);
        horarioDTO.setMateriasPorDia(materiasPorDia);
        horarioDTO.setObservaciones("Sorteo general institucional balanceado: Bachillerato rinde 7 días (empieza días 1 y 2); Inicial y Básica rinden 5 días (días 3 al 7). Sin choques docentes.");
        horarioDTO.setDetalles(todosDetalles);

        return horarioDTO;
    }

    private void asignarMateriaASlot(
            MateriaEvaluacionDTO m,
            String docNom,
            Curso curso,
            List<Integer> diasDisponibles,
            int bloquePreferido,
            int bloqueSecundario,
            Map<String, HorarioExamenDetalleDTO> asignacionCurso,
            Map<String, Set<String>> ocupacionDocentes,
            List<LocalDate> fechas,
            String hora1Ini, String hora1Fin,
            String hora2Ini, String hora2Fin,
            SecureRandom random) {

        List<Integer> diasShuffled = new ArrayList<>(diasDisponibles);
        Collections.shuffle(diasShuffled, random);

        // 1. Intentar en bloque preferido en los días disponibles sin choque docente
        for (int d : diasShuffled) {
            String slotKey = d + "_" + bloquePreferido;
            if (!asignacionCurso.containsKey(slotKey)) {
                Set<String> ocupados = ocupacionDocentes.getOrDefault(slotKey, Collections.emptySet());
                if (docNom.isEmpty() || !ocupados.contains(docNom)) {
                    crearYRegistrarDetalle(m, docNom, curso, d, bloquePreferido, slotKey, asignacionCurso, ocupacionDocentes, fechas, hora1Ini, hora1Fin, hora2Ini, hora2Fin);
                    return;
                }
            }
        }

        // 2. Intentar en bloque secundario sin choque docente
        for (int d : diasShuffled) {
            String slotKey = d + "_" + bloqueSecundario;
            if (!asignacionCurso.containsKey(slotKey)) {
                Set<String> ocupados = ocupacionDocentes.getOrDefault(slotKey, Collections.emptySet());
                if (docNom.isEmpty() || !ocupados.contains(docNom)) {
                    crearYRegistrarDetalle(m, docNom, curso, d, bloqueSecundario, slotKey, asignacionCurso, ocupacionDocentes, fechas, hora1Ini, hora1Fin, hora2Ini, hora2Fin);
                    return;
                }
            }
        }

        // 3. Buscar en cualquier bloque (1, 2 o 3) en cualquier día disponible sin choque docente
        for (int b : List.of(bloquePreferido, bloqueSecundario, 3)) {
            for (int d : diasShuffled) {
                String slotKey = d + "_" + b;
                if (!asignacionCurso.containsKey(slotKey)) {
                    Set<String> ocupados = ocupacionDocentes.getOrDefault(slotKey, Collections.emptySet());
                    if (docNom.isEmpty() || !ocupados.contains(docNom)) {
                        crearYRegistrarDetalle(m, docNom, curso, d, b, slotKey, asignacionCurso, ocupacionDocentes, fechas, hora1Ini, hora1Fin, hora2Ini, hora2Fin);
                        return;
                    }
                }
            }
        }

        // 4. Intentar reubicar / swap con una materia ya asignada en este curso para liberar un slot sin conflicto docente
        if (!docNom.isEmpty()) {
            for (Map.Entry<String, HorarioExamenDetalleDTO> entry : new ArrayList<>(asignacionCurso.entrySet())) {
                String existingSlotKey = entry.getKey();
                HorarioExamenDetalleDTO existingDetalle = entry.getValue();
                String existingDoc = existingDetalle.getDocenteSupervisor() != null ? existingDetalle.getDocenteSupervisor().trim() : "";

                Set<String> ocupadosExistingSlot = ocupacionDocentes.getOrDefault(existingSlotKey, Collections.emptySet());
                if (!ocupadosExistingSlot.contains(docNom)) {
                    for (int bCandidate : List.of(1, 2, 3)) {
                        for (int dCandidate : diasShuffled) {
                            String newSlotKey = dCandidate + "_" + bCandidate;
                            if (!asignacionCurso.containsKey(newSlotKey)) {
                                Set<String> ocupadosNew = ocupacionDocentes.getOrDefault(newSlotKey, Collections.emptySet());
                                if (existingDoc.isEmpty() || !ocupadosNew.contains(existingDoc)) {
                                    asignacionCurso.remove(existingSlotKey);
                                    if (!existingDoc.isEmpty()) {
                                        Set<String> s = ocupacionDocentes.get(existingSlotKey);
                                        if (s != null) s.remove(existingDoc);
                                    }
                                    crearYRegistrarDetalle(
                                            new MateriaEvaluacionDTO(existingDetalle.getId(), existingDetalle.getMateriaId(), existingDetalle.getMateriaNombre(), existingDetalle.getTipoComplejidad(), true, existingDoc),
                                            existingDoc, curso, dCandidate, bCandidate, newSlotKey, asignacionCurso, ocupacionDocentes, fechas, hora1Ini, hora1Fin, hora2Ini, hora2Fin
                                    );
                                    int dOld = Integer.parseInt(existingSlotKey.split("_")[0]);
                                    int bOld = Integer.parseInt(existingSlotKey.split("_")[1]);
                                    crearYRegistrarDetalle(m, docNom, curso, dOld, bOld, existingSlotKey, asignacionCurso, ocupacionDocentes, fechas, hora1Ini, hora1Fin, hora2Ini, hora2Fin);
                                    return;
                                }
                            }
                        }
                    }
                }
            }
        }

        // 5. Asignar en el primer slot libre disponible (1, 2 o 3)
        for (int b : List.of(bloquePreferido, bloqueSecundario, 3)) {
            for (int d : diasDisponibles) {
                String slotKey = d + "_" + b;
                if (!asignacionCurso.containsKey(slotKey)) {
                    crearYRegistrarDetalle(m, docNom, curso, d, b, slotKey, asignacionCurso, ocupacionDocentes, fechas, hora1Ini, hora1Fin, hora2Ini, hora2Fin);
                    return;
                }
            }
        }
    }

    private void crearYRegistrarDetalle(
            MateriaEvaluacionDTO m,
            String docNom,
            Curso curso,
            int dia,
            int bloque,
            String slotKey,
            Map<String, HorarioExamenDetalleDTO> asignacionCurso,
            Map<String, Set<String>> ocupacionDocentes,
            List<LocalDate> fechas,
            String hora1Ini, String hora1Fin,
            String hora2Ini, String hora2Fin) {

        LocalDate f = fechas.get(dia - 1);
        String diaSem = DisponibilidadService.obtenerDiaSemanaEnEspanol(f);
        boolean isCol = esColegio(curso);

        String hIni;
        String hFin;
        if (isCol) {
            // Colegio: 1° examen 07h30-08h30, 2° examen 09h30-10h30 (o 08h30-09h30 si es fácil)
            hIni = (bloque == 1) ? "07h30" : ((bloque == 2) ? "09h30" : "08h30");
            hFin = (bloque == 1) ? "08h30" : ((bloque == 2) ? "10h30" : "09h30");
        } else {
            // Toda la escuela da su primer examen a las 7h30, el segundo a las 8h30
            hIni = (bloque == 1) ? "07h30" : ((bloque == 2) ? "08h30" : "09h30");
            hFin = (bloque == 1) ? "08h30" : ((bloque == 2) ? "09h30" : "10h30");
        }

        HorarioExamenDetalleDTO det = new HorarioExamenDetalleDTO(
                null,
                curso.getId(),
                curso.getNombre(),
                dia,
                f,
                diaSem,
                bloque,
                m.getMateriaId(),
                m.getMateriaNombre(),
                m.getTipoComplejidad(),
                hIni,
                hFin,
                docNom
        );

        asignacionCurso.put(slotKey, det);
        if (docNom != null && !docNom.isEmpty()) {
            ocupacionDocentes.computeIfAbsent(slotKey, k -> new HashSet<>()).add(docNom);
            String timeKey = dia + "_" + hIni;
            ocupacionDocentes.computeIfAbsent(timeKey, k -> new HashSet<>()).add(docNom);
        }
    }

    public static boolean esColegio(Curso c) {
        if (c == null || c.getNombre() == null) return false;
        String nom = c.getNombre().toUpperCase().trim();
        return nom.startsWith("8") || nom.contains("OCTAVO") ||
               nom.startsWith("9") || nom.contains("NOVENO") ||
               nom.startsWith("10") || nom.contains("DECIMO") || nom.contains("DÉCIMO") ||
               nom.contains("BGU") || nom.contains("BACHILLERATO") || nom.contains("BACH");
    }

    private boolean esBachillerato(Curso c) {
        if (c == null || c.getNombre() == null) return false;
        String nom = c.getNombre().toUpperCase();
        return nom.contains("BGU") || nom.contains("BACHILLERATO");
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
            Curso detCurso = dDTO.getCursoId() != null ? cursoRepository.findById(dDTO.getCursoId()).orElse(null) : curso;
            String detCursoNom = dDTO.getCursoNombre() != null ? dDTO.getCursoNombre() : (detCurso != null ? detCurso.getNombre() : null);

            HorarioExamenDetalle det = new HorarioExamenDetalle(
                    he,
                    detCurso,
                    detCursoNom,
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
                d.getCurso() != null ? d.getCurso().getId() : (he.getCurso() != null ? he.getCurso().getId() : null),
                d.getCursoNombre() != null ? d.getCursoNombre() : (d.getCurso() != null ? d.getCurso().getNombre() : (he.getCurso() != null ? he.getCurso().getNombre() : null)),
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

