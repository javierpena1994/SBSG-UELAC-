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
        int totalMaterias = seleccionadas.size();
        int minDiasReq = !isCol ? (int) Math.ceil((double) totalMaterias / 2.0) : (int) Math.ceil((double) totalMaterias / 3.0);
        if (numDias < minDiasReq) {
            numDias = minDiasReq;
            fechas.clear();
            LocalDate cur = req.getFechaInicio();
            while (fechas.size() < numDias) {
                if (req.isSaltarFinesDeSemana()) {
                    if (cur.getDayOfWeek() != DayOfWeek.SATURDAY && cur.getDayOfWeek() != DayOfWeek.SUNDAY) {
                        fechas.add(cur);
                    }
                } else {
                    fechas.add(cur);
                }
                cur = cur.plusDays(1);
            }
            fechaFin = fechas.isEmpty() ? req.getFechaInicio() : fechas.get(fechas.size() - 1);
            horarioDTO.setNumDias(numDias);
            horarioDTO.setFechaFin(fechaFin);
        }

        String hora1Ini = req.getHoraInicio1() != null ? req.getHoraInicio1() : "07h30";
        String hora1Fin = req.getHoraFin1() != null ? req.getHoraFin1() : "08h30";
        String hora2Ini = req.getHoraInicio2() != null ? req.getHoraInicio2() : (isCol ? "09h30" : "08h30");
        String hora2Fin = req.getHoraFin2() != null ? req.getHoraFin2() : (isCol ? "10h30" : "09h30");

        // Distribuir slots por día para cubrir exactamente el 100% de materias
        int[] spd = new int[numDias];
        Arrays.fill(spd, 2);
        if (totalMaterias > 2 * numDias) {
            int extra = totalMaterias - 2 * numDias;
            for (int i = 0; i < extra && i < numDias; i++) {
                spd[i]++;
            }
        } else if (totalMaterias < 2 * numDias) {
            int rem = 2 * numDias - totalMaterias;
            for (int i = 0; i < rem && i < numDias; i++) {
                spd[numDias - 1 - i]--;
            }
        }

        Deque<MateriaEvaluacionDTO> qDifs = new ArrayDeque<>(complejas);
        Deque<MateriaEvaluacionDTO> qFacs = new ArrayDeque<>(noComplejas);

        List<List<MateriaEvaluacionDTO>> bundles = new ArrayList<>();
        for (int s : spd) {
            List<MateriaEvaluacionDTO> b = new ArrayList<>();
            if (s == 2) {
                if (!qDifs.isEmpty() && !qFacs.isEmpty()) {
                    b.add(qDifs.pollFirst()); // Bloque 1: Difícil
                    b.add(qFacs.pollFirst()); // Bloque 2: Fácil
                } else if (qDifs.size() >= 2) {
                    b.add(qDifs.pollFirst()); // Bloque 1: Difícil
                    b.add(qDifs.pollFirst()); // Bloque 2: Difícil (Día de 2 difíciles)
                } else if (qFacs.size() >= 2) {
                    b.add(qFacs.pollFirst()); // Bloque 1: Fácil
                    b.add(qFacs.pollFirst()); // Bloque 2: Fácil (Día de 2 fáciles)
                } else {
                    if (!qDifs.isEmpty()) b.add(qDifs.pollFirst());
                    if (!qFacs.isEmpty()) b.add(qFacs.pollFirst());
                }
            } else if (s == 1) {
                if (!qDifs.isEmpty()) b.add(qDifs.pollFirst());
                else if (!qFacs.isEmpty()) b.add(qFacs.pollFirst());
            } else if (s == 3) {
                if (!qDifs.isEmpty() && !qFacs.isEmpty()) {
                    b.add(qDifs.pollFirst());
                    b.add(qFacs.pollFirst());
                } else if (qDifs.size() >= 2) {
                    b.add(qDifs.pollFirst());
                    b.add(qDifs.pollFirst());
                } else {
                    if (!qDifs.isEmpty()) b.add(qDifs.pollFirst());
                    if (!qFacs.isEmpty()) b.add(qFacs.pollFirst());
                }
                if (!qFacs.isEmpty()) b.add(qFacs.pollFirst());
                else if (!qDifs.isEmpty()) b.add(qDifs.pollFirst());
            }
            bundles.add(b);
        }

        int count2Single = 0;
        for (List<MateriaEvaluacionDTO> b : bundles) {
            if (b.size() == 2) count2Single++;
        }
        List<int[]> patterns2Single = new ArrayList<>();
        for (int p = 0; p < count2Single; p++) {
            if (p % 2 == 0) {
                patterns2Single.add(new int[]{1, 2}); // Consecutivo (07h30 y 08h30)
            } else {
                patterns2Single.add(new int[]{1, 3}); // Con espacio (07h30 y 09h30)
            }
        }
        Collections.shuffle(patterns2Single, random);
        int patIdxSingle = 0;

        List<HorarioExamenDetalleDTO> detalles = new ArrayList<>();
        for (int d = 0; d < numDias; d++) {
            int diaNumero = d + 1;
            LocalDate fechaDia = (d < fechas.size()) ? fechas.get(d) : fechaFin;
            String diaSemana = DisponibilidadService.obtenerDiaSemanaEnEspanol(fechaDia);
            List<MateriaEvaluacionDTO> b = bundles.get(d);

            int[] pat;
            if (!isCol) {
                pat = (b.size() == 2) ? new int[]{1, 2} : new int[]{1};
            } else {
                if (b.size() == 3) {
                    pat = new int[]{1, 2, 3};
                } else if (b.size() == 1) {
                    pat = new int[]{1};
                } else {
                    pat = patterns2Single.get(patIdxSingle++);
                }
            }

            for (int bIdx = 0; bIdx < b.size(); bIdx++) {
                int orden = pat[bIdx];
                MateriaEvaluacionDTO m = b.get(bIdx);
                String hIni = getHoraInicioPorOrden(orden);
                String hFin = getHoraFinPorOrden(orden);

                detalles.add(new HorarioExamenDetalleDTO(
                        null,
                        req.getCursoId(),
                        nombreCurso,
                        diaNumero,
                        fechaDia,
                        diaSemana,
                        orden,
                        m.getMateriaId(),
                        m.getMateriaNombre(),
                        m.getTipoComplejidad(),
                        hIni,
                        hFin,
                        m.getDocenteNombre()
                ));
            }
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

        // Generar lista de 7 fechas hábiles (saltando fines de semana si corresponde)
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

        // Orden de procesamiento pedagógico: Bachillerato primero (7 días), luego Básica Superior (Colegio), luego Escuela
        List<Curso> bachillerato = todosCursos.stream().filter(this::esBachillerato).collect(Collectors.toList());
        List<Curso> superior = todosCursos.stream().filter(c -> !esBachillerato(c) && esColegio(c)).collect(Collectors.toList());
        List<Curso> escuela = todosCursos.stream().filter(c -> !esColegio(c)).collect(Collectors.toList());

        List<Curso> ordenProcesamientoBase = new ArrayList<>();
        ordenProcesamientoBase.addAll(bachillerato);
        ordenProcesamientoBase.addAll(superior);
        ordenProcesamientoBase.addAll(escuela);

        List<HorarioExamenDetalleDTO> bestGlobalDetalles = new ArrayList<>();
        int bestGlobalConflicts = Integer.MAX_VALUE;

        // Bucle de optimización global para garantizar 0 colisiones docentes entre todos los cursos
        for (int globalAttempt = 0; globalAttempt < 60; globalAttempt++) {
            List<HorarioExamenDetalleDTO> currentAttemptDetalles = new ArrayList<>();

            // Control de asignaciones de profesores por slot horario: Clave = "diaNumero_ordenDia" y "diaNumero_hIni"
            Map<String, Set<String>> ocupacionDocentes = new HashMap<>();
            for (int d = 1; d <= numDias; d++) {
                for (int b = 1; b <= 3; b++) {
                    ocupacionDocentes.put(d + "_" + b, new HashSet<>());
                }
            }

            List<Curso> ordenProcesamiento = new ArrayList<>(ordenProcesamientoBase);
            if (globalAttempt > 0) {
                Collections.shuffle(ordenProcesamiento, random);
            }

            for (Curso curso : ordenProcesamiento) {
                boolean isCol = esColegio(curso);

            // Obtener materias evaluables para este curso (tomaExamen = true)
            List<MateriaEvaluacionDTO> materiasCurso = obtenerMateriasPorCurso(curso.getId()).stream()
                    .filter(MateriaEvaluacionDTO::isTomaExamen)
                    .collect(Collectors.toList());
            if (materiasCurso.isEmpty()) {
                continue;
            }

            int n = materiasCurso.size();

            // Determinar días disponibles según nivel y cantidad de materias
            List<Integer> diasDisponibles = new ArrayList<>();
            if (isCol) {
                if (n > 14) {
                    for (int d = 1; d <= 7; d++) diasDisponibles.add(d);
                } else if (n > 10) {
                    for (int d = 2; d <= 7; d++) diasDisponibles.add(d);
                } else {
                    for (int d = 3; d <= 7; d++) diasDisponibles.add(d);
                }
            } else {
                // Escuela: NUNCA bloque 3.
                // Si n <= 10 -> 5 días (3 al 7).
                // Si n in [11, 12] -> 6 días (2 al 7).
                // Si n > 12 -> 7 días (1 al 7).
                if (n > 12) {
                    for (int d = 1; d <= 7; d++) diasDisponibles.add(d);
                } else if (n > 10) {
                    for (int d = 2; d <= 7; d++) diasDisponibles.add(d);
                } else {
                    for (int d = 3; d <= 7; d++) diasDisponibles.add(d);
                }
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

            // Determinar slots por día para cubrir exactamente las n materias
            int numDays = diasDisponibles.size();
            int[] spdCurso = new int[numDays];
            Arrays.fill(spdCurso, 2);

            if (n > 2 * numDays) {
                int extra = n - 2 * numDays;
                for (int i = 0; i < extra && i < numDays; i++) {
                    spdCurso[i]++;
                }
            } else if (n < 2 * numDays) {
                int rem = 2 * numDays - n;
                for (int i = 0; i < rem && i < numDays; i++) {
                    spdCurso[numDays - 1 - i]--;
                }
            }

            // Construir paquetes diarios (bundles) aplicando el balance pedagógico solicitado:
            // 1. Primer criterio: Mezclar 1 fácil + 1 difícil por día.
            // 2. Si sobran difíciles: días con 2 difíciles (ej. 6 difíciles y 4 fáciles -> 4 días 1D+1F y 1 día 2D).
            // 3. Si sobran fáciles: días con 2 fáciles.
            // 4. Si el total es impar: el día con 1 solo examen lleva la materia restante en Bloque 1.
            Deque<MateriaEvaluacionDTO> qDifsCurso = new ArrayDeque<>(complejas);
            Deque<MateriaEvaluacionDTO> qFacsCurso = new ArrayDeque<>(noComplejas);

            List<List<MateriaEvaluacionDTO>> bundles = new ArrayList<>();
            for (int s : spdCurso) {
                List<MateriaEvaluacionDTO> b = new ArrayList<>();
                if (s == 2) {
                    if (!qDifsCurso.isEmpty() && !qFacsCurso.isEmpty()) {
                        b.add(qDifsCurso.pollFirst()); // Slot 1: Difícil
                        b.add(qFacsCurso.pollFirst()); // Slot 2: Fácil
                    } else if (qDifsCurso.size() >= 2) {
                        b.add(qDifsCurso.pollFirst()); // Slot 1: Difícil
                        b.add(qDifsCurso.pollFirst()); // Slot 2: Difícil (Día con 2 difíciles)
                    } else if (qFacsCurso.size() >= 2) {
                        b.add(qFacsCurso.pollFirst()); // Slot 1: Fácil
                        b.add(qFacsCurso.pollFirst()); // Slot 2: Fácil (Día con 2 fáciles)
                    } else {
                        if (!qDifsCurso.isEmpty()) b.add(qDifsCurso.pollFirst());
                        if (!qFacsCurso.isEmpty()) b.add(qFacsCurso.pollFirst());
                    }
                } else if (s == 1) {
                    if (!qDifsCurso.isEmpty()) b.add(qDifsCurso.pollFirst());
                    else if (!qFacsCurso.isEmpty()) b.add(qFacsCurso.pollFirst());
                } else if (s == 3) {
                    if (!qDifsCurso.isEmpty() && !qFacsCurso.isEmpty()) {
                        b.add(qDifsCurso.pollFirst());
                        b.add(qFacsCurso.pollFirst());
                    } else if (qDifsCurso.size() >= 2) {
                        b.add(qDifsCurso.pollFirst());
                        b.add(qDifsCurso.pollFirst());
                    } else {
                        if (!qDifsCurso.isEmpty()) b.add(qDifsCurso.pollFirst());
                        if (!qFacsCurso.isEmpty()) b.add(qFacsCurso.pollFirst());
                    }
                    if (!qFacsCurso.isEmpty()) b.add(qFacsCurso.pollFirst());
                    else if (!qDifsCurso.isEmpty()) b.add(qDifsCurso.pollFirst());
                }
                bundles.add(b);
            }

            // Preparar patrones para días con 2 exámenes en Colegio
            int count2 = 0;
            for (List<MateriaEvaluacionDTO> b : bundles) {
                if (b.size() == 2) count2++;
            }

            List<int[]> patterns2 = new ArrayList<>();
            for (int p = 0; p < count2; p++) {
                if ((p + (curso.getId() != null ? curso.getId().intValue() : 0)) % 2 == 0) {
                    patterns2.add(new int[]{1, 2}); // Consecutivo (07h30 y 08h30)
                } else {
                    patterns2.add(new int[]{1, 3}); // Con espacio (07h30 y 09h30)
                }
            }

            // Optimización de asignación a días y orientación para prevenir choques docentes
            List<Integer> bestPermDias = null;
            List<List<MateriaEvaluacionDTO>> bestOrientations = null;
            List<int[]> bestPatterns = null;
            int bestConf = Integer.MAX_VALUE;

            for (int attempt = 0; attempt < 250; attempt++) {
                List<Integer> permDias = new ArrayList<>(diasDisponibles);
                Collections.shuffle(permDias, random);

                List<int[]> curPatterns2 = new ArrayList<>(patterns2);
                Collections.shuffle(curPatterns2, random);
                int patIdx = 0;

                int curConf = 0;
                List<List<MateriaEvaluacionDTO>> orientations = new ArrayList<>();
                List<int[]> dayPatternsUsed = new ArrayList<>();

                for (int i = 0; i < permDias.size(); i++) {
                    int d = permDias.get(i);
                    List<MateriaEvaluacionDTO> b = bundles.get(i);

                    int[] pat;
                    if (!isCol) {
                        pat = (b.size() == 2) ? new int[]{1, 2} : new int[]{1};
                    } else {
                        if (b.size() == 3) {
                            pat = new int[]{1, 2, 3};
                        } else if (b.size() == 1) {
                            pat = new int[]{1};
                        } else {
                            pat = curPatterns2.get(patIdx++);
                        }
                    }
                    dayPatternsUsed.add(pat);

                    if (b.size() == 2) {
                        MateriaEvaluacionDTO m0 = b.get(0);
                        MateriaEvaluacionDTO m1 = b.get(1);
                        String doc0 = m0.getDocenteNombre() != null ? m0.getDocenteNombre().trim() : "";
                        String doc1 = m1.getDocenteNombre() != null ? m1.getDocenteNombre().trim() : "";

                        String hA = getHoraInicioPorOrden(pat[0]);
                        String hB = getHoraInicioPorOrden(pat[1]);

                        int cNorm = (!doc0.isEmpty() && ocupacionDocentes.getOrDefault(d + "_" + hA, Collections.emptySet()).contains(doc0) ? 1 : 0)
                                  + (!doc1.isEmpty() && ocupacionDocentes.getOrDefault(d + "_" + hB, Collections.emptySet()).contains(doc1) ? 1 : 0);

                        int cSwap = (!doc1.isEmpty() && ocupacionDocentes.getOrDefault(d + "_" + hA, Collections.emptySet()).contains(doc1) ? 1 : 0)
                                  + (!doc0.isEmpty() && ocupacionDocentes.getOrDefault(d + "_" + hB, Collections.emptySet()).contains(doc0) ? 1 : 0);

                        if (cNorm <= cSwap) {
                            curConf += cNorm;
                            orientations.add(List.of(m0, m1));
                        } else {
                            curConf += cSwap;
                            orientations.add(List.of(m1, m0));
                        }
                    } else {
                        for (int bIdx = 0; bIdx < b.size(); bIdx++) {
                            MateriaEvaluacionDTO m = b.get(bIdx);
                            String doc = m.getDocenteNombre() != null ? m.getDocenteNombre().trim() : "";
                            String h = getHoraInicioPorOrden(pat[bIdx]);
                            if (!doc.isEmpty() && ocupacionDocentes.getOrDefault(d + "_" + h, Collections.emptySet()).contains(doc)) {
                                curConf++;
                            }
                        }
                        orientations.add(b);
                    }
                }

                if (curConf < bestConf) {
                    bestConf = curConf;
                    bestPermDias = permDias;
                    bestOrientations = orientations;
                    bestPatterns = dayPatternsUsed;
                    if (bestConf == 0) break;
                }
            }

            // Registrar asignación definitiva de todas las materias del curso
            Map<String, HorarioExamenDetalleDTO> asignacionCurso = new HashMap<>();
            for (int i = 0; i < bestPermDias.size(); i++) {
                int d = bestPermDias.get(i);
                List<MateriaEvaluacionDTO> b = bestOrientations.get(i);
                int[] pat = bestPatterns.get(i);

                for (int bIdx = 0; bIdx < b.size(); bIdx++) {
                    int orden = pat[bIdx];
                    String hIni = getHoraInicioPorOrden(orden);
                    String hFin = getHoraFinPorOrden(orden);
                    MateriaEvaluacionDTO m = b.get(bIdx);
                    String docNom = m.getDocenteNombre() != null ? m.getDocenteNombre().trim() : "";

                    crearYRegistrarDetalle(
                            m, docNom, curso, d, orden, hIni, hFin,
                            asignacionCurso, ocupacionDocentes, fechas
                    );
                }
            }

            currentAttemptDetalles.addAll(asignacionCurso.values());
        }

        // Calcular colisiones reales exactas en este intento global
        Set<String> seenDocSlots = new HashSet<>();
        int actualCollisions = 0;
        for (HorarioExamenDetalleDTO det : currentAttemptDetalles) {
            String doc = det.getDocenteNombre() != null ? det.getDocenteNombre().trim() : "";
            if (!doc.isEmpty()) {
                String key = doc + "_" + det.getDiaNumero() + "_" + det.getHoraInicio();
                if (!seenDocSlots.add(key)) {
                    actualCollisions++;
                }
            }
        }

        if (actualCollisions < bestGlobalConflicts) {
            bestGlobalConflicts = actualCollisions;
            bestGlobalDetalles = currentAttemptDetalles;
            if (bestGlobalConflicts == 0) {
                break;
            }
        }
    }

    todosDetalles = bestGlobalDetalles;

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
        horarioDTO.setObservaciones("Sorteo general institucional balanceado: Cobertura 100% de materias activas con balance 1 Difícil + 1 Fácil (y días de 2 difíciles según excedente). Sin desbordes a bloques inexistentes.");
        horarioDTO.setDetalles(todosDetalles);

        return horarioDTO;
    }

    private void crearYRegistrarDetalle(
            MateriaEvaluacionDTO m,
            String docNom,
            Curso curso,
            int dia,
            int ordenDia,
            String hIni,
            String hFin,
            Map<String, HorarioExamenDetalleDTO> asignacionCurso,
            Map<String, Set<String>> ocupacionDocentes,
            List<LocalDate> fechas) {

        LocalDate f = fechas.get(dia - 1);
        String diaSem = DisponibilidadService.obtenerDiaSemanaEnEspanol(f);

        HorarioExamenDetalleDTO det = new HorarioExamenDetalleDTO(
                null,
                curso.getId(),
                curso.getNombre(),
                dia,
                f,
                diaSem,
                ordenDia,
                m.getMateriaId(),
                m.getMateriaNombre(),
                m.getTipoComplejidad(),
                hIni,
                hFin,
                docNom
        );

        String slotKey = dia + "_" + ordenDia;
        asignacionCurso.put(slotKey, det);
        if (docNom != null && !docNom.isEmpty()) {
            String timeKey = dia + "_" + hIni;
            ocupacionDocentes.computeIfAbsent(timeKey, k -> new HashSet<>()).add(docNom);
            ocupacionDocentes.computeIfAbsent(slotKey, k -> new HashSet<>()).add(docNom);
        }
    }

    public static String getHoraInicioPorOrden(int orden) {
        return switch (orden) {
            case 1 -> "07h30";
            case 2 -> "08h30";
            case 3 -> "09h30";
            default -> "07h30";
        };
    }

    public static String getHoraFinPorOrden(int orden) {
        return switch (orden) {
            case 1 -> "08h30";
            case 2 -> "09h30";
            case 3 -> "10h30";
            default -> "08h30";
        };
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

