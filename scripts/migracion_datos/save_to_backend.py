import urllib.request
import json
from data.parse_and_seed_perfect import parsed_teacher_slots

print("Saving verified schedules for all 22 teachers to backend...")
for doc_id, slots in parsed_teacher_slots.items():
    payload = {
        'docenteId': doc_id,
        'slots': [
            {
                'diaSemana': s['diaSemana'],
                'franjaHorariaId': s['franjaHorariaId'],
                'docenteId': doc_id,
                'cursoId': s['cursoId'],
                'materiaId': s['materiaId'],
                'actividad': s['actividad'],
                'esClase': s['esClase']
            }
            for s in slots
        ]
    }
    
    req = urllib.request.Request(
        "http://localhost:8080/api/horarios-clases/guardar-docente",
        data=json.dumps(payload).encode('utf-8'),
        headers={'Content-Type': 'application/json'},
        method='POST'
    )
    try:
        with urllib.request.urlopen(req) as resp:
            data = json.loads(resp.read().decode('utf-8'))
            print(f"✓ Saved Docente ID {doc_id:2d} ({len(data)} slots saved)")
    except Exception as e:
        print(f"❌ Failed to save Docente ID {doc_id:2d}: {e}")

print("\nDone saving verified teacher schedules!")
