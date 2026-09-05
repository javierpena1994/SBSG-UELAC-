-- ==========================================================
-- DATOS INICIALES EXTRAÍDOS DE Contingencias 2026.xlsx
-- ==========================================================

USE sbsg_contingencias;

-- Insertar Docentes
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('ACOSTA CHILAN ALEXANDRA ELIZABETH', 'Alexandra Acosta') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('ALONZO SIERRA LESLEY ANDREA', 'Alonzo Sierra') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('ANABEL FALCONES', 'Anabel Falcones') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('BANCHON FERNANDEZ GLENDA URSULINA', 'Glenda Banchón') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('CARBO TIXI MERCEDES NINOSKA', 'Mercedes Carbo') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('CASTILLO CUERO ANGELA ROXANNA', 'Angela Castillo') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('CEDEÑO MERO JESSICA VANESSA', 'CEDEÑO MERO JESSICA VANESSA') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('CHIQUITO GONZALEZ KERLIN DEL PILAR', 'Kerlin Chiquito') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('DEL VALLE COELLO ISRAEL GABRIEL', 'Israel Del Valle') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('DOMINGUEZ RIVERA LUPE MARITZA', 'Lupe Domínguez') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('FERNANDEZ CONTRERAS LELIS GLENDA', 'Lelis Fernández') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('FUENTES ESTARELLAS MARIA GUADALUPE', 'FUENTES ESTARELLAS MARIA GUADALUPE') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('JARA MERCHAN JULIA DEL ROCIO', 'Julia Jara') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('JARA TROYA ADOLFO ENRIQUE', 'JARA TROYA ADOLFO ENRIQUE') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('LEY JADAN LISSETTE MADELEN', 'Lissete Ley') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('MALAVÉ MINCHALA LUIS MANUEL', 'MALAVÉ MINCHALA LUIS MANUEL') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('MERO SARMIENTO SHIRLEY ELIZABETH', 'MERO SARMIENTO SHIRLEY ELIZABETH') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('MITE VALENZUELA DEISY YADIRA', 'Deisy Mite') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('MORENO ORRALA GABRIELA TATIANA', 'Gabriela Moreno') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('MORÁN CHANCAY DIEGO ARMANDO', 'Diego Morán') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('MUÑOZ VALLE SONNIA ROSSANA', 'Sonnia Muñoz') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('N.N Mat CCNN', 'N.N Mat CCNN') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('N.N Profe de Sexto', 'N.N Profe de Sexto') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('NAVARRO NARVAEZ MAYRA DEL PILAR', 'Mayra Navarro') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('PACHECHO BUSTOS BRANDON ISRAEL', 'Brandon Pacheco') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('REYES MOLINEROS VICENTE MAURICIO', 'Vicente Reyes') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('RIVERA CARABAJO ROSA LUCIA', 'Lucia Rivera') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('SAAVEDRA VILLAO FÁTIMA LEONOR', 'Fátima Saavedra') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('SANDOVAL ORELLANA MARIA ELENA', 'SANDOVAL ORELLANA MARIA ELENA') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('VALENCIA VERNAZA VERÓNICA', 'Verónica Valencia') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('VARGAS AROCA KARINA CECIBEL', 'Karina Vargas') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);
INSERT INTO docentes (nombre_completo, nombre_corto) VALUES ('VEGA VASQUEZ JORDY EDINSON', 'Jordy Vega') ON DUPLICATE KEY UPDATE nombre_corto = VALUES(nombre_corto);

-- Insertar Cursos
INSERT INTO cursos (nombre) VALUES ('10° EGB') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('1° BGU') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('1° EGB') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('2° BGU') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('2° EGB') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('3° BGU') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('3° EGB') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('4° EGB') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('5° EGB') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('6° EGB') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('7° EGB') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('8° EGB') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('9° EGB') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO cursos (nombre) VALUES ('INICIAL 2') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);

