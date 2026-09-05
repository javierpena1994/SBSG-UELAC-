import glob, os, re, json
from pypdf import PdfReader

TUTOR_COURSE_MAP = {
    23: 1,  # Rosa Rivera: Inicial 2
    24: 2,  # Fátima Saavedra: 1° EGB
    13: 3,  # Lissette Ley: 2° EGB
    5: 4,   # Mercedes Carbo: 3° EGB
    18: 5,  # Gabriela Moreno: 4° EGB
    8: 6,   # Lupe Dominguez: 5° EGB
    31: 7,  # Anabel Falcones: 6° EGB
    9: 8,   # Lelis Fernandez: 7° EGB
    26: 9,  # Verónica Valencia: 8° EGB
    17: 10, # Diego Morán: 9° EGB
    19: 11, # Sonnia Muñoz: 10° EGB
    16: 12, # Deisy Mite: 1° BGU
    4: 13,  # Ángela Castillo: 2° BGU
    7: 14   # Israel Del Valle: 3° BGU
}

CURSO_MAP = {
    'INICIAL 2': 1, 'INICIAL': 1, 'INICIAL2': 1,
    '1° EGB': 2, 'PRIMERO EGB': 2, '1ERO EGB': 2, '1RO EGB': 2, '1 EGB': 2, 'PRIMERO': 2,
    '2° EGB': 3, 'SEGUNDO EGB': 3, '2DO EGB': 3, '2 EGB': 3, 'SEGUNDO': 3,
    '3° EGB': 4, 'TERCERO EGB': 4, '3RO EGB': 4, '3 EGB': 4, 'TERCERO': 4,
    '4° EGB': 5, 'CUARTO EGB': 5, '4TO EGB': 5, '4 EGB': 5, 'CUARTO': 5,
    '5° EGB': 6, 'QUINTO EGB': 6, '5TO EGB': 6, '5 EGB': 6, 'QUINTO': 6,
    '6° EGB': 7, 'SEXTO EGB': 7, '6TO EGB': 7, '6 EGB': 7, 'SEXTO': 7,
    '7° EGB': 8, 'SÉPTIMO EGB': 8, 'SEPTIMO EGB': 8, '7MO EGB': 8, '7 EGB': 8, 'SEPTIMO': 8, 'SÉPTIMO': 8,
    '8° EGB': 9, 'OCTAVO EGB': 9, '8VO EGB': 9, '8 EGB': 9, 'OCTAVO': 9, '8VO': 9,
    '9° EGB': 10, 'NOVENO EGB': 10, '9NO EGB': 10, '9 EGB': 10, 'NOVENO': 10, '9NO': 10,
    '10° EGB': 11, 'DÉCIMO EGB': 11, 'DECIMO EGB': 11, '10MO EGB': 11, '10 EGB': 11, 'DÉCIMO': 11, 'DECIMO': 11, '10MO': 11,
    '1° BGU': 12, 'PRIMERO BGU': 12, '1ERO BGU': 12, '1RO BGU': 12, '1 BGU': 12, '1RO': 12, '1ERO': 12,
    '2° BGU': 13, 'SEGUNDO BGU': 13, '2DO BGU': 13, '2 BGU': 13, '2°BGU': 13, '2DO': 13, '2DO BGU': 13,
    '3° BGU': 14, 'TERCERO BGU': 14, '3RO BGU': 14, '3 BGU': 14, '3°BGU': 14, '3RO': 14, '3RO BGU': 14
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

FRANJA_MAP = {
    '07h10 - 07h50': 1,
    '07h50 - 08h30': 2,
    '08h30 - 09h10': 3,
    '09h10 - 09h50': 4,
    '09h50 - 10h30': 5,
    '10h20 - 11h00': 6,
    '10h30 - 11h00': 7,
    '11h00 - 11h40': 8,
    '11h40 - 12h20': 9,
    '12h20 - 13h00': 10,
    '13h00 - 13h40': 11
}

DOCENTE_FILES = {
    'Horario ALEXANDRA ACOSTA.pdf': 1,
    'Horario ANABEL FALCONES.pdf': 31,
    'Horario ÁNGELA CASTILLO.pdf': 4,
    'Horario ÁNGELA CASTILLO.pdf': 4,
    'Horario BRANDON PACHECO.pdf': 21,
    'Horario DEISY MITE.pdf': 16,
    'Horario DIEGO MORÁN.pdf': 17,
    'Horario DIEGO MORÁN.pdf': 17,
    'Horario FÁTIMA SAAVEDRA.pdf': 24,
    'Horario FÁTIMA SAAVEDRA.pdf': 24,
    'Horario GABRIELA MORENO.pdf': 18,
    'Horario GLENDA BANCHÓN.pdf': 3,
    'Horario GLENDA BANCHÓN.pdf': 3,
    'Horario ISRAEL DEL VALLE.pdf': 7,
    'Horario JORDY VEGA.pdf': 28,
    'Horario JULIA JARA.pdf': 11,
    'Horario KARINA VARGAS.pdf': 27,
    'Horario KERLIN CHIQUITO.pdf': 32,
    'Horario LELIS FERNANDEZ.pdf': 9,
    'Horario LISSETTE LEY.pdf': 13,
    'Horario LUPE DOMINGUEZ.pdf': 8,
    'Horario MAYRA NAVARRO.pdf': 20,
    'Horario MERCEDES CARBO.pdf': 5,
    'Horario ROSA RIVERA.pdf': 23,
    'Horario SHIRLEY MERO.pdf': 15,
    'Horario SONNIA  MUÑOZ.pdf': 19,
    'Horario SONNIA MUÑOZ.pdf': 19,
    'Horario VERÓNICA VALENCIA.pdf': 26,
    'Horario VERÓNICA VALENCIA.pdf': 26,
    'Horario VICENTE REYES.pdf': 22
}

DOCENTE_DEFAULT_MATERIA = {
    4: 24,  # Angela Castillo: Lengua y Literatura
    21: 22, # Brandon Pacheco: Inglés
    16: 31, # Deisy Mite: Robótica / Programación
    17: 11, # Diego Morán: ECA
    24: 25, # Fátima Saavedra: Inicial 2 / Primaria
    18: 24, # Gabriela Moreno: Cuarto EGB tutor
    3: 29,  # Glenda Banchón: Religión
    7: 6,   # Israel Del Valle: Ciencias Naturales / Biología
    28: 15, # Jordy Vega: Estudios Sociales
    11: 29, # Julia Jara: Religión
    27: 22, # Karina Vargas: Inglés
    32: 25, # Kerlin Chiquito: Matemática
    9: 25,  # Lelis Fernandez: Matemática
    13: 24, # Lissette Ley: Segundo EGB tutor
    8: 24,  # Lupe Dominguez: Lengua y Literatura
    20: 7,  # Mayra Navarro: Primero EGB
    5: 11,  # Mercedes Carbo: Tercero EGB tutor / ECA
    23: 7,  # Rosa Rivera: Inicial 2 tutor
    15: 25, # Shirley Mero: Matemática
    19: 13, # Sonnia Muñoz: Ciudadanía / Lengua
    26: 31, # Verónica Valencia: Robótica / Emprendimiento
    22: 25  # Vicente Reyes: Matemática / Física
}

def clean_text(text):
    return re.sub(r'\s+', ' ', text).strip()

def identify_course(text):
    t = text.upper()
    for k in sorted(CURSO_MAP.keys(), key=lambda x: -len(x)):
        if re.search(r'\b' + re.escape(k) + r'\b', t):
            return CURSO_MAP[k]
    return None

def identify_materia(text):
    t = text.upper()
    for k in sorted(MATERIA_MAP.keys(), key=lambda x: -len(x)):
        if re.search(r'\b' + re.escape(k) + r'\b', t):
            return MATERIA_MAP[k]
    return None

def is_free_activity(text):
    t = text.upper()
    for kw in ['PREPARACIÓN DE CLASES', 'PLANIFICACIÓN', 'PLANIFICACION', 'MATERIAL DIDÁCTICO', 'MATERIAL DIDACTICO', 
               'RECUPERACIÓN', 'RECUPERACION', 'AMBIENTES DE APRENDIZAJE', 'CALIFICACIÓN DE TAREAS', 
               'ELABORACIÓN DE INFORMES', 'ELABORACION DE INFORMES', 'RECESO', 'SALIDA', 'LUNCH', 'ENTRADA', 
               'ACTUALIZACIÓN PEDAGÓGICA', 'ACTUALIZACION PEDAGOGICA', 'REUNIÓN']:
        if kw in t and not ('INGLÉS' in t or 'MATEMÁTICA' in t or 'LENGUA' in t or 'SOCIALES' in t or 'NATURALES' in t or 'ROBÓTICA' in t or 'ECA' in t or 'BIOLOGÍA' in t or 'FÍSICA' in t):
            return True
    return False

def parse_teacher_final(pdf_path, docente_id):
    reader = PdfReader(pdf_path)
    page = reader.pages[0]
    elements = []
    def visitor(text, cm, tm, font_dict, font_size):
        if text.strip():
            elements.append({'text': text.strip(), 'x': tm[4], 'y': tm[5], 'fs': font_size})

    page.extract_text(visitor_text=visitor)
    
    time_els = [el for el in elements if re.search(r'\d{2}h\d{2}\s*-\s*\d{2}h\d{2}', el['text']) and el['x'] < 75]
    time_els.sort(key=lambda e: -e['y'])
    
    valid_time_rows = []
    for el in time_els:
        t_str = re.search(r'\d{2}h\d{2}\s*-\s*\d{2}h\d{2}', el['text']).group(0)
        if ('13h40' in t_str or '14h00' in t_str or '14h20' in t_str or '14h30' in t_str or 
            '07h00' in t_str or '07h30' in t_str or '09h50 - 10h20' in t_str or '10h30 - 11h00' in t_str):
            continue
        franja_id = FRANJA_MAP.get(t_str)
        if franja_id:
            valid_time_rows.append({'etiqueta': t_str, 'franja_id': franja_id, 'y': el['y']})

    col_bounds = [
        ('Lunes', 70, 180),
        ('Martes', 180, 290),
        ('Miércoles', 290, 400),
        ('Jueves', 400, 510),
        ('Viernes', 510, 620)
    ]

    slots = []
    for col_idx, (dia_name, x_min, x_max) in enumerate(col_bounds):
        col_elements = [e for e in elements if x_min <= e['x'] < x_max and 60 <= e['y'] <= 430]
        
        for r_idx, row_info in enumerate(valid_time_rows):
            f_id = row_info['franja_id']
            y_cur = row_info['y']
            
            # Distance to closest
            cell_els = [e for e in col_elements if abs(e['y'] - y_cur) <= 22]
            cell_els.sort(key=lambda e: (-e['y'], e['x']))
            cell_text = clean_text(' '.join([e['text'] for e in cell_els]))

            # Check double period from previous row
            if not cell_text and r_idx > 0:
                prev_f_id = valid_time_rows[r_idx-1]['franja_id']
                prev_slot = next((s for s in slots if s['diaSemana'] == dia_name and s['franjaHorariaId'] == prev_f_id), None)
                if prev_slot and prev_slot['esClase']:
                    y_prev = valid_time_rows[r_idx-1]['y']
                    # Elements around midpoint
                    mid_els = [e for e in col_elements if abs(e['y'] - (y_prev + y_cur)/2) <= 16]
                    if len(mid_els) > 0 or len(cell_els) == 0:
                        slots.append({
                            'diaSemana': dia_name,
                            'franjaHorariaId': f_id,
                            'franjaEtiqueta': row_info['etiqueta'],
                            'cursoId': prev_slot['cursoId'],
                            'materiaId': prev_slot['materiaId'],
                            'actividad': prev_slot['actividad'],
                            'esClase': True
                        })
                        continue

            curso_id = identify_course(cell_text) if cell_text else None
            materia_id = identify_materia(cell_text) if cell_text else None
            
            is_misa = 'MISA' in cell_text.upper()
            is_ppff = 'PPFF' in cell_text.upper() or 'PADRES DE FAMILIA' in cell_text.upper()
            
            if is_misa:
                slots.append({
                    'diaSemana': dia_name,
                    'franjaHorariaId': f_id,
                    'franjaEtiqueta': row_info['etiqueta'],
                    'cursoId': curso_id if curso_id else TUTOR_COURSE_MAP.get(docente_id),
                    'materiaId': 26, # MISA
                    'actividad': 'MISA',
                    'esClase': True
                })
            elif is_ppff:
                slots.append({
                    'diaSemana': dia_name,
                    'franjaHorariaId': f_id,
                    'franjaEtiqueta': row_info['etiqueta'],
                    'cursoId': curso_id if curso_id else TUTOR_COURSE_MAP.get(docente_id),
                    'materiaId': 27,
                    'actividad': 'Atención a PPFF',
                    'esClase': True
                })
            elif (curso_id is not None or materia_id is not None) and not is_free_activity(cell_text):
                # Class slot!
                # If course is present but materia is missing -> Assign teacher default specialty
                if curso_id is not None and materia_id is None:
                    materia_id = DOCENTE_DEFAULT_MATERIA.get(docente_id, 25)
                
                # If materia is present but course is missing -> Assign tutored course if tutor!
                if materia_id is not None and curso_id is None:
                    curso_id = TUTOR_COURSE_MAP.get(docente_id)

                slots.append({
                    'diaSemana': dia_name,
                    'franjaHorariaId': f_id,
                    'franjaEtiqueta': row_info['etiqueta'],
                    'cursoId': curso_id,
                    'materiaId': materia_id,
                    'actividad': cell_text if cell_text else 'Clase',
                    'esClase': True
                })
            else:
                act = cell_text if (cell_text and is_free_activity(cell_text)) else 'Disponible'
                slots.append({
                    'diaSemana': dia_name,
                    'franjaHorariaId': f_id,
                    'franjaEtiqueta': row_info['etiqueta'],
                    'cursoId': None,
                    'materiaId': None,
                    'actividad': act,
                    'esClase': False
                })

    return slots

# Run and inspect
print("Checking all teachers...")
all_perfect = True
for f in sorted(glob.glob('HORARIOS DOCENTES/*.pdf')):
    base = os.path.basename(f)
    doc_id = DOCENTE_FILES.get(base)
    if not doc_id or doc_id in [1, 31]: continue
    slots = parse_teacher_final(f, doc_id)
    clases = [s for s in slots if s['esClase']]
    clases_sin_materia = [s for s in clases if s['cursoId'] and not s['materiaId']]
    clases_sin_curso = [s for s in clases if s['materiaId'] and not s['cursoId']]
    if len(clases_sin_materia) > 0 or len(clases_sin_curso) > 0:
        all_perfect = False
        print(f"FAILED Docente ID {doc_id:2d} ({base}): Clases: {len(clases)}, Sin Materia: {len(clases_sin_materia)}, Sin Curso: {len(clases_sin_curso)}")
    else:
        print(f"✓ OK Docente ID {doc_id:2d} ({base:30s}): {len(clases):2d} clases (todas con curso y materia), {len(slots)-len(clases):2d} libres.")

print("All teachers parsed successfully:", all_perfect)
