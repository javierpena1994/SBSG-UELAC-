# Sistema de Gestión y Automatización de Contingencias Docentes SBSG

Sistema integral para la automatización, cálculo de disponibilidad, asignación inteligente de reemplazos y generación de reportes institucionales de contingencias docentes en la **Unidad Educativa Lola Arosemena de Carbo (SBSG)**.

---

## 🏛️ Características del Sistema

1. **Búsqueda y Clasificación Inteligente de Reemplazos**:
   * Algoritmo de 4 prioridades automáticas según el grado/nivel de la contingencia:
     * ⭐ **Prioridad 1**: Mismo Nivel (Docentes del mismo ciclo: Inicial/Básica Elemental, Básica Media/Superior, Bachillerato).
     * 🔄 **Prioridad 2**: Otro Nivel (Docentes libres en la hora que pertenecen a otro ciclo).
     * 🏛️ **Prioridad 3**: Autoridades / Apoyo pedagógico (Personal con 0 horas de clase en la semana).
     * ⚠️ **Prioridad 4**: Docentes Ocupados con clase activa en la franja horaria.
   * Equidad de carga docente basada en el contador de reemplazos acumulados.

2. **Módulo Unificado de Historial y Reportes**:
   * Encabezado institucional oficial con logotipo y datos de la Coordinación Pedagógica.
   * Métricas y KPIs en vivo (Total de Horas Cubiertas, Total Contingencias, Con/Sin Material).
   * Rankings visuales de horas cubiertas por reemplazante y horas de inasistencias.
   * Tabla pormenorizada con botones de acción rápida:
     * 👁️ **Ver Detalle**: Modal con información completa del registro, hora, materia y motivo.
     * 🗑️ **Eliminar**: Eliminación con confirmación y recálculo instantáneo de horas.
   * Barra superior fija (**Sticky**) con exportación directa:
     * 📸 **Generar como Imagen**: Descarga automática de imagen JPG en formato A4 de alta definición con recuadros exactos.
     * 🖨️ **Imprimir / Guardar PDF**: Estilos optimizados para impresión formal y firma de Coordinación.

3. **Editor Visual de Horarios y Disponibilidad**:
   * Horarios por Curso / Paralelo y Horarios por Docente.
   * Asignación por clics con guardado inmediato en base de datos persistente.

4. **Gestión de Catálogos**:
   * Módulo de Docentes (Creación, Edición y Estado Activo/Inactivo).
   * Módulo de Materias / Asignaturas vinculadas por nivel educativo.

---

## 📁 Estructura del Proyecto

```text
SBSG/
├── backend/                             # Código fuente backend Spring Boot (Java 21)
│   ├── src/main/java/                   # Controladores, Servicios, Repositorios y Entidades
│   ├── src/main/resources/              # Configuración y recursos estáticos embebidos
│   ├── pom.xml                          # Configuración Maven
│   └── target/contingencias-sbsg.jar   # Archivo ejecutable empaquetado autónomo
│
├── frontend/                            # Interfaz Web (HTML5 / CSS3 / JavaScript ES6+)
│   ├── assets/                          # Logotipos e imágenes institucionales (logo.jpg, logo2.png)
│   ├── css/                             # Estilos modulares (main, layout, forms, tables, report)
│   ├── js/                              # Lógica cliente (api, app, registro, historial, horarios, etc.)
│   ├── index.html                       # Dashboard principal
│   ├── registro.html                    # Registro y asignación dinámica de contingencias
│   ├── historial.html                   # Historial y Generador de Reportes unificado
│   ├── docentes.html                    # Directorio de docentes
│   ├── materias.html                    # Catálogo de materias
│   └── horarios.html                    # Editor de horarios y disponibilidad
│
├── data/                                # Base de datos persistente del sistema (H2 File DB)
│   ├── sbsg_contingencias_db.mv.db      # Datos activos (docentes, horarios, 300+ contingencias)
│   └── sbsg_contingencias_db.trace.db   # Logs y trazas transaccionales
│
├── database/                            # Respaldos y esquemas SQL
│   ├── schema.sql                       # DDL de tablas para MySQL / H2
│   ├── seed_data.sql                    # Datos iniciales estructurados
│   └── sbsg_contingencias_db_backup.mv.db # Copia de seguridad de la base de datos
│
├── recursos/                            # Documentación y archivos fuente
│   ├── documentos_fuente/               # Archivos Excel originales de horarios y contingencias
│   │   ├── Contingencias 2026.xlsx
│   │   ├── HORARIOS CURSOS/
│   │   └── HORARIOS DOCENTES/
│   └── logos/                           # Logotipos institucionales en alta calidad
│       ├── logo.jpg
│       └── logo2.png
│
├── scripts/                             # Herramientas auxiliares y migración de datos
│   └── migracion_datos/                 # Scripts Python de parseo y verificación
│
├── iniciar.sh                           # Script de inicio universal para macOS / Linux
├── iniciar.bat                          # Script de inicio universal para Windows
└── README.md                            # Documentación del sistema
```

---

## 🚀 Despliegue en Otra Computadora

El sistema está empaquetado de forma 100% portable. Todos los datos, horarios y contingencias van incluidos en la carpeta `data/`.

### Requisitos Previos:
* Tener instalado **Java 21** (JDK o JRE).

### Pasos para Iniciar:

#### En macOS / Linux:
1. Abre una terminal en la carpeta del proyecto `SBSG`.
2. Ejecuta:
   ```bash
   ./iniciar.sh
   ```
3. Abre tu navegador web en: **[http://localhost:8080](http://localhost:8080)**

#### En Windows:
1. Abre la carpeta del proyecto `SBSG`.
2. Haz doble clic en **`iniciar.bat`**.
3. Abre tu navegador web en: **[http://localhost:8080](http://localhost:8080)**

---

## 🤖 Despliegue con Antigravity en la Nueva Máquina

1. Copia o clona la carpeta `SBSG/` en la nueva máquina.
2. Abre la carpeta del proyecto en **Antigravity**.
3. Antigravity detectará el entorno y arrancará el backend automáticamente utilizando el script `iniciar.sh` / `iniciar.bat` o el JAR `backend/target/contingencias-sbsg.jar`.
4. ¡El sistema cargará de inmediato con toda la base de datos exactamente tal como la dejaste!

---

## 📡 Endpoints de la API REST

| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| `GET` | `/api/disponibilidad/disponibles` | Lista docentes disponibles para reemplazo según fecha, hora y ausente |
| `POST` | `/api/contingencias` | Registra una nueva contingencia asignada |
| `GET` | `/api/contingencias/paginado` | Obtiene el historial con filtros de fecha, docente y paginación |
| `DELETE` | `/api/contingencias/{id}` | Elimina un registro de contingencia |
| `GET` | `/api/reportes` | Genera totales de horas y métricas por rango de fechas |
| `GET` | `/api/reportes/exportar-excel` | Descarga reporte completo en formato Excel (.xlsx) |
| `GET` | `/api/catalogos` | Devuelve docentes, cursos, materias y franjas horarias |
| `POST` | `/api/import/excel-default` | Re-sincroniza la base de datos desde `Contingencias 2026.xlsx` |
