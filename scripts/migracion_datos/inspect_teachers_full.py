import glob, os, re, json
from pypdf import PdfReader

# Let's write a script that displays the parsed schedule for every teacher in table format
def get_pdf_lines(pdf_path):
    reader = PdfReader(pdf_path)
    text = reader.pages[0].extract_text()
    return text

print("Inspecting teacher PDFs...")
for f in sorted(glob.glob('HORARIOS DOCENTES/*.pdf')):
    base = os.path.basename(f)
    if 'ALEXANDRA ACOSTA' in base or 'ANABEL FALCONES' in base:
        continue
    reader = PdfReader(f)
    text = reader.pages[0].extract_text()
    lines = [l.strip() for l in text.split('\n') if l.strip()]
    # Find table section (starting with Hora)
    table_lines = []
    in_table = False
    for l in lines:
        if 'Hora' in l and 'Lunes' in l:
            in_table = True
        if in_table:
            table_lines.append(l)
            if '14h30' in l or '15h00' in l:
                break
    print(f"=== {base} ===")
    for l in table_lines[:16]:
        print("  ", l)
