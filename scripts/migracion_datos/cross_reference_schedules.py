import glob, os, re, json
from pypdf import PdfReader

# 1. Parse Course Schedules first to get the ground truth matrix:
# (cursoId, diaSemana, franjaHorariaId) -> materiaId
COURSE_SCHEDULE = {} # key: (cursoId, diaSemana, franjaId) -> materiaId

FRANJA_MAP = {
    '07h10 - 07h50': 1, '07h50 - 08h30': 2, '08h30 - 09h10': 3, '09h10 - 09h50': 4,
    '09h50 - 10h30': 5, '10h20 - 11h00': 6, '10h30 - 11h00': 7, '11h00 - 11h40': 8,
    '11h40 - 12h20': 9, '12h20 - 13h00': 10, '13h00 - 13h40': 11
}

MATERIA_MAP = {
    'ACOMPAÑAMIENTO': 1, 'TUTORÍA': 1, 'TUTORIA': 1,
    'ANATOMÍA': 2, 'ANATOMIA': 2,
    'BIBLIOTECA': 3, 'ANIMACIÓN A LA LECTURA': 3, 'LECTURA': 3,
    'BIOLOGÍA': 4, 'BIOLOGIA': 4,
    'CATEQUESIS': 5,
    'CIENCIAS NATURALES': 6, 'CCNN': 6, 'NATURALES': 6,
    'COMPRENSIÓN Y EXPRESIÓN ORAL': 7, 'ORAL Y ESCRITA': 7, 'COMPRENSIÓN': 7,
    'CONVIVENCIA': 8,
    'DESARROLLO DEL PENSAMIENTO': 9, 'DP': 9,
    'DESCUBRIMIENTO': 10, 'MEDIO NATURAL': 10, 'ENTORNO NATURAL': 10,
    'ECA': 11,
    'EDUCACIÓN FÍSICA': 12, 'ED. FÍSICA': 12, 'ED FÍSICA': 12, 'ED. FISICA': 12,
    'CIUDADANÍA': 13, 'EDUCACIÓN PARA LA CIUDADANÍA': 13, 'CIUDADANIA': 13,
    'EMPRENDIMIENTO': 14, 'EMPRENDIMIENTO Y GESTIÓN': 14, 'GESTIÓN': 14, 'GESTION': 14,
    'ESTUDIOS SOCIALES': 15, 'SOCIALES': 15, 'EESS': 15,
    'EXPRESIÓN CORPORAL': 16,
    'FILOSOFÍA': 17, 'FILOSOFIA': 17,
    'FÍSICA': 18, 'FISICA': 18,
    'HABILIDADES COMPUTACIONALES': 19, 'H. COMPUTACIONALES': 19, 'COMPUTACIÓN': 19,
    'HISTORIA': 20,
    'IDENTIDAD Y AUTONOMÍA': 21, 'AUTONOMÍA': 21,
    'INGLÉS': 22, 'INGLES': 22, 'LAB INGLÉS': 22,
    'INVESTIGACIÓN': 23, 'INVESTIGACION': 23, 'I.C T.': 23, 'ICT': 23, 'I.C.T.': 23,
    'LENGUA Y LITERATURA': 24, 'LENGUA': 24, 'LITERATURA': 24,
    'MATEMÁTICA': 25, 'MATEMATICA': 25, 'MATEMÁTICAS': 25, 'NÚMEROS COMPLEJOS': 25, 'NUMEROS COMPLEJOS': 25, 'COMPLEJOS': 25,
    'MISA': 26, 'MISA PRIMARIA': 26, 'MISA SECUNDARIA': 26,
    'OVP': 27,
    'STEAM': 28,
    'RELIGIÓN': 29, 'RELIGION': 29,
    'QUÍMICA': 30, 'QUIMICA': 30,
    'ROBÓTICA': 31, 'ROBOTICA': 31, 'ROBÓTICA Y HABILIDADES COMPUTACIONALES': 31, 'PROGRAMACIÓN Y MODELADO 3D': 31,
    'RELACIONES LÓGICO MATEMÁTICAS': 32, 'LÓGICO MATEMÁTICAS': 32, 'LOGICO MATEMATICAS': 32,
    'REDACCIÓN CREATIVA': 33, 'REDACCION CREATIVA': 33, 'CREATIVA': 33
}

