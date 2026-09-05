-- ==========================================================
-- SISTEMA DE GESTIÓN Y AUTOMATIZACIÓN DE CONTINGENCIAS SBSG
-- SCRIPT DE CREACIÓN DE BASE DE DATOS Y TABLAS (MySQL 8.0+)
-- ==========================================================

CREATE DATABASE IF NOT EXISTS sbsg_contingencias
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE sbsg_contingencias;

-- 1. Tabla de Docentes
CREATE TABLE IF NOT EXISTS docentes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(200) NOT NULL UNIQUE,
    nombre_corto VARCHAR(100),
    email VARCHAR(150),
    telefono VARCHAR(50),
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Tabla de Cursos / Grados
CREATE TABLE IF NOT EXISTS cursos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 3. Tabla de Materias / Asignaturas
CREATE TABLE IF NOT EXISTS materias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 4. Tabla de Franjas Horarias
CREATE TABLE IF NOT EXISTS franjas_horarias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    etiqueta VARCHAR(50) NOT NULL UNIQUE, -- ej: '07h10 - 07h50'
    hora_inicio VARCHAR(10),
    hora_fin VARCHAR(10),
    orden INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

-- 5. Tabla de Horarios de Disponibilidad (Docentes Libres por Día y Franja)
CREATE TABLE IF NOT EXISTS horarios_disponibilidad (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    docente_id BIGINT NOT NULL,
    dia_semana VARCHAR(20) NOT NULL, -- 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'
    franja_horaria_id BIGINT NOT NULL,
    CONSTRAINT fk_disp_docente FOREIGN KEY (docente_id) REFERENCES docentes(id) ON DELETE CASCADE,
    CONSTRAINT fk_disp_franja FOREIGN KEY (franja_horaria_id) REFERENCES franjas_horarias(id) ON DELETE CASCADE,
    CONSTRAINT uq_disp_docente_dia_franja UNIQUE (docente_id, dia_semana, franja_horaria_id)
) ENGINE=InnoDB;

-- 6. Tabla de Registro de Contingencias
CREATE TABLE IF NOT EXISTS contingencias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    dia_semana VARCHAR(20) NOT NULL,
    docente_ausente_id BIGINT NOT NULL,
    docente_reemplazo_id BIGINT NOT NULL,
    franja_horaria_id BIGINT NOT NULL,
    curso_id BIGINT NOT NULL,
    materia_id BIGINT NOT NULL,
    recursos VARCHAR(10) DEFAULT 'NO', -- 'SI' o 'NO'
    periodos DECIMAL(4, 1) DEFAULT 1.0, -- Número de horas/periodos (ej: 1.0, 2.0)
    observacion TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cont_doc_ausente FOREIGN KEY (docente_ausente_id) REFERENCES docentes(id),
    CONSTRAINT fk_cont_doc_reemplazo FOREIGN KEY (docente_reemplazo_id) REFERENCES docentes(id),
    CONSTRAINT fk_cont_franja FOREIGN KEY (franja_horaria_id) REFERENCES franjas_horarias(id),
    CONSTRAINT fk_cont_curso FOREIGN KEY (curso_id) REFERENCES cursos(id),
    CONSTRAINT fk_cont_materia FOREIGN KEY (materia_id) REFERENCES materias(id)
) ENGINE=InnoDB;

-- Índices de consulta frecuente para reportes y asignaciones
CREATE INDEX idx_contingencias_fecha ON contingencias(fecha);
CREATE INDEX idx_contingencias_doc_reemplazo ON contingencias(docente_reemplazo_id);
CREATE INDEX idx_contingencias_doc_ausente ON contingencias(docente_ausente_id);
CREATE INDEX idx_disp_dia_franja ON horarios_disponibilidad(dia_semana, franja_horaria_id);

