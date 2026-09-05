/* ==========================================================
   SISTEMA DE GESTIÓN DE CONTINGENCIAS SBSG - HORARIOS JS (DOCENTES)
   ========================================================== */

document.addEventListener('DOMContentLoaded', async () => {
  // Elements
  const docenteSelect = document.getElementById('select-docente-editor');
  const tableBody = document.getElementById('interactive-schedule-tbody');
  const slotsCountBadge = document.getElementById('slots-count-badge');
  const btnMarcarTodos = document.getElementById('btn-marcar-todos');
  const btnResetAll = document.getElementById('btn-reset-all-schedules');
  const seccionTabs = document.querySelectorAll('.seccion-tab');

  // Modal elements
  const modal = document.getElementById('modal-edit-slot');
  const modalTitle = document.getElementById('modal-slot-title');
  const btnCloseModal = document.getElementById('btn-close-modal');
  const btnCancelModal = document.getElementById('btn-cancel-modal');
  const btnApplyModal = document.getElementById('btn-apply-modal');
  const modalTipoRadios = document.querySelectorAll('input[name="modal-tipo"]');
  const modalMateria = document.getElementById('modal-materia');
  const modalCurso = document.getElementById('modal-curso');
  const modalActividad = document.getElementById('modal-actividad');

  const DIAS_SEMANA = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'];

  let currentSeccion = 'ESCUELA'; // 'ESCUELA' | 'COLEGIO' | 'TODAS'
  let catalogos = { docentes: [], cursos: [], materias: [], franjasHorarias: [] };
  let currentDocenteId = null;

  // Map of slots: key is `${dia}_${franjaId}` => slot object
  let currentSlotsMap = new Map();
  let editingSlotKey = null;

  async function init() {
    try {
      catalogos = await API.getCatalogos();

      // Populate Docentes
      docenteSelect.innerHTML = '<option value="">-- Seleccionar Docente --</option>';
      (catalogos.docentes || []).forEach(d => {
        const opt = document.createElement('option');
        opt.value = d.id;
        opt.textContent = d.nombreCompleto;
        docenteSelect.appendChild(opt);
      });

      // Populate Modal Dropdowns
      modalMateria.innerHTML = '<option value="">-- Sin materia asignada --</option>';
      (catalogos.materias || []).forEach(m => {
        const opt = document.createElement('option');
        opt.value = m.id;
        opt.textContent = m.nombre;
        modalMateria.appendChild(opt);
      });

      App.populateCursoSelect(modalCurso, catalogos.cursos, '-- Sin curso / General --');

      if (catalogos.docentes && catalogos.docentes.length > 0) {
        docenteSelect.value = catalogos.docentes[0].id;
        loadDocenteSchedule(catalogos.docentes[0].id);
      }

    } catch (err) {
      App.showToast('Error cargando catálogos: ' + err.message, 'error');
    }
  }

  // Load teacher schedule
  async function loadDocenteSchedule(docenteId) {
    currentDocenteId = Number(docenteId);
    currentSlotsMap.clear();

    try {
      const data = await API.getHorarioClasesDocente(currentDocenteId);
      data.forEach(item => {
        const key = `${item.diaSemana}_${item.franjaHorariaId}`;
        currentSlotsMap.set(key, item);
      });
      renderMatrix();
    } catch (err) {
      App.showToast('Error cargando horario del docente: ' + err.message, 'error');
    }
  }

  function getFranjaByEtiqueta(et) {
    return (catalogos.franjasHorarias || []).find(f => f.etiqueta.trim() === et.trim());
  }

  function renderMatrix() {
    tableBody.innerHTML = '';
    let totalClasses = 0;
    let totalFree = 0;

    let rowsConfig = [];

    if (currentSeccion === 'ESCUELA') {
      rowsConfig = [
        { tipo: 'clase', etiqueta: '07h10 - 07h50', titulo: '1° Hora (07h10 - 07h50)' },
        { tipo: 'clase', etiqueta: '07h50 - 08h30', titulo: '2° Hora (07h50 - 08h30)' },
        { tipo: 'clase', etiqueta: '08h30 - 09h10', titulo: '3° Hora (08h30 - 09h10)' },
        { tipo: 'clase', etiqueta: '09h10 - 09h50', titulo: '4° Hora (09h10 - 09h50)' },
        { tipo: 'recreo', titulo: '☕ RECREO ESCUELA (09h50 - 10h20 | 30 min)' },
        { tipo: 'clase', etiqueta: '10h20 - 11h00', titulo: '5° Hora Escuela (10h20 - 11h00)' },
        { tipo: 'clase', etiqueta: '11h00 - 11h40', titulo: '6° Hora (11h00 - 11h40)' },
        { tipo: 'clase', etiqueta: '11h40 - 12h20', titulo: '7° Hora (11h40 - 12h20)' },
        { tipo: 'clase', etiqueta: '12h20 - 13h00', titulo: '8° Hora (12h20 - 13h00 / Salida Escuela)' }
      ];
    } else if (currentSeccion === 'COLEGIO') {
      rowsConfig = [
        { tipo: 'clase', etiqueta: '07h10 - 07h50', titulo: '1° Hora (07h10 - 07h50)' },
        { tipo: 'clase', etiqueta: '07h50 - 08h30', titulo: '2° Hora (07h50 - 08h30)' },
        { tipo: 'clase', etiqueta: '08h30 - 09h10', titulo: '3° Hora (08h30 - 09h10)' },
        { tipo: 'clase', etiqueta: '09h10 - 09h50', titulo: '4° Hora (09h10 - 09h50)' },
        { tipo: 'clase', etiqueta: '09h50 - 10h30', titulo: '5° Hora Colegio (09h50 - 10h30)' },
        { tipo: 'recreo', titulo: '☕ RECREO COLEGIO (10h30 - 11h00 | 30 min)' },
        { tipo: 'clase', etiqueta: '11h00 - 11h40', titulo: '6° Hora (11h00 - 11h40)' },
        { tipo: 'clase', etiqueta: '11h40 - 12h20', titulo: '7° Hora (11h40 - 12h20)' },
        { tipo: 'clase', etiqueta: '12h20 - 13h00', titulo: '8° Hora (12h20 - 13h00)' },
        { tipo: 'clase', etiqueta: '13h00 - 13h40', titulo: '9° Hora (13h00 - 13h40)' },
        { tipo: 'clase', etiqueta: '13h40 - 14h20', titulo: '10° Hora (13h40 - 14h20 / Salida Colegio)' }
      ];
    } else {
      // TODAS (Vista Combinada completa hasta las 14h20)
      rowsConfig = [
        { tipo: 'clase', etiqueta: '07h10 - 07h50', titulo: '1° Hora (07h10 - 07h50)' },
        { tipo: 'clase', etiqueta: '07h50 - 08h30', titulo: '2° Hora (07h50 - 08h30)' },
        { tipo: 'clase', etiqueta: '08h30 - 09h10', titulo: '3° Hora (08h30 - 09h10)' },
        { tipo: 'clase', etiqueta: '09h10 - 09h50', titulo: '4° Hora (09h10 - 09h50)' },
        { tipo: 'clase', etiqueta: '09h50 - 10h30', titulo: '5° Hora Col (09h50 - 10h30)' },
        { tipo: 'clase', etiqueta: '10h20 - 11h00', titulo: '5° Hora Esc (10h20 - 11h00)' },
        { tipo: 'clase', etiqueta: '11h00 - 11h40', titulo: '6° Hora (11h00 - 11h40)' },
        { tipo: 'clase', etiqueta: '11h40 - 12h20', titulo: '7° Hora (11h40 - 12h20)' },
        { tipo: 'clase', etiqueta: '12h20 - 13h00', titulo: '8° Hora (12h20 - 13h00)' },
        { tipo: 'clase', etiqueta: '13h00 - 13h40', titulo: '9° Hora Col (13h00 - 13h40)' },
        { tipo: 'clase', etiqueta: '13h40 - 14h20', titulo: '10° Hora (13h40 - 14h20 / Salida)' }
      ];
    }

    rowsConfig.forEach(row => {
      const tr = document.createElement('tr');

      if (row.tipo === 'recreo') {
        tr.style.backgroundColor = '#fffbeb';
        tr.innerHTML = `
          <td colspan="6" style="text-align: center; font-weight: 700; color: #b45309; padding: 6px 12px; font-size: 11.5px; border-top: 1px dashed #fcd34d; border-bottom: 1px dashed #fcd34d;">
            ${row.titulo}
          </td>
        `;
        tableBody.appendChild(tr);
        return;
      }

      const franjaObj = getFranjaByEtiqueta(row.etiqueta);
      if (!franjaObj) return;

      const tdPeriodo = document.createElement('td');
      const numText = row.titulo.includes('(') ? row.titulo.split('(')[0].trim() : row.titulo;
      tdPeriodo.innerHTML = `
        <div class="badge-franja-card">
          <div class="franja-hora-num">${numText}</div>
          <div class="franja-hora-time">${row.etiqueta}</div>
        </div>
      `;
      tr.appendChild(tdPeriodo);

      DIAS_SEMANA.forEach(dia => {
        const td = document.createElement('td');
        td.style.textAlign = 'center';
        td.style.padding = '4px';

        const slotKey = `${dia}_${franjaObj.id}`;
        const slotData = currentSlotsMap.get(slotKey);

        const cell = document.createElement('div');
        cell.className = 'slot-cell';
        cell.dataset.dia = dia;
        cell.dataset.franjaId = franjaObj.id;
        cell.dataset.slotKey = slotKey;

        if (slotData) {
          const mat = slotData.materiaNombre || slotData.actividad || (slotData.esClase ? 'Ocupado' : 'Disponible');
          const cur = slotData.cursoNombre ? `<div class="slot-sub" title="${slotData.cursoNombre}">${slotData.cursoNombre}</div>` : '';

          if (slotData.esClase) {
            totalClasses++;
            cell.classList.add('is-class');
            cell.innerHTML = `
              <div class="slot-header-content">
                <div class="slot-title" title="${mat}">${mat}</div>
                ${cur}
              </div>
              <span class="slot-badge-class"><i class="fa-solid fa-lock" style="margin-right:3px;"></i>OCUPADO</span>
            `;
          } else {
            totalFree++;
            cell.classList.add('is-free');
            cell.innerHTML = `
              <div class="slot-header-content">
                <div class="slot-title" title="${mat}">${mat}</div>
                ${cur}
              </div>
              <span class="slot-badge-free"><i class="fa-solid fa-check" style="margin-right:3px;"></i>DISPONIBLE</span>
            `;
          }
        } else {
          cell.classList.add('is-busy');
          cell.innerHTML = `
            <div class="slot-header-content">
              <div class="slot-sub" style="color: #94a3b8;">-- Sin asignar --</div>
            </div>
          `;
        }

        cell.addEventListener('click', () => openEditModal(slotKey, dia, franjaObj));
        td.appendChild(cell);
        tr.appendChild(td);
      });

      tableBody.appendChild(tr);
    });

    slotsCountBadge.textContent = `${totalClasses} horas ocupadas | ${totalFree} horas disponibles`;
  }

  // Open edit modal for a slot
  function openEditModal(slotKey, dia, franjaObj) {
    editingSlotKey = slotKey;
    const existing = currentSlotsMap.get(slotKey) || {};

    modalTitle.textContent = `Editar Horario: ${dia} (${franjaObj.etiqueta})`;

    // Set radio
    const isOcupado = existing.esClase !== undefined ? existing.esClase : true;
    modalTipoRadios.forEach(r => r.checked = (r.value === 'ocupado' && isOcupado) || (r.value === 'disponible' && !isOcupado));

    modalMateria.value = existing.materiaId || '';
    modalCurso.value = existing.cursoId || '';

    // Si ya tiene materia elegida y la actividad coincide con el nombre de la materia, no duplicar en el campo de texto
    if (existing.materiaId && existing.materiaNombre && existing.actividad && existing.actividad.toUpperCase() === existing.materiaNombre.toUpperCase()) {
      modalActividad.value = '';
    } else {
      modalActividad.value = existing.actividad || '';
    }

    modal.style.display = 'flex';
  }

  // Cuando se selecciona una materia, limpiar el campo de descripción/actividad
  modalMateria.addEventListener('change', () => {
    if (modalMateria.value) {
      modalActividad.value = '';
    }
  });

  function closeModal() {
    modal.style.display = 'none';
    editingSlotKey = null;
  }

  btnCloseModal.addEventListener('click', closeModal);
  btnCancelModal.addEventListener('click', closeModal);

  // Apply changes from modal & Auto-Save
  btnApplyModal.addEventListener('click', async () => {
    if (!editingSlotKey) return;

    const [dia, franjaIdStr] = editingSlotKey.split('_');
    const franjaId = Number(franjaIdStr);
    const tipo = document.querySelector('input[name="modal-tipo"]:checked')?.value || 'ocupado';
    const esClase = tipo === 'ocupado';

    const materiaId = modalMateria.value ? Number(modalMateria.value) : null;
    const materiaObj = catalogos.materias.find(m => m.id === materiaId);

    const cursoId = modalCurso.value ? Number(modalCurso.value) : null;
    const cursoObj = catalogos.cursos.find(c => c.id === cursoId);

    let actividad = modalActividad.value.trim();
    if (materiaObj && actividad.toUpperCase() === materiaObj.nombre.toUpperCase()) {
      actividad = '';
    }

    const slotObj = {
      diaSemana: dia,
      franjaHorariaId: franjaId,
      docenteId: currentDocenteId,
      cursoId: cursoId,
      cursoNombre: cursoObj ? cursoObj.nombre : null,
      materiaId: materiaId,
      materiaNombre: materiaObj ? materiaObj.nombre : null,
      actividad: actividad || (materiaObj ? materiaObj.nombre : (esClase ? 'Ocupado' : 'Disponible')),
      esClase: esClase
    };
    currentSlotsMap.set(editingSlotKey, slotObj);

    closeModal();
    renderMatrix();
    await autoSaveSchedule();
  });

  // Función de Autoguardado Instantáneo
  async function autoSaveSchedule() {
    if (!currentDocenteId) return;
    const indicator = document.getElementById('autosave-indicator');
    if (indicator) {
      indicator.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Guardando...';
      indicator.style.color = '#2563eb';
      indicator.style.background = '#eff6ff';
      indicator.style.borderColor = '#bfdbfe';
    }

    try {
      const slotsList = Array.from(currentSlotsMap.values());
      await API.guardarHorarioClasesDocente({
        docenteId: currentDocenteId,
        slots: slotsList
      });
      if (indicator) {
        indicator.innerHTML = '<i class="fa-solid fa-circle-check"></i> Guardado automáticamente';
        indicator.style.color = '#16a34a';
        indicator.style.background = '#f0fdf4';
        indicator.style.borderColor = '#bbf7d0';
      }
    } catch (err) {
      if (indicator) {
        indicator.innerHTML = '<i class="fa-solid fa-triangle-exclamation"></i> Error al autoguardar';
        indicator.style.color = '#dc2626';
        indicator.style.background = '#fef2f2';
        indicator.style.borderColor = '#fecaca';
      }
      App.showToast('Error al autoguardar: ' + err.message, 'error');
    }
  }

  // Marcar todas disponibles & Auto-Save
  btnMarcarTodos.addEventListener('click', async () => {
    if (confirm('¿Desea marcar todos los periodos visibles como horas DISPONIBLES (libres para reemplazo)?')) {
      catalogos.franjasHorarias.forEach(f => {
        DIAS_SEMANA.forEach(dia => {
          const key = `${dia}_${f.id}`;
          currentSlotsMap.set(key, {
            diaSemana: dia,
            franjaHorariaId: f.id,
            docenteId: currentDocenteId,
            cursoId: null,
            materiaId: null,
            actividad: 'Disponible',
            esClase: false
          });
        });
      });
      renderMatrix();
      await autoSaveSchedule();
    }
  });

  // Reset all schedules for new school year
  btnResetAll.addEventListener('click', async () => {
    if (confirm('⚠️ ATENCIÓN: ¿Está seguro de que desea reiniciar la malla de disponibilidad de todos los profesores para el nuevo año lectivo?')) {
      try {
        await API.limpiarTodosLosHorarios();
        App.showToast('Malla de disponibilidad reiniciada para el nuevo año lectivo.', 'success');
        if (currentDocenteId) loadDocenteSchedule(currentDocenteId);
      } catch (err) {
        App.showToast('Error al reiniciar disponibilidad: ' + err.message, 'error');
      }
    }
  });

  docenteSelect.addEventListener('change', (e) => {
    if (e.target.value) loadDocenteSchedule(e.target.value);
  });

  // Section Filter Tabs
  seccionTabs.forEach(tab => {
    tab.addEventListener('click', () => {
      seccionTabs.forEach(t => t.className = 'btn btn-secondary btn-sm seccion-tab');
      tab.className = 'btn btn-primary btn-sm seccion-tab';
      currentSeccion = tab.dataset.seccion;
      renderMatrix();
    });
  });

  // Init
  init();
});