CURSO_FILES = {
    '00. Horario Inicial 2.pdf': 1,
    '01. Horario Primero EGB.pdf': 2,
    '02. Horario Segundo EGB.pdf': 3,
    '03. Horario Tercero EGB.pdf': 4,
    '04. Horario Cuarto EGB.pdf': 5,
    '05. Horario Quinto EGB.pdf': 6,
    '06. Horario Sexto EGB.pdf': 7,
    '07. Horario Séptimo EGB.pdf': 8,
    '08. Horario Octavo EGB.pdf': 9,
    '09. Horario Noveno EGB.pdf': 10,
    '10. Horario Décimo EGB.pdf': 11,
    '11. Horario Primero BGU.pdf': 12,
    '12. Horario Segundo BGU.pdf': 13,
    '13. Horario Tercero BGU.pdf': 14
}

def identify_materia(text):
    t = text.upper()
    for k in sorted(MATERIA_MAP.keys(), key=lambda x: -len(x)):
        if re.search(r'\b' + re.escape(k) + r'\b', t):
            return MATERIA_MAP[k]
    return None

# Parse each course PDF
for f in sorted(glob.glob('HORARIOS CURSOS/*.pdf')):
    c_id = CURSO_FILES.get(os.path.basename(f))
    if not c_id: continue
    reader = PdfReader(f)
    page = reader.pages[0]
    els = []
    def vis(t, cm, tm, font_dict, fs):
        if t.strip(): els.append({'text': t.strip(), 'x': tm[4], 'y': tm[5]})
    page.extract_text(visitor_text=vis)
    
    time_els = [el for el in els if re.search(r'\d{2}h\d{2}\s*-\s*\d{2}h\d{2}', el['text']) and el['x'] < 75]
    time_els.sort(key=lambda e: -e['y'])
    
    valid_rows = []
    for el in time_els:
        t_str = re.search(r'\d{2}h\d{2}\s*-\s*\d{2}h\d{2}', el['text']).group(0)
        f_id = FRANJA_MAP.get(t_str)
        if f_id and '13h40' not in t_str and '14h' not in t_str and '07h00' not in t_str and '09h50 - 10h20' not in t_str and '10h30 - 11h00' not in t_str:
            valid_rows.append({'etiqueta': t_str, 'franja_id': f_id, 'y': el['y']})

    col_bounds = [('Lunes', 70, 180), ('Martes', 180, 290), ('Miércoles', 290, 400), ('Jueves', 400, 510), ('Viernes', 510, 620)]
    for dia, x_min, x_max in col_bounds:
        col_els = [e for e in els if x_min <= e['x'] < x_max and 60 <= e['y'] <= 430]
        for r_idx, row in enumerate(valid_rows):
            f_id = row['franja_id']
            cell_els = [e for e in col_els if abs(e['y'] - row['y']) <= 20]
            cell_text = ' '.join([e['text'] for e in cell_els]).strip()
            mat_id = identify_materia(cell_text) if cell_text else None
            
            # Double period in course schedule
            if not mat_id and r_idx > 0:
                prev_f_id = valid_rows[r_idx-1]['franja_id']
                prev_mat = COURSE_SCHEDULE.get((c_id, dia, prev_f_id))
                if prev_mat:
                    COURSE_SCHEDULE[(c_id, dia, f_id)] = prev_mat
                    continue

            if mat_id:
                COURSE_SCHEDULE[(c_id, dia, f_id)] = mat_id

print(f"Extracted {len(COURSE_SCHEDULE)} course schedule slots.")
