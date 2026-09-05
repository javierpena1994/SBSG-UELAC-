package com.sbsg.contingencias.service;

import com.sbsg.contingencias.model.*;
import com.sbsg.contingencias.repository.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.Normalizer;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

@Service
public class ExcelDataLoaderService implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(ExcelDataLoaderService.class);

    private final DocenteRepository docenteRepository;
    private final CursoRepository cursoRepository;
    private final MateriaRepository materiaRepository;
    private final FranjaHorariaRepository franjaHorariaRepository;
    private final HorarioDisponibilidadRepository disponibilidadRepository;
    private final ContingenciaRepository contingenciaRepository;

    @Value("${app.excel.file-path:Contingencias 2026.xlsx}")
    private String excelFilePath;

    public ExcelDataLoaderService(
            DocenteRepository docenteRepository,
            CursoRepository cursoRepository,
            MateriaRepository materiaRepository,
            FranjaHorariaRepository franjaHorariaRepository,
            HorarioDisponibilidadRepository disponibilidadRepository,
            ContingenciaRepository contingenciaRepository) {
        this.docenteRepository = docenteRepository;
        this.cursoRepository = cursoRepository;
        this.materiaRepository = materiaRepository;
        this.franjaHorariaRepository = franjaHorariaRepository;
        this.disponibilidadRepository = disponibilidadRepository;
        this.contingenciaRepository = contingenciaRepository;
    }

    @Override
    public void run(String... args) {
        try {
            long countDocentes = docenteRepository.count();
            if (countDocentes == 0) {
                log.info("Base de datos vacía detectada. Iniciando importación inicial desde Excel...");
                String[] possiblePaths = {
                    excelFilePath,
                    "../" + excelFilePath,
                    "recursos/documentos_fuente/Contingencias 2026.xlsx",
                    "../recursos/documentos_fuente/Contingencias 2026.xlsx",
                    "Contingencias 2026.xlsx",
                    "../Contingencias 2026.xlsx"
                };

                File file = null;
                for (String p : possiblePaths) {
                    if (p == null) continue;
                    File f = new File(p);
                    if (f.exists() && f.isFile()) {
                        file = f;
                        log.info("Archivo Excel encontrado en: {}", f.getAbsolutePath());
                        break;
                    }
                }

                if (file != null && file.exists()) {
                    try (InputStream is = new FileInputStream(file)) {
                        Map<String, Object> res = importarExcel(is);
                        log.info("Importación inicial completada con éxito: {}", res);
                    }
                } else {
                    log.warn("Archivo Excel no encontrado en las rutas evaluadas. Se esperará importación manual.");
                }
            } else {
                log.info("Base de datos ya cuenta con {} docentes registrados.", countDocentes);
            }
        } catch (Exception e) {
            log.error("Error durante la verificación/carga inicial del Excel: {}", e.getMessage(), e);
        }
    }

    private static String normalizar(String text) {
        if (text == null) return "";
        String normalized = Normalizer.normalize(text, Normalizer.Form.NFD);
        return normalized.replaceAll("\\p{M}", "").toUpperCase().trim();
    }

    private static String getCellValueAsString(Cell cell) {
        if (cell == null) return "";
        return switch (cell.getCellType()) {
            case STRING -> cell.getStringCellValue().trim();
            case NUMERIC -> {
                if (DateUtil.isCellDateFormatted(cell)) {
                    yield cell.getLocalDateTimeCellValue().toLocalDate().toString();
                } else {
                    double val = cell.getNumericCellValue();
                    if (val == (long) val) {
                        yield String.valueOf((long) val);
                    } else {
                        yield String.valueOf(val);
                    }
                }
            }
            case BOOLEAN -> String.valueOf(cell.getBooleanCellValue());
            case FORMULA -> {
                try {
                    yield cell.getStringCellValue().trim();
                } catch (Exception ex) {
                    try {
                        yield String.valueOf(cell.getNumericCellValue());
                    } catch (Exception e) {
                        yield "";
                    }
                }
            }
            default -> "";
        };
    }

    private static LocalDate getCellValueAsDate(Cell cell) {
        if (cell == null) return null;
        if (cell.getCellType() == CellType.NUMERIC) {
            if (DateUtil.isCellDateFormatted(cell)) {
                return cell.getDateCellValue().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            } else {
                Date d = DateUtil.getJavaDate(cell.getNumericCellValue());
                return d.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            }
        } else if (cell.getCellType() == CellType.STRING) {
            String str = cell.getStringCellValue().trim();
            try {
                return LocalDate.parse(str);
            } catch (Exception ignored) {}
        }
        return null;
    }

    private Docente obtenerOCrearDocente(Map<String, Docente> cache, String nombreCompleto, String nombreCorto) {
        String key = normalizar(nombreCompleto);
        if (cache.containsKey(key)) return cache.get(key);
        Docente d = docenteRepository.findByNombreCompletoIgnoreCase(nombreCompleto)
                .orElseGet(() -> docenteRepository.save(new Docente(nombreCompleto, nombreCorto != null ? nombreCorto : nombreCompleto)));
        cache.put(key, d);
        if (nombreCorto != null) {
            cache.put(normalizar(nombreCorto), d);
        }
        return d;
    }

    private Curso obtenerOCrearCurso(Map<String, Curso> cache, String nombre) {
        String safeName = (nombre == null || nombre.trim().isEmpty()) ? "General" : nombre.trim();
        String key = normalizar(safeName);
        if (cache.containsKey(key)) return cache.get(key);
        Curso c = cursoRepository.findByNombreIgnoreCase(safeName)
                .orElseGet(() -> cursoRepository.save(new Curso(safeName)));
        cache.put(key, c);
        return c;
    }

    private Materia obtenerOCrearMateria(Map<String, Materia> cache, String nombre) {
        String safeName = (nombre == null || nombre.trim().isEmpty()) ? "General" : nombre.trim();
        String key = normalizar(safeName);
        if (cache.containsKey(key)) return cache.get(key);
        Materia m = materiaRepository.findByNombreIgnoreCase(safeName)
                .orElseGet(() -> materiaRepository.save(new Materia(safeName)));
        cache.put(key, m);
        return m;
    }

    private FranjaHoraria obtenerOCrearFranja(Map<String, FranjaHoraria> cache, String etiqueta, int orden) {
        String safeEtiqueta = (etiqueta == null || etiqueta.trim().isEmpty()) ? "07h10 - 07h50" : etiqueta.trim();
        String key = normalizar(safeEtiqueta);
        if (cache.containsKey(key)) return cache.get(key);
        FranjaHoraria f = franjaHorariaRepository.findByEtiquetaIgnoreCase(safeEtiqueta)
                .orElseGet(() -> {
                    String[] parts = safeEtiqueta.split("-");
                    String ini = parts.length > 0 ? parts[0].trim() : "";
                    String fin = parts.length > 1 ? parts[1].trim() : "";
                    return franjaHorariaRepository.save(new FranjaHoraria(safeEtiqueta, ini, fin, orden));
                });
        cache.put(key, f);
        return f;
    }

    @Transactional
    public Map<String, Object> importarExcel(InputStream inputStream) throws Exception {
        Workbook workbook = new XSSFWorkbook(inputStream);
        Map<String, Object> summary = new HashMap<>();

        Map<String, String> nameMapping = Map.ofEntries(
                Map.entry("Alexandra Acosta", "ACOSTA CHILAN ALEXANDRA ELIZABETH"),
                Map.entry("Alonzo Sierra", "ALONZO SIERRA LESLEY ANDREA"),
                Map.entry("Anabel Falcones", "ANABEL FALCONES"),
                Map.entry("Angela Castillo", "CASTILLO CUERO ANGELA ROXANNA"),
                Map.entry("Brandon Pacheco", "PACHECHO BUSTOS BRANDON ISRAEL"),
                Map.entry("Deisy Mite", "MITE VALENZUELA DEISY YADIRA"),
                Map.entry("Diego Morán", "MORÁN CHANCAY DIEGO ARMANDO"),
                Map.entry("Fátima Saavedra", "SAAVEDRA VILLAO FÁTIMA LEONOR"),
                Map.entry("Gabriela Moreno", "MORENO ORRALA GABRIELA TATIANA"),
                Map.entry("Glenda Banchón", "BANCHON FERNANDEZ GLENDA URSULINA"),
                Map.entry("Israel Del Valle", "DEL VALLE COELLO ISRAEL GABRIEL"),
                Map.entry("Jordy Vega", "VEGA VASQUEZ JORDY EDINSON"),
                Map.entry("Julia Jara", "JARA MERCHAN JULIA DEL ROCIO"),
                Map.entry("Karina Vargas", "VARGAS AROCA KARINA CECIBEL"),
                Map.entry("Kerlin Chiquito", "CHIQUITO GONZALEZ KERLIN DEL PILAR "),
                Map.entry("Lelis Fernández", "FERNANDEZ CONTRERAS LELIS GLENDA"),
                Map.entry("Lissete Ley", "LEY JADAN LISSETTE MADELEN"),
                Map.entry("Lucia Rivera", "RIVERA CARABAJO ROSA LUCIA"),
                Map.entry("Lupe Domínguez", "DOMINGUEZ RIVERA LUPE MARITZA"),
                Map.entry("Mayra Navarro", "NAVARRO NARVAEZ MAYRA DEL PILAR"),
                Map.entry("Mercedes Carbo", "CARBO TIXI MERCEDES NINOSKA"),
                Map.entry("Sonnia Muñoz", "MUÑOZ VALLE SONNIA ROSSANA"),
                Map.entry("Verónica Valencia", "VALENCIA VERNAZA VERÓNICA"),
                Map.entry("Vicente Reyes", "REYES MOLINEROS VICENTE MAURICIO")
        );

        Map<String, Docente> cacheDocentes = new HashMap<>();
        Map<String, Curso> cacheCursos = new HashMap<>();
        Map<String, Materia> cacheMaterias = new HashMap<>();
        Map<String, FranjaHoraria> cacheFranjas = new HashMap<>();

        // Pre-cargar existentes en caches
        docenteRepository.findAll().forEach(d -> {
            cacheDocentes.put(normalizar(d.getNombreCompleto()), d);
            if (d.getNombreCorto() != null) cacheDocentes.put(normalizar(d.getNombreCorto()), d);
        });
        cursoRepository.findAll().forEach(c -> cacheCursos.put(normalizar(c.getNombre()), c));
        materiaRepository.findAll().forEach(m -> cacheMaterias.put(normalizar(m.getNombre()), m));
        franjaHorariaRepository.findAll().forEach(f -> cacheFranjas.put(normalizar(f.getEtiqueta()), f));

        // 1. Procesar Hoja RESUMEN
        Sheet resumenSheet = workbook.getSheet("Resumen");
        int countDocentes = 0;
        int countCursos = 0;
        int countMaterias = 0;
        int countFranjas = 0;

        if (resumenSheet != null) {
            int orden = 1;
            for (int r = 0; r <= resumenSheet.getLastRowNum(); r++) {
                Row row = resumenSheet.getRow(r);
                if (row == null) continue;

                // Franjas Horarias (Col Q = col 16)
                String franjaText = getCellValueAsString(row.getCell(16));
                if (!franjaText.isEmpty() && !cacheFranjas.containsKey(normalizar(franjaText))) {
                    obtenerOCrearFranja(cacheFranjas, franjaText, orden++);
                    countFranjas++;
                }

                // Docentes (Col T = col 19)
                String docText = getCellValueAsString(row.getCell(19));
                if (!docText.isEmpty() && !cacheDocentes.containsKey(normalizar(docText))) {
                    String shortName = null;
                    for (Map.Entry<String, String> entry : nameMapping.entrySet()) {
                        if (normalizar(entry.getValue()).equals(normalizar(docText))) {
                            shortName = entry.getKey();
                            break;
                        }
                    }
                    obtenerOCrearDocente(cacheDocentes, docText, shortName != null ? shortName : docText);
                    countDocentes++;
                }

                // Cursos (Col X = col 23)
                String cursoText = getCellValueAsString(row.getCell(23));
                if (!cursoText.isEmpty() && !cacheCursos.containsKey(normalizar(cursoText))) {
                    obtenerOCrearCurso(cacheCursos, cursoText);
                    countCursos++;
                }

                // Materias (Col AA = col 26)
                String materiaText = getCellValueAsString(row.getCell(26));
                if (!materiaText.isEmpty() && !cacheMaterias.containsKey(normalizar(materiaText))) {
                    obtenerOCrearMateria(cacheMaterias, materiaText);
                    countMaterias++;
                }
            }
        }

        // 2. Procesar Hoja FILTRO (Disponibilidad)
        Sheet filtroSheet = workbook.getSheet("Filtro");
        int countDisponibilidad = 0;
        if (filtroSheet != null) {
            for (int r = 1; r <= filtroSheet.getLastRowNum(); r++) {
                Row row = filtroSheet.getRow(r);
                if (row == null) continue;
                String docShort = getCellValueAsString(row.getCell(0));
                String dia = getCellValueAsString(row.getCell(1));
                String franjaText = getCellValueAsString(row.getCell(2));

                if (docShort.isEmpty() || dia.isEmpty() || franjaText.isEmpty()) continue;

                FranjaHoraria franja = obtenerOCrearFranja(cacheFranjas, franjaText, 99);
                String docFullName = nameMapping.getOrDefault(docShort, docShort);
                Docente docente = obtenerOCrearDocente(cacheDocentes, docFullName, docShort);

                if (disponibilidadRepository.findByDocenteIdAndDiaSemanaIgnoreCaseAndFranjaHorariaId(docente.getId(), dia, franja.getId()).isEmpty()) {
                    disponibilidadRepository.save(new HorarioDisponibilidad(docente, dia, franja));
                    countDisponibilidad++;
                }
            }
        }

        // 3. Procesar Hoja REGISTRO (Historial)
        Sheet registroSheet = workbook.getSheet("Registro");
        int countContingencias = 0;
        if (registroSheet != null) {
            for (int r = 2; r <= registroSheet.getLastRowNum(); r++) {
                Row row = registroSheet.getRow(r);
                if (row == null) continue;

                LocalDate fecha = getCellValueAsDate(row.getCell(0));
                String docAusenteStr = getCellValueAsString(row.getCell(1));
                String docReemplazoStr = getCellValueAsString(row.getCell(2));
                String franjaStr = getCellValueAsString(row.getCell(3));
                String cursoStr = getCellValueAsString(row.getCell(4));
                String materiaStr = getCellValueAsString(row.getCell(5));
                String recursosStr = getCellValueAsString(row.getCell(6));
                String periodosStr = getCellValueAsString(row.getCell(7));
                String obsStr = getCellValueAsString(row.getCell(8));

                if (fecha == null || docAusenteStr.isEmpty() || docReemplazoStr.isEmpty() || franjaStr.isEmpty()) {
                    continue;
                }

                Docente docAusente = obtenerOCrearDocente(cacheDocentes, docAusenteStr, docAusenteStr);
                Docente docReemplazo = obtenerOCrearDocente(cacheDocentes, docReemplazoStr, docReemplazoStr);
                FranjaHoraria franja = obtenerOCrearFranja(cacheFranjas, franjaStr, 99);
                Curso curso = obtenerOCrearCurso(cacheCursos, cursoStr);
                Materia materia = obtenerOCrearMateria(cacheMaterias, materiaStr);

                BigDecimal per = BigDecimal.valueOf(1.0);
                try {
                    if (!periodosStr.isEmpty()) per = new BigDecimal(periodosStr);
                } catch (Exception ignored) {}

                Contingencia c = new Contingencia();
                c.setFecha(fecha);
                c.setDiaSemana(DisponibilidadService.obtenerDiaSemanaEnEspanol(fecha));
                c.setDocenteAusente(docAusente);
                c.setDocenteReemplazo(docReemplazo);
                c.setFranjaHoraria(franja);
                c.setCurso(curso);
                c.setMateria(materia);
                c.setRecursos("SI".equalsIgnoreCase(recursosStr) ? "SI" : "NO");
                c.setPeriodos(per);
                c.setObservacion(obsStr);

                contingenciaRepository.save(c);
                countContingencias++;
            }
        }

        workbook.close();

        summary.put("docentesImportados", countDocentes);
        summary.put("cursosImportados", countCursos);
        summary.put("materiasImportadas", countMaterias);
        summary.put("franjasImportadas", countFranjas);
        summary.put("disponibilidadesImportadas", countDisponibilidad);
        summary.put("contingenciasImportadas", countContingencias);
        summary.put("status", "SUCCESS");

        return summary;
    }
}
