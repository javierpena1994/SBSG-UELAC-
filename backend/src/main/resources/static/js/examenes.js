/* ==========================================================
   SISTEMA DE GENERACIÓN DE HORARIOS DE EXÁMENES SBSG
   ========================================================== */

document.addEventListener('DOMContentLoaded', async () => {
  const sectionGenerador = document.getElementById('section-generador');
  const sectionHistorial = document.getElementById('section-historial');
  const sectionCursosMaterias = document.getElementById('section-cursos-materias');

  // Generator Elements
  const selectCurso = document.getElementById('select-curso');
  const inputTitulo = document.getElementById('input-titulo');
  const inputFechaInicio = document.getElementById('input-fecha-inicio');
  const selectNumDias = document.getElementById('select-num-dias');
  const selectMateriasDia = document.getElementById('select-materias-dia');
  const checkSaltarFds = document.getElementById('check-saltar-fds');

  const subjectsContainer = document.getElementById('subjects-config-container');
  const badgeCountComplejas = document.getElementById('badge-count-complejas');
  const badgeCountNoComplejas = document.getElementById('badge-count-nocomplejas');
  const btnAddSubjectModal = document.getElementById('btn-add-subject-modal');
  const btnGenerarSorteo = document.getElementById('btn-generar-sorteo');

  const generatedCard = document.getElementById('generated-schedule-card');
  const generatedTbody = document.getElementById('generated-schedule-tbody');
  const printCursoNombre = document.getElementById('print-curso-nombre');
  const printTitulo = document.getElementById('print-titulo');
  const printRangoFechas = document.getElementById('print-rango-fechas');

  const btnReSortear = document.getElementById('btn-re-sortear');
  const btnGuardarHorario = document.getElementById('btn-guardar-horario');
  const btnImprimirHorario = document.getElementById('btn-imprimir-horario');

  // Historial Elements
  const historialTbody = document.getElementById('historial-examenes-tbody');
  const btnRecargarHistorial = document.getElementById('btn-recargar-historial');

  // Cursos / Materias Elements
  const configSelectCurso = document.getElementById('config-select-curso');
  const configMateriasTbody = document.getElementById('config-materias-curso-tbody');
  const btnAsignarMateriaModal = document.getElementById('btn-asignar-materia-modal');
  const btnGuardarAsignacionCurso = document.getElementById('btn-guardar-asignacion-curso');

  const listaCursosTbody = document.getElementById('lista-cursos-tbody');
  const btnNuevoCurso = document.getElementById('btn-nuevo-curso');
  const listaMateriasTbody = document.getElementById('lista-materias-tbody');
  const btnNuevaMateria = document.getElementById('btn-nueva-materia');

  // Modal Asignar Materia
  const modalAsignar = document.getElementById('modal-asignar-materia');
  const modalAsignarTitle = document.getElementById('modal-asignar-title');
  const formAsignar = document.getElementById('form-asignar-materia');
  const selectMateriaCatalogo = document.getElementById('select-materia-catalogo');
  const selectComplejidadAsignar = document.getElementById('select-complejidad-asignar');
  const btnCerrarModalAsignar = document.getElementById('btn-cerrar-modal-asignar');
  const btnCancelarModalAsignar = document.getElementById('btn-cancelar-modal-asignar');

  // State
  let cursosList = [];
  let materiasList = [];
  let currentMateriasEvalList = [];
  let currentConfigCursoMaterias = [];
  let currentGeneratedSchedule = null;
  let targetModalMode = 'GENERADOR'; // 'GENERADOR' | 'CONFIG_CURSO'

  // Set default initial date to next Monday
  const today = new Date();
  const daysUntilNextMon = ((1 + 7 - today.getDay()) % 7) || 7;
  const nextMonday = new Date(today);
  nextMonday.setDate(today.getDate() + daysUntilNextMon);
  inputFechaInicio.value = nextMonday.toISOString().split('T')[0];

  // Initialize Data
  async function init() {
    await loadGlobalCatalogs();
    setupEventListeners();
    handleHashNavigation();
  }

  async function loadGlobalCatalogs() {
    try {
      const [cursos, materias] = await Promise.all([
        API.getCursos(),
        API.getMaterias()
      ]);
      cursosList = cursos || [];
      materiasList = materias || [];

      // Populate Course Selectors
      App.populateCursoSelect(selectCurso, cursosList);
      App.populateCursoSelect(configSelectCurso, cursosList);

      // Populate Subject Modal Selector
      populateMateriasCatalogoSelect();

      // Render Cursos and Materias Management Tables
      renderCursosTable();
      renderMateriasTable();
    } catch (err) {
      console.error('Error cargando catálogos:', err);
      App.showToast('Error al conectar con la base de datos: ' + err.message, 'error');
    }
  }

  function populateMateriasCatalogoSelect() {
    selectMateriaCatalogo.innerHTML = '<option value="">Seleccione una materia...</option>';
    materiasList.forEach(m => {
      const opt = document.createElement('option');
      opt.value = m.id;
      opt.textContent = m.nombre;
      selectMateriaCatalogo.appendChild(opt);
    });
  }

  // Handle Hash and View Navigation
  function switchView(viewName) {
    sectionGenerador.style.display = 'none';
    sectionHistorial.style.display = 'none';
    sectionCursosMaterias.style.display = 'none';

    if (viewName === 'historial') {
      sectionHistorial.style.display = 'block';
      loadHistorial();
    } else if (viewName === 'cursos-materias') {
      sectionCursosMaterias.style.display = 'block';
      if (configSelectCurso.value) {
        loadMateriasForConfigCurso(configSelectCurso.value);
      }
    } else {
      sectionGenerador.style.display = 'block';
    }
  }

  function handleHashNavigation() {
    const hash = window.location.hash;
    if (hash === '#historial') {
      switchView('historial');
    } else if (hash === '#cursos-materias') {
      switchView('cursos-materias');
    } else {
      switchView('generador');
    }
  }

  window.addEventListener('hashchange', handleHashNavigation);

  function setupEventListeners() {

    // Generator Course Change
    selectCurso.addEventListener('change', async () => {
      const cursoId = selectCurso.value;
      if (!cursoId) {
        subjectsContainer.innerHTML = `
          <div style="text-align: center; padding: 24px; color: var(--text-muted);">
            <i class="fa-solid fa-hand-pointer" style="margin-right:6px;"></i> Seleccione un curso arriba para cargar sus materias automáticas.
          </div>
        `;
        currentMateriasEvalList = [];
        updateComplexityCounters();
        return;
      }

      subjectsContainer.innerHTML = `
        <div style="text-align:center; padding: 24px; color: var(--text-muted);">
          <i class="fa-solid fa-circle-notch fa-spin" style="margin-right:6px;"></i> Cargando materias asignadas al curso...
        </div>
      `;

      try {
        const materias = await API.getMateriasEvaluacionCurso(cursoId);
        currentMateriasEvalList = materias || [];
        renderSubjectsEvalList();
      } catch (err) {
        subjectsContainer.innerHTML = `
          <div style="text-align:center; padding: 20px; color: #dc2626;">
            <i class="fa-solid fa-triangle-exclamation" style="margin-right:6px;"></i> Error al cargar materias: ${err.message}
          </div>
        `;
      }
    });

    // Add Subject in Generator Mode
    btnAddSubjectModal.addEventListener('click', () => {
      targetModalMode = 'GENERADOR';
      modalAsignarTitle.textContent = 'Añadir Materia a la Evaluación';
      formAsignar.reset();
      modalAsignar.style.display = 'flex';
    });

    // Add Subject in Course Config Mode
    btnAsignarMateriaModal.addEventListener('click', () => {
      if (!configSelectCurso.value) {
        App.showToast('Por favor seleccione primero un curso en el desplegable.', 'warning');
        configSelectCurso.focus();
        return;
      }
      targetModalMode = 'CONFIG_CURSO';
      const cursoText = configSelectCurso.options[configSelectCurso.selectedIndex].text;
      modalAsignarTitle.textContent = `Asignar Materia a: ${cursoText}`;
      formAsignar.reset();
      modalAsignar.style.display = 'flex';
    });

    btnCerrarModalAsignar.addEventListener('click', () => modalAsignar.style.display = 'none');
    btnCancelarModalAsignar.addEventListener('click', () => modalAsignar.style.display = 'none');

    // Handle Assign Subject Modal Form Submit
    formAsignar.addEventListener('submit', (e) => {
      e.preventDefault();
      const materiaId = Number(selectMateriaCatalogo.value);
      const complejidad = selectComplejidadAsignar.value;
      if (!materiaId) {
        App.showToast('Seleccione una materia.', 'warning');
        return;
      }

      const materiaObj = materiasList.find(m => m.id === materiaId);
      const materiaNombre = materiaObj ? materiaObj.nombre : selectMateriaCatalogo.options[selectMateriaCatalogo.selectedIndex].text;

      if (targetModalMode === 'GENERADOR') {
        const yaExiste = currentMateriasEvalList.some(m => m.materiaId === materiaId || m.materiaNombre.toUpperCase() === materiaNombre.toUpperCase());
        if (yaExiste) {
          App.showToast('La materia ya se encuentra en la lista de evaluación.', 'warning');
          return;
        }
        currentMateriasEvalList.push({
          id: null,
          materiaId: materiaId,
          materiaNombre: materiaNombre,
          tipoComplejidad: complejidad,
          seleccionada: true,
          docenteNombre: ''
        });
        renderSubjectsEvalList();
        App.showToast(`Materia '${materiaNombre}' agregada a la evaluación.`, 'success');
      } else {
        // CONFIG_CURSO Mode
        const yaExiste = currentConfigCursoMaterias.some(m => m.materiaId === materiaId || m.materiaNombre.toUpperCase() === materiaNombre.toUpperCase());
        if (yaExiste) {
          App.showToast('Esta materia ya está asignada al curso seleccionado.', 'warning');
          return;
        }
        currentConfigCursoMaterias.push({
          id: null,
          materiaId: materiaId,
          materiaNombre: materiaNombre,
          tipoComplejidad: complejidad,
          seleccionada: true
        });
        renderConfigCursoMateriasTable();
        App.showToast(`Materia '${materiaNombre}' asignada al curso. Recuerda presionar 'Guardar Cambios'.`, 'info');
      }

      modalAsignar.style.display = 'none';
    });

    // Generate Sorteo
    btnGenerarSorteo.addEventListener('click', () => ejecutarSorteo(false));
    btnReSortear.addEventListener('click', () => ejecutarSorteo(true));

    // Save Schedule
    btnGuardarHorario.addEventListener('click', handleGuardarHorario);
    btnImprimirHorario.addEventListener('click', () => window.print());

    // Historial Reload
    btnRecargarHistorial.addEventListener('click', loadHistorial);

    // Course Config Selection Change
    configSelectCurso.addEventListener('change', () => {
      const cursoId = configSelectCurso.value;
      if (cursoId) {
        loadMateriasForConfigCurso(cursoId);
      } else {
        configMateriasTbody.innerHTML = `
          <tr>
            <td colspan="3" style="text-align:center; padding: 24px; color: var(--text-muted);">
              <i class="fa-solid fa-hand-pointer" style="margin-right:6px;"></i> Seleccione un curso arriba para ver y configurar sus materias asignadas.
            </td>
          </tr>
        `;
        currentConfigCursoMaterias = [];
      }
    });

    // Save Course-Subject Assignments
    btnGuardarAsignacionCurso.addEventListener('click', async () => {
      const cursoId = configSelectCurso.value;
      if (!cursoId) {
        App.showToast('Seleccione un curso para guardar su asignación.', 'warning');
        return;
      }
      try {
        btnGuardarAsignacionCurso.disabled = true;
        btnGuardarAsignacionCurso.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Guardando...';

        await API.guardarMateriasCurso(cursoId, currentConfigCursoMaterias);
        App.showToast('✅ Asignación de materias y dificultad guardada exitosamente.', 'success');
      } catch (err) {
        App.showToast('Error al guardar asignación: ' + err.message, 'error');
      } finally {
        btnGuardarAsignacionCurso.disabled = false;
        btnGuardarAsignacionCurso.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar Cambios';
      }
    });

    // Create New Course
    btnNuevoCurso.addEventListener('click', async () => {
      const nombre = prompt('Ingrese el nombre del nuevo curso (ej: INICIAL 1, 1° BGU "B", 4° EGB):');
      if (!nombre || !nombre.trim()) return;

      try {
        await API.crearCurso({ nombre: nombre.trim() });
        App.showToast(`Curso '${nombre.trim().toUpperCase()}' creado correctamente.`, 'success');
        await loadGlobalCatalogs();
      } catch (err) {
        App.showToast('Error al crear curso: ' + err.message, 'error');
      }
    });

    // Create New Materia
    btnNuevaMateria.addEventListener('click', async () => {
      const nombre = prompt('Ingrese el nombre de la nueva materia (ej: ROBÓTICA, FILOSOFÍA):');
      if (!nombre || !nombre.trim()) return;

      try {
        await API.crearMateria({ nombre: nombre.trim() });
        App.showToast(`Materia '${nombre.trim().toUpperCase()}' creada en el catálogo global.`, 'success');
        await loadGlobalCatalogs();
      } catch (err) {
        App.showToast('Error al crear materia: ' + err.message, 'error');
      }
    });
  }

  // ==========================================================
  // VISTA 1: GENERADOR & EVALUACIÓN
  // ==========================================================
  function renderSubjectsEvalList() {
    if (!currentMateriasEvalList || currentMateriasEvalList.length === 0) {
      subjectsContainer.innerHTML = `
        <div style="text-align: center; padding: 24px; color: var(--text-muted);">
          No hay materias asignadas para este curso. Puedes asignarlas en la pestaña <strong>'3. Cursos / Materias'</strong> o agregarlas con el botón '+ Añadir Materia'.
        </div>
      `;
      updateComplexityCounters();
      return;
    }

    subjectsContainer.innerHTML = '';
    currentMateriasEvalList.forEach((m, index) => {
      const row = document.createElement('div');
      row.className = 'subject-config-row';

      const isCompleja = m.tipoComplejidad === 'COMPLEJA';
      const toggleClass = isCompleja ? 'is-compleja' : 'is-nocompleja';
      const toggleIcon = isCompleja ? '<i class="fa-solid fa-brain" style="color:#b91c1c;"></i>' : '<i class="fa-solid fa-feather" style="color:#16a34a;"></i>';
      const toggleText = isCompleja ? '🔴 COMPLEJA' : '🟢 MENOS COMPLEJA';

      row.innerHTML = `
        <div style="display: flex; align-items: center; gap: 12px; flex: 1;">
          <input type="checkbox" id="chk-materia-${index}" class="chk-materia" data-index="${index}" ${m.seleccionada !== false ? 'checked' : ''} style="width: 17px; height: 17px; cursor: pointer;">
          <label for="chk-materia-${index}" style="font-size: 13.5px; font-weight: 600; cursor: pointer; color: var(--text-main); margin: 0;">
            ${m.materiaNombre}
          </label>
          ${m.docenteNombre ? `<span style="font-size: 11.5px; color: var(--text-muted); font-style: italic;">(${m.docenteNombre})</span>` : ''}
        </div>
        <div style="display: flex; align-items: center; gap: 10px;">
          <button type="button" class="complexity-toggle-btn ${toggleClass}" data-index="${index}" title="Haz clic para alternar complejidad">
            ${toggleIcon} <span>${toggleText}</span>
          </button>
          <button type="button" class="btn btn-secondary btn-sm btn-remove-eval-subject" data-index="${index}" style="padding: 4px 8px; color: #dc2626;" title="Quitar materia de este sorteo">
            <i class="fa-solid fa-trash-can"></i>
          </button>
        </div>
      `;

      // Checkbox event
      row.querySelector('.chk-materia').addEventListener('change', (e) => {
        currentMateriasEvalList[index].seleccionada = e.target.checked;
        updateComplexityCounters();
      });

      // Toggle Complexity event
      row.querySelector('.complexity-toggle-btn').addEventListener('click', () => {
        currentMateriasEvalList[index].tipoComplejidad = currentMateriasEvalList[index].tipoComplejidad === 'COMPLEJA' ? 'NO_COMPLEJA' : 'COMPLEJA';
        renderSubjectsEvalList();
      });

      // Remove event
      row.querySelector('.btn-remove-eval-subject').addEventListener('click', () => {
        currentMateriasEvalList.splice(index, 1);
        renderSubjectsEvalList();
      });

      subjectsContainer.appendChild(row);
    });

    updateComplexityCounters();
  }

  function updateComplexityCounters() {
    const activas = currentMateriasEvalList.filter(m => m.seleccionada !== false);
    const complejas = activas.filter(m => m.tipoComplejidad === 'COMPLEJA').length;
    const noComplejas = activas.filter(m => m.tipoComplejidad !== 'COMPLEJA').length;

    badgeCountComplejas.textContent = `${complejas} Complejas`;
    badgeCountNoComplejas.textContent = `${noComplejas} Menos Complejas`;
  }

  async function ejecutarSorteo(esReintento = false) {
    if (!selectCurso.value) {
      App.showToast('Por favor seleccione un curso.', 'warning');
      selectCurso.focus();
      return;
    }
    if (!inputFechaInicio.value) {
      App.showToast('Por favor seleccione la fecha de inicio.', 'warning');
      inputFechaInicio.focus();
      return;
    }

    const materiasSeleccionadas = currentMateriasEvalList.filter(m => m.seleccionada !== false);
    if (materiasSeleccionadas.length === 0) {
      App.showToast('Debe tener al menos una materia seleccionada para sortear.', 'warning');
      return;
    }

    const payload = {
      cursoId: Number(selectCurso.value),
      titulo: inputTitulo.value.trim() || 'Exámenes Institucionales',
      fechaInicio: inputFechaInicio.value,
      numDias: Number(selectNumDias.value),
      materiasPorDia: Number(selectMateriasDia.value),
      saltarFinesDeSemana: checkSaltarFds.checked,
      materias: materiasSeleccionadas
    };

    try {
      btnGenerarSorteo.disabled = true;
      btnGenerarSorteo.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Realizando Sorteo...';

      const data = await API.generarSorteoExamen(payload);
      currentGeneratedSchedule = data;

      renderGeneratedScheduleTable(data);
      generatedCard.style.display = 'block';
      generatedCard.scrollIntoView({ behavior: 'smooth', block: 'start' });

      if (esReintento) {
        App.showToast('🎲 ¡Nueva combinación aleatoria y balanceada generada!', 'info');
      } else {
        App.showToast('✅ Sorteo aleatorio generado con éxito.', 'success');
      }
    } catch (err) {
      App.showToast('Error al generar sorteo: ' + err.message, 'error');
    } finally {
      btnGenerarSorteo.disabled = false;
      btnGenerarSorteo.innerHTML = '<i class="fa-solid fa-dice" style="font-size:16px;"></i> Generar Sorteo Aleatorio de Horario';
    }
  }

  function renderGeneratedScheduleTable(horario) {
    printCursoNombre.textContent = horario.cursoNombre || '-';
    printTitulo.textContent = horario.titulo || '-';
    printRangoFechas.textContent = `Del ${App.formatDateDisplay(horario.fechaInicio)} al ${App.formatDateDisplay(horario.fechaFin)} (${horario.numDias} Días)`;

    generatedTbody.innerHTML = '';

    const byDay = {};
    (horario.detalles || []).forEach(d => {
      if (!byDay[d.diaNumero]) {
        byDay[d.diaNumero] = {
          diaNumero: d.diaNumero,
          fecha: d.fecha,
          diaSemana: d.diaSemana,
          slot1: null,
          slot2: null,
          extra: []
        };
      }
      if (d.ordenDia === 1 && !byDay[d.diaNumero].slot1) {
        byDay[d.diaNumero].slot1 = d;
      } else if (d.ordenDia === 2 && !byDay[d.diaNumero].slot2) {
        byDay[d.diaNumero].slot2 = d;
      } else {
        byDay[d.diaNumero].extra.push(d);
      }
    });

    Object.values(byDay).sort((a,b) => a.diaNumero - b.diaNumero).forEach(dayObj => {
      const tr = document.createElement('tr');

      const formatSlotHtml = (slot) => {
        if (!slot) return '<div style="color:#94a3b8; font-size:12px;">-- Libre / Estudio --</div>';
        const isComp = slot.tipoComplejidad === 'COMPLEJA';
        const badge = isComp
          ? '<span class="exam-badge-compleja"><i class="fa-solid fa-brain"></i> Compleja</span>'
          : '<span class="exam-badge-nocompleja"><i class="fa-solid fa-feather"></i> Menos Compleja</span>';

        return `
          <div style="font-weight:700; font-size:13.5px; color:var(--primary); margin-bottom:3px;">
            ${slot.materiaNombre}
          </div>
          <div>${badge}</div>
        `;
      };

      const s1 = formatSlotHtml(dayObj.slot1);
      const s2 = formatSlotHtml(dayObj.slot2);

      let extraHtml = '';
      if (dayObj.extra && dayObj.extra.length > 0) {
        extraHtml = '<div style="margin-top:6px; padding-top:6px; border-top:1px dashed var(--border); font-size:11.5px;">' +
          dayObj.extra.map(e => `<strong>Extra:</strong> ${e.materiaNombre}`).join(', ') + '</div>';
      }

      tr.innerHTML = `
        <td style="text-align:center; font-weight:700; background:#f8fafc;">
          <div style="color:var(--primary); font-size:13px;">DÍA ${dayObj.diaNumero}</div>
          <div style="font-size:11.5px; color:#64748b;">${dayObj.diaSemana || ''}</div>
          <div style="font-size:11.5px; color:#64748b;">${App.formatDateDisplay(dayObj.fecha)}</div>
        </td>
        <td style="text-align:center; padding:12px 14px;">${s1}</td>
        <td style="text-align:center; padding:12px 14px;">${s2} ${extraHtml}</td>
        <td style="text-align:center; color:#64748b; font-size:12px;">
          <div style="border-bottom:1px dotted #94a3b8; height:24px; margin-bottom:4px;"></div>
          <span>Firma del Docente</span>
        </td>
      `;

      generatedTbody.appendChild(tr);
    });
  }

  async function handleGuardarHorario() {
    if (!currentGeneratedSchedule) return;
    try {
      btnGuardarHorario.disabled = true;
      btnGuardarHorario.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Guardando...';

      const guardado = await API.guardarHorarioExamen(currentGeneratedSchedule);
      currentGeneratedSchedule.id = guardado.id;

      App.showToast('✅ Horario de exámenes guardado con éxito en el historial.', 'success');
    } catch (err) {
      App.showToast('Error al guardar horario: ' + err.message, 'error');
    } finally {
      btnGuardarHorario.disabled = false;
      btnGuardarHorario.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar en Historial';
    }
  }

  // ==========================================================
  // VISTA 2: HISTORIAL Y REPORTES
  // ==========================================================
  async function loadHistorial() {
    historialTbody.innerHTML = `
      <tr>
        <td colspan="6" style="text-align:center; padding:24px; color:var(--text-muted);">
          <i class="fa-solid fa-circle-notch fa-spin" style="margin-right:6px;"></i> Cargando historial de horarios...
        </td>
      </tr>
    `;

    try {
      const list = await API.getHistorialHorariosExamen();
      historialTbody.innerHTML = '';

      if (!list || list.length === 0) {
        historialTbody.innerHTML = `
          <tr>
            <td colspan="6" style="text-align:center; padding:24px; color:var(--text-muted);">
              No hay horarios de exámenes guardados aún. Genera un nuevo sorteo para guardarlo aquí.
            </td>
          </tr>
        `;
        return;
      }

      list.forEach(item => {
        const tr = document.createElement('tr');
        const fCreacion = item.createdAt ? item.createdAt.substring(0, 10) : '-';

        tr.innerHTML = `
          <td style="font-size:12.5px;">${App.formatDateDisplay(fCreacion)}</td>
          <td style="font-weight:700; color:var(--primary);">${item.titulo}</td>
          <td><span class="badge" style="background:#e0e7ff; color:#3730a3;">${item.cursoNombre || 'General'}</span></td>
          <td style="text-align:center; font-weight:700;">${item.numDias} Días</td>
          <td style="font-size:12px;">${App.formatDateDisplay(item.fechaInicio)} al ${App.formatDateDisplay(item.fechaFin)}</td>
          <td style="text-align:center;">
            <div style="display:inline-flex; gap:6px;">
              <button type="button" class="btn btn-secondary btn-sm btn-ver-horario" data-id="${item.id}" style="padding:4px 10px;" title="Ver e Imprimir">
                <i class="fa-solid fa-eye" style="color:var(--primary);"></i> Ver / Imprimir
              </button>
              <button type="button" class="btn btn-secondary btn-sm btn-eliminar-horario" data-id="${item.id}" style="padding:4px 8px; color:#dc2626;" title="Eliminar">
                <i class="fa-solid fa-trash-can"></i>
              </button>
            </div>
          </td>
        `;

        tr.querySelector('.btn-ver-horario').addEventListener('click', async () => {
          try {
            const h = await API.getHorarioExamen(item.id);
            currentGeneratedSchedule = h;
            renderGeneratedScheduleTable(h);
            generatedCard.style.display = 'block';
            switchView('generador');
            generatedCard.scrollIntoView({ behavior: 'smooth' });
          } catch (err) {
            App.showToast('Error al cargar horario: ' + err.message, 'error');
          }
        });

        tr.querySelector('.btn-eliminar-horario').addEventListener('click', async () => {
          if (confirm(`¿Desea eliminar el horario "${item.titulo}"?`)) {
            try {
              await API.eliminarHorarioExamen(item.id);
              App.showToast('Horario eliminado del historial.', 'success');
              loadHistorial();
            } catch (err) {
              App.showToast('Error al eliminar: ' + err.message, 'error');
            }
          }
        });

        historialTbody.appendChild(tr);
      });
    } catch (err) {
      historialTbody.innerHTML = `
        <tr>
          <td colspan="6" style="text-align:center; padding:20px; color:#dc2626;">
            Error cargando historial: ${err.message}
          </td>
        </tr>
      `;
    }
  }

  // ==========================================================
  // VISTA 3: CURSOS Y MATERIAS (ASIGNACIÓN & DIFICULTAD)
  // ==========================================================
  async function loadMateriasForConfigCurso(cursoId) {
    configMateriasTbody.innerHTML = `
      <tr>
        <td colspan="3" style="text-align:center; padding:20px; color:var(--text-muted);">
          <i class="fa-solid fa-circle-notch fa-spin" style="margin-right:6px;"></i> Cargando materias del curso...
        </td>
      </tr>
    `;

    try {
      const materias = await API.getMateriasEvaluacionCurso(cursoId);
      currentConfigCursoMaterias = materias || [];
      renderConfigCursoMateriasTable();
    } catch (err) {
      configMateriasTbody.innerHTML = `
        <tr>
          <td colspan="3" style="text-align:center; padding:16px; color:#dc2626;">
            Error cargando materias: ${err.message}
          </td>
        </tr>
      `;
    }
  }

  function renderConfigCursoMateriasTable() {
    configMateriasTbody.innerHTML = '';
    if (!currentConfigCursoMaterias || currentConfigCursoMaterias.length === 0) {
      configMateriasTbody.innerHTML = `
        <tr>
          <td colspan="3" style="text-align:center; padding:20px; color:var(--text-muted);">
            No hay materias asignadas a este curso aún. Haz clic en <strong>'+ Asignar Materia a este Curso'</strong> para agregar.
          </td>
        </tr>
      `;
      return;
    }

    currentConfigCursoMaterias.forEach((m, index) => {
      const tr = document.createElement('tr');

      const isCompleja = m.tipoComplejidad === 'COMPLEJA';
      const toggleClass = isCompleja ? 'is-compleja' : 'is-nocompleja';
      const toggleIcon = isCompleja ? '<i class="fa-solid fa-brain" style="color:#b91c1c;"></i>' : '<i class="fa-solid fa-feather" style="color:#16a34a;"></i>';
      const toggleText = isCompleja ? '🔴 COMPLEJA' : '🟢 MENOS COMPLEJA';

      tr.innerHTML = `
        <td style="font-weight:700; color:var(--primary); font-size:13.5px;">
          ${m.materiaNombre}
        </td>
        <td style="text-align:center;">
          <button type="button" class="complexity-toggle-btn ${toggleClass}" data-index="${index}" title="Haz clic para cambiar entre Compleja y Menos Compleja">
            ${toggleIcon} <span>${toggleText}</span>
          </button>
        </td>
        <td style="text-align:center;">
          <button type="button" class="btn btn-secondary btn-sm btn-del-config-mat" data-index="${index}" style="padding:4px 8px; color:#dc2626;" title="Desasignar materia de este curso">
            <i class="fa-solid fa-trash-can"></i>
          </button>
        </td>
      `;

      // Toggle Complexity
      tr.querySelector('.complexity-toggle-btn').addEventListener('click', () => {
        currentConfigCursoMaterias[index].tipoComplejidad = isCompleja ? 'NO_COMPLEJA' : 'COMPLEJA';
        renderConfigCursoMateriasTable();
      });

      // Remove from course
      tr.querySelector('.btn-del-config-mat').addEventListener('click', () => {
        currentConfigCursoMaterias.splice(index, 1);
        renderConfigCursoMateriasTable();
      });

      configMateriasTbody.appendChild(tr);
    });
  }

  // Render Global Cursos Table
  function renderCursosTable() {
    listaCursosTbody.innerHTML = '';
    if (!cursosList || cursosList.length === 0) {
      listaCursosTbody.innerHTML = '<tr><td colspan="3" style="text-align:center; padding:12px;">No hay cursos registrados.</td></tr>';
      return;
    }

    cursosList.forEach(c => {
      const tr = document.createElement('tr');
      tr.innerHTML = `
        <td style="font-weight:600; font-size:13px; color:var(--primary);">${c.nombre}</td>
        <td><span class="badge" style="background:#e0e7ff; color:#3730a3; font-size:11px;">${c.nivel || 'SUPERIOR'}</span></td>
        <td style="text-align:center;">
          <button type="button" class="btn btn-secondary btn-sm btn-eliminar-curso" data-id="${c.id}" style="padding:3px 6px; color:#dc2626;" title="Eliminar curso">
            <i class="fa-solid fa-trash-can"></i>
          </button>
        </td>
      `;

      tr.querySelector('.btn-eliminar-curso').addEventListener('click', async () => {
        if (confirm(`¿Eliminar el curso "${c.nombre}"? Esto también lo eliminará del módulo de Contingencias.`)) {
          try {
            await API.eliminarCurso(c.id);
            App.showToast(`Curso '${c.nombre}' eliminado.`, 'success');
            await loadGlobalCatalogs();
          } catch (err) {
            App.showToast('Error al eliminar curso: ' + err.message, 'error');
          }
        }
      });

      listaCursosTbody.appendChild(tr);
    });
  }

  // Render Global Materias Table
  function renderMateriasTable() {
    listaMateriasTbody.innerHTML = '';
    if (!materiasList || materiasList.length === 0) {
      listaMateriasTbody.innerHTML = '<tr><td colspan="2" style="text-align:center; padding:12px;">No hay materias registradas.</td></tr>';
      return;
    }

    materiasList.forEach(m => {
      const tr = document.createElement('tr');
      tr.innerHTML = `
        <td style="font-weight:600; font-size:13px; color:var(--primary);">${m.nombre}</td>
        <td style="text-align:center;">
          <button type="button" class="btn btn-secondary btn-sm btn-eliminar-materia" data-id="${m.id}" style="padding:3px 6px; color:#dc2626;" title="Eliminar materia">
            <i class="fa-solid fa-trash-can"></i>
          </button>
        </td>
      `;

      tr.querySelector('.btn-eliminar-materia').addEventListener('click', async () => {
        if (confirm(`¿Eliminar la materia "${m.nombre}"? Esto también la eliminará de Contingencias.`)) {
          try {
            await API.eliminarMateria(m.id);
            App.showToast(`Materia '${m.nombre}' eliminada del catálogo.`, 'success');
            await loadGlobalCatalogs();
          } catch (err) {
            App.showToast('Error al eliminar materia: ' + err.message, 'error');
          }
        }
      });

      listaMateriasTbody.appendChild(tr);
    });
  }

  // Start
  init();
});