-- Insertar Materias
INSERT INTO materias (nombre) VALUES ('ACOMPAÑAMIENTO INTEGRAL EN EL AULA (TUTORÍA)') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('ANATOMÍA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('ANIMACIÓN A LA LECTURA (BIBLIOTECA)') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('BIOLOGÍA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('CATEQUESIS') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('CIENCIAS NATURALES') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('COMPRENSIÓN Y EXPRESIÓN ORAL Y ESCRITA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('CONVIVENCIA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('DESARROLLO DEL PENSAMIENTO') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('DESCUBRIMIENTO Y COMPRENSIÓN DEL MEDIO NATURAL Y CULTURAL') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('ECA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('EDUCACIÓN FÍSICA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('EDUCACIÓN PARA LA CIUDADANÍA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('EMPRENDIMIENTO Y GESTIÓN') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('ESTUDIOS SOCIALES') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('EXPRESIÓN CORPORAL Y MOTRICIDAD (EDUCACIÓN FÍSICA)') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('FILOSOFÍA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('FÍSICA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('HABILIDADES COMPUTACIONALES') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('HISTORIA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('IDENTIDAD Y AUTONOMÍA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('INGLÉS') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('INVESTIGACIÓN, CIENCIA Y TECNOLOGÍA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('LENGUA Y LITERATURA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('MATEMÁTICA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('MISA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('OVP') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('QUÍMICA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('REDACCIÓN CREATIVA') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('RELACIONES LÓGICO MATEMÁTICAS') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('RELIGIÓN') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('ROBÓTICA Y HABILIDADES COMPUTACIONALES') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
INSERT INTO materias (nombre) VALUES ('STEAM') ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);

-- Insertar Franjas Horarias
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('07h10 - 07h50', '07h10', '07h50', 1) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('07h50 - 08h30', '07h50', '08h30', 2) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('08h30 - 09h10', '08h30', '09h10', 3) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('09h10 - 09h50', '09h10', '09h50', 4) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('09h50 - 10h20', '09h50', '10h20', 5) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('09h50 - 10h30', '09h50', '10h30', 6) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('10h20 - 11h00', '10h20', '11h00', 7) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('10h30 - 11h00', '10h30', '11h00', 8) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('11h00 - 11h40', '11h00', '11h40', 9) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('11h40 - 12h20', '11h40', '12h20', 10) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('12h20 - 13h00', '12h20', '13h00', 11) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('13h00 - 13h40', '13h00', '13h40', 12) ON DUPLICATE KEY UPDATE orden = VALUES(orden);
INSERT INTO franjas_horarias (etiqueta, hora_inicio, hora_fin, orden) VALUES ('13h40 - 14h20', '13h40', '14h20', 13) ON DUPLICATE KEY UPDATE orden = VALUES(orden);

-- Insertar Horarios de Disponibilidad (Filtro)
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '09h50 - 10h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '09h50 - 10h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '10h30 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '09h50 - 10h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH' OR d.nombre_corto = 'Alexandra Acosta')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA' OR d.nombre_corto = 'Glenda Banchón')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA' OR d.nombre_corto = 'Mercedes Carbo')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA' OR d.nombre_corto = 'Angela Castillo')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL' OR d.nombre_corto = 'Israel Del Valle')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA' OR d.nombre_corto = 'Lupe Domínguez')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA' OR d.nombre_corto = 'Lelis Fernández')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO' OR d.nombre_corto = 'Julia Jara')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO' OR d.nombre_corto = 'Julia Jara')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO' OR d.nombre_corto = 'Julia Jara')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO' OR d.nombre_corto = 'Julia Jara')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO' OR d.nombre_corto = 'Julia Jara')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO' OR d.nombre_corto = 'Julia Jara')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'LEY JADAN LISSETTE MADELEN' OR d.nombre_corto = 'Lissete Ley')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MITE VALENZUELA DEISY YADIRA' OR d.nombre_corto = 'Deisy Mite')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR' OR d.nombre_corto = 'Kerlin Chiquito')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA' OR d.nombre_corto = 'Gabriela Moreno')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA' OR d.nombre_corto = 'Sonnia Muñoz')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR' OR d.nombre_corto = 'Mayra Navarro')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL' OR d.nombre_corto = 'Brandon Pacheco')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL' OR d.nombre_corto = 'Brandon Pacheco')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL' OR d.nombre_corto = 'Brandon Pacheco')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL' OR d.nombre_corto = 'Brandon Pacheco')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL' OR d.nombre_corto = 'Brandon Pacheco')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL' OR d.nombre_corto = 'Brandon Pacheco')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL' OR d.nombre_corto = 'Brandon Pacheco')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL' OR d.nombre_corto = 'Brandon Pacheco')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL' OR d.nombre_corto = 'Brandon Pacheco')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO' OR d.nombre_corto = 'Vicente Reyes')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA' OR d.nombre_corto = 'Lucia Rivera')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA' OR d.nombre_corto = 'Lucia Rivera')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA' OR d.nombre_corto = 'Lucia Rivera')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA' OR d.nombre_corto = 'Lucia Rivera')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA' OR d.nombre_corto = 'Lucia Rivera')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA' OR d.nombre_corto = 'Lucia Rivera')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA' OR d.nombre_corto = 'Lucia Rivera')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA' OR d.nombre_corto = 'Lucia Rivera')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA' OR d.nombre_corto = 'Lucia Rivera')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR' OR d.nombre_corto = 'Fátima Saavedra')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR' OR d.nombre_corto = 'Fátima Saavedra')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR' OR d.nombre_corto = 'Fátima Saavedra')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR' OR d.nombre_corto = 'Fátima Saavedra')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR' OR d.nombre_corto = 'Fátima Saavedra')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR' OR d.nombre_corto = 'Fátima Saavedra')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR' OR d.nombre_corto = 'Fátima Saavedra')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR' OR d.nombre_corto = 'Fátima Saavedra')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR' OR d.nombre_corto = 'Fátima Saavedra')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VALENCIA VERNAZA VERÓNICA' OR d.nombre_corto = 'Verónica Valencia')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VARGAS AROCA KARINA CECIBEL' OR d.nombre_corto = 'Karina Vargas')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VARGAS AROCA KARINA CECIBEL' OR d.nombre_corto = 'Karina Vargas')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VARGAS AROCA KARINA CECIBEL' OR d.nombre_corto = 'Karina Vargas')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VARGAS AROCA KARINA CECIBEL' OR d.nombre_corto = 'Karina Vargas')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VARGAS AROCA KARINA CECIBEL' OR d.nombre_corto = 'Karina Vargas')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VARGAS AROCA KARINA CECIBEL' OR d.nombre_corto = 'Karina Vargas')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VARGAS AROCA KARINA CECIBEL' OR d.nombre_corto = 'Karina Vargas')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VARGAS AROCA KARINA CECIBEL' OR d.nombre_corto = 'Karina Vargas')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VARGAS AROCA KARINA CECIBEL' OR d.nombre_corto = 'Karina Vargas')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VARGAS AROCA KARINA CECIBEL' OR d.nombre_corto = 'Karina Vargas')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VARGAS AROCA KARINA CECIBEL' OR d.nombre_corto = 'Karina Vargas')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON' OR d.nombre_corto = 'Jordy Vega')
  AND fh.etiqueta = '13h00 - 13h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '07h10 - 07h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '09h50 - 10h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO' OR d.nombre_corto = 'Diego Morán')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Lunes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '09h10 - 09h50'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Martes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Miércoles', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '11h00 - 11h40'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '10h20 - 11h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Jueves', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '12h20 - 13h00'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '07h50 - 08h30'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '08h30 - 09h10'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);
