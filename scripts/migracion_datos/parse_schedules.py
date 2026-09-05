import os
import re
import json
import urllib.request
from pypdf import PdfReader

# Map course names to DB IDs
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
    '1° BGU': 12, 'PRIMERO BGU': 12, '1ERO BGU': 12, '1RO BGU': 12, '1 BGU': 12,
    '2° BGU': 13, 'SEGUNDO BGU': 13, '2DO BGU': 13, '2 BGU': 13, '2°BGU': 13,
    '3° BGU': 14, 'TERCERO BGU': 14, '3RO BGU': 14, '3 BGU': 14, '3°BGU': 14
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
    'CIUDADANÍA': 13, 'EDUCACIÓN PARA LA CIUDADANÍA': 13,
    'EMPRENDIMIENTO': 14, 'EMPRENDIMIENTO Y GESTIÓN': 14,
    'ESTUDIOS SOCIALES': 15, 'SOCIALES': 15, 'EESS': 15,
    'EXPRESIÓN CORPORAL': 16,
    'FILOSOFÍA': 17, 'FILOSOFIA': 17,
    'FÍSICA': 18, 'FISICA': 18,
    'HABILIDADES COMPUTACIONALES': 19, 'H. COMPUTACIONALES': 19, 'COMPUTACIÓN': 19,
    'HISTORIA': 20,
    'IDENTIDAD Y AUTONOMÍA': 21, 'AUTONOMÍA': 21,
    'INGLÉS': 22, 'INGLES': 22,
    'INVESTIGACIÓN': 23,
    'LENGUA Y LITERATURA': 24, 'LENGUA': 24, 'LITERATURA': 24,
    'MATEMÁTICA': 25, 'MATEMATICA': 25, 'MATEMÁTICAS': 25,
    'MISA': 26, 'MISA PRIMARIA': 26, 'MISA SECUNDARIA': 26,
    'OVP': 27,
    'STEAM': 28,
    'RELIGIÓN': 29, 'RELIGION': 29,
    'QUÍMICA': 30, 'QUIMICA': 30,
    'ROBÓTICA': 31, 'ROBOTICA': 31,
    'RELACIONES LÓGICO MATEMÁTICAS': 32, 'LÓGICO MATEMÁTICAS': 32, 'LOGICO MATEMATICAS': 32,
    'REDACCIÓN CREATIVA': 33, 'REDACCION CREATIVA': 33
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
    '13h00 - 13h40': 11,
    '09h50 - 10h20': 12
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

def clean_text(text):
    return re.sub(r'\s+', ' ', text).strip()

def identify_course(text):
    t = text.upper()
    # Check specific patterns
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

def is_class_activity(text, curso_id):
    t = text.upper()
    if 'MISA' in t:
        return True
    if 'PPFF' in t or 'PADRES DE FAMILIA' in t:
        return True
    if 'RECESO' in t or 'SALIDA' in t or 'LUNCH' in t:
        return False
    if curso_id is not None:
        # Has an assigned course -> It is a class!
        return True
    # Non-class keywords
    for free_kw in ['PREPARACIÓN', 'PLANIFICACIÓN', 'PLANIFICACION', 'MATERIAL DIDÁCTICO', 'MATERIAL DIDACTICO', 
                   'RECUPERACIÓN', 'RECUPERACION', 'AMBIENTES', 'CALIFICACIÓN', 'CALIFICACION', 'INFORMES', 'ACOMPAÑAMIENTO']:
        if free_kw in t:
            return False
    return False

def parse_teacher_pdf(filepath):
    reader = PdfReader(filepath)
    page = reader.pages[0]
    elements = []
    def visitor(text, cm, tm, fontDict, fontSize):
        t = text.strip()
        if t and tm[4] < 630 and tm[5] > 70:
            elements.append({'x': round(tm[4], 1), 'y': round(tm[5], 1), 'text': t})
    page.extract_text(visitor_text=visitor)

    col_bounds = [
        ('Lunes', 75, 185),
        ('Martes', 185, 295),
        ('Miércoles', 295, 405),
        ('Jueves', 405, 515),
        ('Viernes', 515, 630)
    ]

    time_els = [el for el in elements if re.search(r'\d{2}h\d{2}\s*-\s*\d{2}h\d{2}', el['text']) and el['x'] < 75]
    time_els.sort(key=lambda e: -e['y'])

    row_bounds = []
    for i in range(len(time_els)):
        t_str = re.search(r'\d{2}h\d{2}\s*-\s*\d{2}h\d{2}', time_els[i]['text']).group(0)
        # Ignorar recreos y horas posteriores a las 13h40
        if ('13h40' in t_str or '14h00' in t_str or '14h20' in t_str or '14h30' in t_str or 
            '07h00' in t_str or '07h30' in t_str or '09h50 - 10h20' in t_str or '10h30 - 11h00' in t_str):
            continue

        if i == 0:
            y_top = time_els[0]['y'] + 20
        else:
            y_top = (time_els[i-1]['y'] + time_els[i]['y']) / 2
        
        if i == len(time_els) - 1:
            y_bottom = time_els[i]['y'] - 20
        else:
            y_bottom = (time_els[i]['y'] + time_els[i+1]['y']) / 2
        
        row_bounds.append((t_str, y_top, y_bottom))

    slots = []
    for t_str, y_top, y_bottom in row_bounds:
        franja_id = FRANJA_MAP.get(t_str)
        if not franja_id: continue

        for dia_name, x_min, x_max in col_bounds:
            cell_els = [el for el in elements if x_min <= el['x'] < x_max and y_bottom <= el['y'] < y_top]
            cell_els.sort(key=lambda e: (-e['y'], e['x']))
            cell_text = clean_text(' '.join([e['text'] for e in cell_els]))

            if not cell_text or 'RECESO' in cell_text.upper():
                # Free slot
                slots.append({
                    'diaSemana': dia_name,
                    'franjaHorariaId': franja_id,
                    'franjaEtiqueta': t_str,
                    'cursoId': None,
                    'materiaId': None,
                    'actividad': 'Libre',
                    'esClase': False
                })
                continue

            curso_id = identify_course(cell_text)
            materia_id = identify_materia(cell_text)
            es_clase = is_class_activity(cell_text, curso_id)

            slots.append({
                'diaSemana': dia_name,
                'franjaHorariaId': franja_id,
                'franjaEtiqueta': t_str,
                'cursoId': curso_id,
                'materiaId': materia_id,
                'actividad': cell_text,
                'esClase': es_clase
            })
    return slots

def main():
    doc_dir = 'HORARIOS DOCENTES'
    all_teachers_data = []

    for fname in sorted(os.listdir(doc_dir)):
        if not fname.endswith('.pdf'): continue
        docente_id = DOCENTE_FILES.get(fname)
        if not docente_id:
            # Match by normalized name
            for k, v in DOCENTE_FILES.items():
                if k.lower() == fname.lower():
                    docente_id = v
                    break
        if not docente_id:
            print('Could not find docente ID for:', fname)
            continue

        fpath = os.path.join(doc_dir, fname)
        slots = parse_teacher_pdf(fpath)
        all_teachers_data.append({
            'docenteId': docente_id,
            'fileName': fname,
            'slots': slots
        })

    os.makedirs('data', exist_ok=True)
    with open('data/horarios_docentes_parsed.json', 'w', encoding='utf-8') as f:
        json.dump(all_teachers_data, f, ensure_ascii=False, indent=2)

    print(f'Successfully parsed {len(all_teachers_data)} teacher schedule PDFs!')

if __name__ == '__main__':
    main()