INSERT INTO horarios_disponibilidad (docente_id, dia_semana, franja_horaria_id)
SELECT d.id, 'Viernes', fh.id
FROM docentes d, franjas_horarias fh
WHERE (d.nombre_completo = 'ANABEL FALCONES' OR d.nombre_corto = 'Anabel Falcones')
  AND fh.etiqueta = '11h40 - 12h20'
ON DUPLICATE KEY UPDATE dia_semana = VALUES(dia_semana);

-- Insertar Registro Histórico de Contingencias
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-27', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Robotic Minds'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND dr.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'EMPRENDIMIENTO Y GESTIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-28', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-28', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-28', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Profe de Sexto'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-28', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Profe de Sexto'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'ANIMACIÓN A LA LECTURA (BIBLIOTECA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-28', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Profe de Sexto'
  AND dr.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'ANIMACIÓN A LA LECTURA (BIBLIOTECA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-29', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Cita médica "Riesgo laboral"'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-29', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-29', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-29', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-29', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Profe de Sexto'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'MISA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-04-29', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Profe de Sexto'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-04', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Profe de Sexto'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'ACOMPAÑAMIENTO INTEGRAL EN EL AULA (TUTORÍA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-04', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Profe de Sexto'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-04', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Profe de Sexto'
  AND dr.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'ANIMACIÓN A LA LECTURA (BIBLIOTECA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-04', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Profe de Sexto'
  AND dr.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-04', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Profe de Sexto'
  AND dr.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-04', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-04', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-04', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-04', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-05', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Reunión SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'INVESTIGACIÓN, CIENCIA Y TECNOLOGÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-05', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación IA'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'DESARROLLO DEL PENSAMIENTO';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-05', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación IA'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-05', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación IA'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-05', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación IA'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-05', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-05', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-05', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-05', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-06', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-06', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-06', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-06', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Presentación SENDERO (Religión)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Presentación SENDERO (Religión)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Presentación SENDERO (Religión)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CATEQUESIS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Presentación SENDERO (Religión)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Presentación SENDERO (Religión)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'CATEQUESIS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Presentación SENDERO (Religión)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND dr.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = 'INICIAL 2'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Presentación SENDERO (Religión)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND dr.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Presentación SENDERO (Religión)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso IESS (Examen Oftalmológico)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso IESS (Examen Oftalmológico)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-07', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso IESS (Examen Oftalmológico)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-08', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-08', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-08', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-11', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-11', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-11', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-12', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-12', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-12', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Programa de la mujer'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'Programa de la mujer'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Programa de la mujer'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Programa de la mujer'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Programa de la mujer'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Programa de la mujer'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Programa de la mujer'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-13', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Programa de la mujer'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MERO SARMIENTO SHIRLEY ELIZABETH'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'OVP';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'En contratación'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'Capacitación Competencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'N.N Mat CCNN'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Competencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Competencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND dr.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Competencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'BIOLOGÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Competencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'BIOLOGÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Competencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND dr.nombre_completo = 'ALONZO SIERRA LESLEY ANDREA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Competencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Competencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND dr.nombre_completo = 'FUENTES ESTARELLAS MARIA GUADALUPE'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'HISTORIA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Competencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND dr.nombre_completo = 'MERO SARMIENTO SHIRLEY ELIZABETH'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'FILOSOFÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-14', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'ESTUDIOS SOCIALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-15', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso (Consulta)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'FILOSOFÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-15', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso (Consulta)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'EDUCACIÓN PARA LA CIUDADANÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-15', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso (Consulta)'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'EDUCACIÓN PARA LA CIUDADANÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-15', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Robótica'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND dr.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'ACOMPAÑAMIENTO INTEGRAL EN EL AULA (TUTORÍA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-19', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Tekman'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'DESARROLLO DEL PENSAMIENTO';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-20', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación laboratorio'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'BIOLOGÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-20', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación laboratorio'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-21', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Pastoral'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-21', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Pastoral'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-21', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Pastoral'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CATEQUESIS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-21', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación Pastoral'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-22', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Adecuación de Laboratorio de Ciencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'QUÍMICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-22', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Adecuación de Laboratorio de Ciencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'QUÍMICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-22', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Adecuación de Laboratorio de Ciencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-22', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Adecuación de Laboratorio de Ciencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-22', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Adecuación de Laboratorio de Ciencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-26', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Formación Dolores Sopeña'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'CATEQUESIS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-26', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Adecuación de Laboratorio de Ciencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-26', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Adecuación de Laboratorio de Ciencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-26', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Adecuación de Laboratorio de Ciencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-26', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Adecuación de Laboratorio de Ciencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND dr.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-26', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Adecuación de Laboratorio de Ciencias'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-27', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-27', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-27', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'STEAM';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-27', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND dr.nombre_completo = 'CEDEÑO MERO JESSICA VANESSA'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-27', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-27', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND dr.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-27', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'ROBÓTICA Y HABILIDADES COMPUTACIONALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-27', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'ROBÓTICA Y HABILIDADES COMPUTACIONALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-27', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-27', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-28', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 2.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-28', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-28', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-28', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Preparación Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND dr.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND dr.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'EMPRENDIMIENTO Y GESTIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND dr.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'ANIMACIÓN A LA LECTURA (BIBLIOTECA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-05-29', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Aniversario SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-01', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-01', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-01', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-01', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-02', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-02', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-02', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-02', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-02', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'ACOMPAÑAMIENTO INTEGRAL EN EL AULA (TUTORÍA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-02', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'CEDEÑO MERO JESSICA VANESSA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-02', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-02', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-02', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'MISA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'ESTUDIOS SOCIALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'STEAM';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'STEAM';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'MISA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'STEAM';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-03', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'STEAM';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-04', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-04', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-04', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-04', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'ESTUDIOS SOCIALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-04', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-04', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-08', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'ESTUDIOS SOCIALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-08', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND dr.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'ESTUDIOS SOCIALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-08', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND dr.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'ACOMPAÑAMIENTO INTEGRAL EN EL AULA (TUTORÍA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-08', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND dr.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'DESARROLLO DEL PENSAMIENTO';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-08', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'ESTUDIOS SOCIALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-09', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'DESCUBRIMIENTO Y COMPRENSIÓN DEL MEDIO NATURAL Y CULTURAL';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-09', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-09', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-09', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'IDENTIDAD Y AUTONOMÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'ACOMPAÑAMIENTO INTEGRAL EN EL AULA (TUTORÍA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'CATEQUESIS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'ROBÓTICA Y HABILIDADES COMPUTACIONALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'ROBÓTICA Y HABILIDADES COMPUTACIONALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'CATEQUESIS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Actividad Pastoral (Sagrada Familia'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'CATEQUESIS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'COMPRENSIÓN Y EXPRESIÓN ORAL Y ESCRITA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-10', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-11', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Reunión Pastoral SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-12', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación Inglés Baltazara'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-12', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación Inglés Baltazara'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-12', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación Inglés Baltazara'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-12', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación Pastoral SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-12', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación Pastoral SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-12', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación Pastoral SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-12', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación Pastoral SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'CATEQUESIS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-12', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación Pastoral SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-12', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación Pastoral SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND dr.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-12', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación Pastoral SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-12', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación Pastoral SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND dr.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-15', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '2° EGB'
  AND m.nombre = '';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-15', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND dr.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '2° EGB'
  AND m.nombre = '';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-15', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '2° EGB'
  AND m.nombre = '';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-15', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '2° EGB'
  AND m.nombre = '';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-15', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Premio Año Viejo'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '9° EGB'
  AND m.nombre = '';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-15', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Premio Año Viejo'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '4° EGB'
  AND m.nombre = '';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-15', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Premio Año Viejo'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '6° EGB'
  AND m.nombre = '';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-15', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Premio Año Viejo'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '5° EGB'
  AND m.nombre = '';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-15', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Premio Año Viejo'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '1° BGU'
  AND m.nombre = '';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-15', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Premio Año Viejo'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '7° EGB'
  AND m.nombre = '';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-16', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND dr.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'ANIMACIÓN A LA LECTURA (BIBLIOTECA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-16', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND dr.nombre_completo = 'ALONZO SIERRA LESLEY ANDREA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'STEAM';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-16', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'STEAM';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-16', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'ESTUDIOS SOCIALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-16', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND dr.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-16', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND dr.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-16', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'CEDEÑO MERO JESSICA VANESSA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'DESCUBRIMIENTO Y COMPRENSIÓN DEL MEDIO NATURAL Y CULTURAL';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-16', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'RIVERA CARABAJO ROSA LUCIA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-16', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-16', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'IDENTIDAD Y AUTONOMÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-16', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-17', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-17', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'COMPRENSIÓN Y EXPRESIÓN ORAL Y ESCRITA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-17', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'SAAVEDRA VILLAO FÁTIMA LEONOR'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '1° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-17', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-17', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-17', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'ACOMPAÑAMIENTO INTEGRAL EN EL AULA (TUTORÍA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-17', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-18', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'JARA TROYA ADOLFO ENRIQUE'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-18', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-18', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-18', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-18', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-18', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Catedral - 1° BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-18', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Catedral - 1° BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CATEQUESIS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-18', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Catedral - 1° BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-18', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Catedral - 1° BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND dr.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'DESARROLLO DEL PENSAMIENTO';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-18', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Catedral - 1° BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'HISTORIA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-18', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Catedral - 1° BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'FILOSOFÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-19', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Conferencia - Seminario Mayor'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-19', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'STEAM';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-19', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-19', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-19', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-22', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'ESTUDIOS SOCIALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-22', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-22', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND dr.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-22', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-22', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND dr.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'ESTUDIOS SOCIALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-24', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Kick Off Desing Thinkin SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-24', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Kick Off Desing Thinkin SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND dr.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-24', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Kick Off Desing Thinkin SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'JARA MERCHAN JULIA DEL ROCIO'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'BIOLOGÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-24', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Kick Off Desing Thinkin SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'BIOLOGÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-24', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Kick Off Desing Thinkin SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'BIOLOGÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-24', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Kick Off Desing Thinkin SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'BIOLOGÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-24', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Kick Off Desing Thinkin SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-24', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Kick Off Desing Thinkin SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-24', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Kick Off Desing Thinkin SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'ROBÓTICA Y HABILIDADES COMPUTACIONALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-24', 'Miércoles', da.id, dr.id, fh.id, c.id, m.id, 'SI', 2.0, 'Kick Off Desing Thinkin SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'ROBÓTICA Y HABILIDADES COMPUTACIONALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-25', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Planificación Catequesis SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-25', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Planificación Catequesis SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-25', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Planificación Catequesis SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'CATEQUESIS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-25', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Planificación Catequesis SBSG'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-06-29', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Médico'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'EMPRENDIMIENTO Y GESTIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-02', 'Jueves', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Reunión Biblioteca'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND dr.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'REDACCIÓN CREATIVA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '5° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '6° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '7° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND fh.etiqueta = '10h20 - 11h00'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND dr.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'EDUCACIÓN FÍSICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Misa UEMAS'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Misa UEMAS'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Misa UEMAS'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'ECA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Misa UEMAS'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORÁN CHANCAY DIEGO ARMANDO'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '13h00 - 13h40'
  AND c.nombre = '9° EGB'
  AND m.nombre = 'ACOMPAÑAMIENTO INTEGRAL EN EL AULA (TUTORÍA)';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND dr.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '3° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '2° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Capacitación UEBCR'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'PACHECHO BUSTOS BRANDON ISRAEL'
  AND dr.nombre_completo = 'NAVARRO NARVAEZ MAYRA DEL PILAR'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = 'INICIAL 2'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación UEBCR'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-03', 'Viernes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Capacitación UEBCR'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'INGLÉS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'ACOSTA CHILAN ALEXANDRA ELIZABETH'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'LENGUA Y LITERATURA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'CARBO TIXI MERCEDES NINOSKA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'LEY JADAN LISSETTE MADELEN'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'MATEMÁTICA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'DOMINGUEZ RIVERA LUPE MARITZA'
  AND fh.etiqueta = '11h00 - 11h40'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'FERNANDEZ CONTRERAS LELIS GLENDA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'ESTUDIOS SOCIALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'MORENO ORRALA GABRIELA TATIANA'
  AND dr.nombre_completo = 'ANABEL FALCONES'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '4° EGB'
  AND m.nombre = 'ESTUDIOS SOCIALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Asilo 3BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'MUÑOZ VALLE SONNIA ROSSANA'
  AND fh.etiqueta = '07h50 - 08h30'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'CATEQUESIS';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Asilo 3BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '8° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Asilo 3BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '09h50 - 10h30'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Asilo 3BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'BANCHON FERNANDEZ GLENDA URSULINA'
  AND dr.nombre_completo = 'MITE VALENZUELA DEISY YADIRA'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'RELIGIÓN';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Asilo 3BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'VARGAS AROCA KARINA CECIBEL'
  AND fh.etiqueta = '07h10 - 07h50'
  AND c.nombre = '3° BGU'
  AND m.nombre = 'BIOLOGÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Asilo 3BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '1° BGU'
  AND m.nombre = 'BIOLOGÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Asilo 3BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'VALENCIA VERNAZA VERÓNICA'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'BIOLOGÍA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Asilo 3BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND fh.etiqueta = '11h40 - 12h20'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-06', 'Lunes', da.id, dr.id, fh.id, c.id, m.id, 'SI', 1.0, 'Visita Asilo 3BGU'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'DEL VALLE COELLO ISRAEL GABRIEL'
  AND dr.nombre_completo = 'VEGA VASQUEZ JORDY EDINSON'
  AND fh.etiqueta = '12h20 - 13h00'
  AND c.nombre = '10° EGB'
  AND m.nombre = 'CIENCIAS NATURALES';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-07', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND dr.nombre_completo = 'REYES MOLINEROS VICENTE MAURICIO'
  AND fh.etiqueta = '08h30 - 09h10'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'MISA';
INSERT INTO contingencias (fecha, dia_semana, docente_ausente_id, docente_reemplazo_id, franja_horaria_id, curso_id, materia_id, recursos, periodos, observacion)
SELECT '2026-07-07', 'Martes', da.id, dr.id, fh.id, c.id, m.id, 'NO', 1.0, 'Permiso Personal'
FROM docentes da, docentes dr, franjas_horarias fh, cursos c, materias m
WHERE da.nombre_completo = 'CASTILLO CUERO ANGELA ROXANNA'
  AND dr.nombre_completo = 'CHIQUITO GONZALEZ KERLIN DEL PILAR'
  AND fh.etiqueta = '09h10 - 09h50'
  AND c.nombre = '2° BGU'
  AND m.nombre = 'LENGUA Y LITERATURA';
