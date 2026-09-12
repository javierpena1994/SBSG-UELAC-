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
  const btnGenerarSorteo = document.getElementById('btn-generar-sorteo');

  const generatedCard = document.getElementById('generated-schedule-card');
  const printCursoNombre = document.getElementById('print-curso-nombre');
  const printTitulo = document.getElementById('print-titulo');
  const printRangoFechas = document.getElementById('print-rango-fechas');

  const btnReSortear = document.getElementById('btn-re-sortear');
  const btnGuardarHorario = document.getElementById('btn-guardar-horario');
  const btnImprimirHorario = document.getElementById('btn-imprimir-horario');

  // View Switcher Elements (Institutional Sorteo)
  const viewModeContainer = document.getElementById('view-mode-container');
  const tabSabana = document.getElementById('tab-view-sabana');
  const tabCurso = document.getElementById('tab-view-curso');
  const tabDocente = document.getElementById('tab-view-docente');
  const filterCursoSubwrapper = document.getElementById('filter-curso-subwrapper');
  const subselectCurso = document.getElementById('subselect-curso');
  const filterDocenteSubwrapper = document.getElementById('filter-docente-subwrapper');
  const subselectDocente = document.getElementById('subselect-docente');

  // Containers and Stack Wrappers
  const mainPrintHeader = document.getElementById('main-print-header');
  const mainPrintFooter = document.getElementById('main-print-footer');
  const printMetadataBar = document.getElementById('print-metadata-bar');

  const wrapperScheduleIndividual = document.getElementById('wrapper-schedule-individual');
  const coursesStackContainer = document.getElementById('courses-stack-container');

  const wrapperScheduleDocente = document.getElementById('wrapper-schedule-docente');
  const docentesStackContainer = document.getElementById('docentes-stack-container');

  const wrapperScheduleSabana = document.getElementById('wrapper-schedule-sabana');
  const tableSabanaGeneral = document.getElementById('table-sabana-general');
  const sabanaThead = document.getElementById('sabana-thead');
  const sabanaTbody = document.getElementById('sabana-tbody');

  // Historial Elements
  const historialTbody = document.getElementById('historial-examenes-tbody');
  const btnRecargarHistorial = document.getElementById('btn-recargar-historial');

  // Cursos / Materias Config Elements
  const configSelectCurso = document.getElementById('config-select-curso');
  const configCoursePills = document.getElementById('config-course-pills');
  const configMateriasListContainer = document.getElementById('config-materias-list-container');
  const configCursoNombreTitle = document.getElementById('config-curso-nombre-title');
  const configCursoCountBadge = document.getElementById('config-curso-count-badge');

  // Config Metrics Elements
  const metricConfigTotal = document.getElementById('config-metric-total');
  const metricConfigToman = document.getElementById('config-metric-toman');
  const metricConfigDificiles = document.getElementById('config-metric-dificiles');
  const metricConfigFaciles = document.getElementById('config-metric-faciles');
  const metricConfigSin = document.getElementById('config-metric-sin');

  // State
  let cursosList = [];
  let materiasList = [];
  let currentMateriasEvalList = [];
  let currentConfigCursoMaterias = [];
  let currentGeneratedSchedule = null;
  let currentScheduleViewMode = 'CURSO'; // 'CURSO' | 'DOCENTE' | 'SABANA' | 'INDIVIDUAL'
  let selectedFilterCursoId = null;
  let selectedFilterDocente = '';

  // Helpers
  function isBguCourse(courseName) {
    if (!courseName) return false;
    const n = courseName.toUpperCase();
    return n.includes('BGU') || n.includes('BACHILLER');
  }

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
      selectCurso.innerHTML = '<option value="GLOBAL" selected>⭐ SORTEO GENERAL INSTITUCIONAL (Todo el Colegio - 7 Días BGU / 5 Días Básica)</option>';
      cursosList.forEach(c => {
        const opt = document.createElement('option');
        opt.value = c.id;
        opt.textContent = c.nombre;
        selectCurso.appendChild(opt);
      });
      App.populateCursoSelect(configSelectCurso, cursosList);
      renderConfigCoursePills();

      // Trigger initial state
      triggerCursoChange();
    } catch (err) {
      console.error('Error cargando catálogos:', err);
      App.showToast('Error al conectar con la base de datos: ' + err.message, 'error');
    }
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
      if (!configSelectCurso.value && cursosList.length > 0) {
        configSelectCurso.value = cursosList[0].id;
        updateActiveCoursePill(cursosList[0].id);
      }
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
    selectCurso.addEventListener('change', triggerCursoChange);

    // View Switcher Tabs (Institutional Schedule)
    if (tabSabana) {
      tabSabana.addEventListener('click', () => {
        currentScheduleViewMode = 'SABANA';
        renderActiveView();
      });
    }
    if (tabCurso) {
      tabCurso.addEventListener('click', () => {
        currentScheduleViewMode = 'CURSO';
        renderActiveView();
      });
    }
    if (tabDocente) {
      tabDocente.addEventListener('click', () => {
        currentScheduleViewMode = 'DOCENTE';
        renderActiveView();
      });
    }
    if (subselectCurso) {
      subselectCurso.addEventListener('change', () => {
        renderActiveView();
      });
    }
    if (subselectDocente) {
      subselectDocente.addEventListener('change', () => {
        renderActiveView();
      });
    }

    // Generate Sorteo
    btnGenerarSorteo.addEventListener('click', () => ejecutarSorteo(false));
    btnReSortear.addEventListener('click', () => ejecutarSorteo(true));

    // Save Schedule
    btnGuardarHorario.addEventListener('click', handleGuardarHorario);
    btnImprimirHorario.addEventListener('click', () => window.print());

    // Historial Reload
    btnRecargarHistorial.addEventListener('click', loadHistorial);

    // Course Config Selection Change
    if (configSelectCurso) {
      configSelectCurso.addEventListener('change', () => {
        const cursoId = configSelectCurso.value;
        updateActiveCoursePill(cursoId);
        if (cursoId) {
          loadMateriasForConfigCurso(cursoId);
        } else {
          renderConfigCursoMaterias();
        }
      });
    }
  }

  // ==========================================================
  // VISTA 1: GENERADOR & EVALUACIÓN
  // ==========================================================
  async function triggerCursoChange() {
    const val = selectCurso.value;

    if (val === 'GLOBAL') {
      inputTitulo.value = 'Horario General de Exámenes - Primer Quimestre';
      selectNumDias.value = '7';
      selectNumDias.disabled = true;

      const evaluables = materiasList.filter(m => m.aplicaExamen !== false).length;
      const noEvaluables = materiasList.filter(m => m.aplicaExamen === false).length;

      if (badgeCountComplejas) badgeCountComplejas.textContent = 'Multi-Curso';
      if (badgeCountNoComplejas) badgeCountNoComplejas.textContent = `${evaluables} Materias Activas`;
      if (subjectsContainer) subjectsContainer.innerHTML = '';
      return;
    }

    // Individual course selected
    selectNumDias.disabled = false;

    if (!val) {
      subjectsContainer.innerHTML = `
        <div style="text-align: center; padding: 24px; color: var(--text-muted);">
          <i class="fa-solid fa-hand-pointer" style="margin-right:6px;"></i> Seleccione un curso arriba para cargar sus materias automáticas.
        </div>
      `;
      currentMateriasEvalList = [];
      updateComplexityCounters();
      return;
    }

    const cursoSel = cursosList.find(c => c.id === Number(val));
    const isBgu = cursoSel && isBguCourse(cursoSel.nombre);
    selectNumDias.value = isBgu ? '7' : '5';

    subjectsContainer.innerHTML = `
      <div style="text-align:center; padding: 24px; color: var(--text-muted);">
        <i class="fa-solid fa-circle-notch fa-spin" style="margin-right:6px;"></i> Cargando materias asignadas al curso...
      </div>
    `;

    try {
      const materias = await API.getMateriasEvaluacionCurso(val);
      currentMateriasEvalList = materias || [];
      renderSubjectsEvalList();
    } catch (err) {
      subjectsContainer.innerHTML = `
        <div style="text-align:center; padding: 20px; color: #dc2626;">
          <i class="fa-solid fa-triangle-exclamation" style="margin-right:6px;"></i> Error al cargar materias: ${err.message}
        </div>
      `;
    }
  }

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

      const tomaExamen = (m.tomaExamen !== false && m.seleccionada !== false);
      const dif = (m.dificultad || m.tipoComplejidad || 'FACIL').toUpperCase();
      const isDificil = (dif === 'DIFICIL' || dif === 'COMPLEJA');

      const toggleClass = isDificil ? 'is-compleja' : 'is-nocompleja';
      const toggleIcon = isDificil ? '<i class="fa-solid fa-fire" style="color:#b91c1c;"></i>' : '<i class="fa-solid fa-feather" style="color:#16a34a;"></i>';
      const toggleText = isDificil ? '🔴 DIFÍCIL' : '🟢 FÁCIL';

      row.innerHTML = `
        <div style="display: flex; align-items: center; gap: 12px; flex: 1;">
          <input type="checkbox" id="chk-materia-${index}" class="chk-materia" data-index="${index}" ${tomaExamen ? 'checked' : ''} style="width: 17px; height: 17px; cursor: pointer;">
          <label for="chk-materia-${index}" style="font-size: 13.5px; font-weight: 700; cursor: pointer; color: var(--text-main); margin: 0;">
            ${m.materiaNombre}
          </label>
          ${m.docenteNombre ? `<span style="font-size: 12px; color: var(--text-muted);"><i class="fa-solid fa-chalkboard-user"></i> ${m.docenteNombre}</span>` : ''}
          ${m.horasSemanales ? `<span style="font-size: 11px; background:#f1f5f9; padding:2px 6px; border-radius:4px; color:#475569;">${m.horasSemanales}h/sem</span>` : ''}
        </div>
        <div style="display: flex; align-items: center; gap: 10px;">
          <button type="button" class="complexity-toggle-btn ${toggleClass}" data-index="${index}" title="Haz 1 clic para alternar dificultad" ${!tomaExamen ? 'disabled style="opacity:0.4;"' : ''}>
            ${toggleIcon} <span>${toggleText}</span>
          </button>
          <button type="button" class="btn btn-secondary btn-sm btn-remove-eval-subject" data-index="${index}" style="padding: 4px 8px; color: #dc2626;" title="Excluir materia de este sorteo">
            <i class="fa-solid fa-xmark"></i>
          </button>
        </div>
      `;

      // Checkbox event (Toma Examen)
      row.querySelector('.chk-materia').addEventListener('change', (e) => {
        currentMateriasEvalList[index].tomaExamen = e.target.checked;
        currentMateriasEvalList[index].seleccionada = e.target.checked;
        renderSubjectsEvalList();
      });

      // 1-Click Toggle Dificultad
      row.querySelector('.complexity-toggle-btn').addEventListener('click', () => {
        const nuevo = isDificil ? 'FACIL' : 'DIFICIL';
        currentMateriasEvalList[index].dificultad = nuevo;
        currentMateriasEvalList[index].tipoComplejidad = nuevo;
        renderSubjectsEvalList();
      });

      // Remove / Excluir event
      row.querySelector('.btn-remove-eval-subject').addEventListener('click', () => {
        currentMateriasEvalList[index].tomaExamen = false;
        currentMateriasEvalList[index].seleccionada = false;
        renderSubjectsEvalList();
      });

      subjectsContainer.appendChild(row);
    });

    updateComplexityCounters();
  }

  function updateComplexityCounters() {
    const activas = currentMateriasEvalList.filter(m => m.tomaExamen !== false && m.seleccionada !== false);
    const difs = activas.filter(m => {
      const d = (m.dificultad || m.tipoComplejidad || '').toUpperCase();
      return d === 'DIFICIL' || d === 'COMPLEJA';
    }).length;
    const faciles = activas.length - difs;

    badgeCountComplejas.textContent = `${difs} Difíciles`;
    badgeCountNoComplejas.textContent = `${faciles} Fáciles`;
  }

  async function ejecutarSorteo(esReintento = false) {
    if (!selectCurso.value) {
      App.showToast('Por favor seleccione un curso o el Sorteo Institucional.', 'warning');
      selectCurso.focus();
      return;
    }
    if (!inputFechaInicio.value) {
      App.showToast('Por favor seleccione la fecha de inicio.', 'warning');
      inputFechaInicio.focus();
      return;
    }

    const isGlobal = selectCurso.value === 'GLOBAL';
    let payload;

    if (isGlobal) {
      payload = {
        cursoId: null,
        titulo: inputTitulo.value.trim() || 'Horario General de Exámenes Institucional',
        fechaInicio: inputFechaInicio.value,
        numDias: 7,
        materiasPorDia: 2,
        saltarFinesDeSemana: checkSaltarFds.checked,
        materias: []
      };
    } else {
      const materiasSeleccionadas = currentMateriasEvalList.filter(m => m.seleccionada !== false);
      if (materiasSeleccionadas.length === 0) {
        App.showToast('Debe tener al menos una materia seleccionada para sortear.', 'warning');
        return;
      }

      payload = {
        cursoId: Number(selectCurso.value),
        titulo: inputTitulo.value.trim() || 'Exámenes Institucionales',
        fechaInicio: inputFechaInicio.value,
        numDias: Number(selectNumDias.value),
        materiasPorDia: 2,
        saltarFinesDeSemana: checkSaltarFds.checked,
        materias: materiasSeleccionadas
      };
    }

    try {
      btnGenerarSorteo.disabled = true;
      btnGenerarSorteo.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Generando Horario...';

      const data = await API.generarSorteoExamen(payload);
      currentGeneratedSchedule = data;

      renderGeneratedScheduleTable(data);
      generatedCard.style.display = 'block';
      generatedCard.scrollIntoView({ behavior: 'smooth', block: 'start' });

      if (esReintento) {
        App.showToast('🎲 ¡Nueva combinación aleatoria y balanceada generada!', 'info');
      } else {
        App.showToast(isGlobal ? '✅ Sorteo Institucional Global generado exitosamente para todos los cursos.' : '✅ Sorteo aleatorio generado con éxito.', 'success');
      }
    } catch (err) {
      App.showToast('Error al generar sorteo: ' + err.message, 'error');
    } finally {
      btnGenerarSorteo.disabled = false;
      btnGenerarSorteo.innerHTML = '<i class="fa-solid fa-dice" style="font-size:18px;"></i> Generar Horario de Exámenes';
    }
  }

  function renderGeneratedScheduleTable(horario) {
    const isGlobal = !horario.cursoId || (horario.cursoNombre && horario.cursoNombre.includes('Todos'));

    if (isGlobal) {
      viewModeContainer.style.display = 'flex';

      // 1. Populate Subselect Cursos
      subselectCurso.innerHTML = '';
      const coursesMap = new Map();
      (horario.detalles || []).forEach(d => {
        if (d.cursoId && !coursesMap.has(d.cursoId)) {
          coursesMap.set(d.cursoId, { id: d.cursoId, nombre: d.cursoNombre });
        }
      });

      const coursesInSchedule = Array.from(coursesMap.values());
      // Ordenar iniciando por Inicial hasta 3° BGU
      coursesInSchedule.sort((a, b) => {
        const orderA = getCursoSortOrder(a.nombre);
        const orderB = getCursoSortOrder(b.nombre);
        if (orderA !== orderB) return orderA - orderB;
        return a.nombre.localeCompare(b.nombre);
      });

      const optTodosCursos = document.createElement('option');
      optTodosCursos.value = 'TODOS';
      optTodosCursos.textContent = 'Todos los Cursos (Uno tras otro)';
      subselectCurso.appendChild(optTodosCursos);

      coursesInSchedule.forEach(c => {
        const opt = document.createElement('option');
        opt.value = c.id;
        opt.textContent = c.nombre;
        subselectCurso.appendChild(opt);
      });
      subselectCurso.value = 'TODOS';

      // 2. Populate Subselect Docentes
      subselectDocente.innerHTML = '';
      const docentesSet = new Set();
      (horario.detalles || []).forEach(d => {
        const docName = (d.docenteSupervisor || d.docenteNombre || '').trim();
        if (docName) {
          docentesSet.add(docName);
        }
      });

      const docentesList = Array.from(docentesSet).sort((a, b) => a.localeCompare(b));
      const optTodosDocentes = document.createElement('option');
      optTodosDocentes.value = 'TODOS';
      optTodosDocentes.textContent = 'Todos los Docentes (Uno tras otro)';
      subselectDocente.appendChild(optTodosDocentes);

      docentesList.forEach(doc => {
        const opt = document.createElement('option');
        opt.value = doc;
        opt.textContent = doc;
        subselectDocente.appendChild(opt);
      });
      subselectDocente.value = 'TODOS';

      // Vista predeterminada: CURSO (no sábana)
      currentScheduleViewMode = 'CURSO';
    } else {
      viewModeContainer.style.display = 'none';
      currentScheduleViewMode = 'INDIVIDUAL';
    }

    renderActiveView();
  }

  function renderActiveView() {
    if (!currentGeneratedSchedule) return;

    const isGlobal = !currentGeneratedSchedule.cursoId || (currentGeneratedSchedule.cursoNombre && currentGeneratedSchedule.cursoNombre.includes('Todos'));

    if (!isGlobal) {
      viewModeContainer.style.display = 'none';
      if (filterCursoSubwrapper) filterCursoSubwrapper.style.display = 'none';
      if (filterDocenteSubwrapper) filterDocenteSubwrapper.style.display = 'none';
      wrapperScheduleSabana.style.display = 'none';
      wrapperScheduleDocente.style.display = 'none';
      wrapperScheduleIndividual.style.display = 'block';
      if (mainPrintHeader) mainPrintHeader.style.display = 'none';
      if (mainPrintFooter) mainPrintFooter.style.display = 'none';
      renderIndividualSingleCourseView();
      return;
    }

    // Modos Institucionales Globales
    viewModeContainer.style.display = 'flex';
    tabCurso.classList.toggle('active', currentScheduleViewMode === 'CURSO');
    tabDocente.classList.toggle('active', currentScheduleViewMode === 'DOCENTE');
    tabSabana.classList.toggle('active', currentScheduleViewMode === 'SABANA');

    if (filterCursoSubwrapper) filterCursoSubwrapper.style.display = currentScheduleViewMode === 'CURSO' ? 'flex' : 'none';
    if (filterDocenteSubwrapper) filterDocenteSubwrapper.style.display = currentScheduleViewMode === 'DOCENTE' ? 'flex' : 'none';

    if (currentScheduleViewMode === 'CURSO') {
      wrapperScheduleSabana.style.display = 'none';
      wrapperScheduleDocente.style.display = 'none';
      wrapperScheduleIndividual.style.display = 'block';
      if (mainPrintHeader) mainPrintHeader.style.display = 'none';
      if (mainPrintFooter) mainPrintFooter.style.display = 'none';
      renderCoursesView();
    } else if (currentScheduleViewMode === 'DOCENTE') {
      wrapperScheduleSabana.style.display = 'none';
      wrapperScheduleIndividual.style.display = 'none';
      wrapperScheduleDocente.style.display = 'block';
      if (mainPrintHeader) mainPrintHeader.style.display = 'none';
      if (mainPrintFooter) mainPrintFooter.style.display = 'none';
      renderDocentesView();
    } else if (currentScheduleViewMode === 'SABANA') {
      wrapperScheduleIndividual.style.display = 'none';
      wrapperScheduleDocente.style.display = 'none';
      wrapperScheduleSabana.style.display = 'block';
      if (mainPrintHeader) mainPrintHeader.style.display = 'block';
      if (printMetadataBar) printMetadataBar.style.display = 'flex';
      if (mainPrintFooter) mainPrintFooter.style.display = 'block';
      renderSabanaMatrix();
    }
  }

  // Sábana General (Matrix View)
  function renderSabanaMatrix() {
    printCursoNombre.textContent = 'SÁBANA GENERAL INSTITUCIONAL (TODOS LOS CURSOS)';
    printTitulo.textContent = currentGeneratedSchedule.titulo || 'Horario General de Exámenes';
    printRangoFechas.textContent = `Del ${App.formatDateDisplay(currentGeneratedSchedule.fechaInicio)} al ${App.formatDateDisplay(currentGeneratedSchedule.fechaFin)} (${currentGeneratedSchedule.numDias || 7} Días)`;

    // Unique courses in order
    const coursesMap = new Map();
    (currentGeneratedSchedule.detalles || []).forEach(d => {
      if (d.cursoId && !coursesMap.has(d.cursoId)) {
        coursesMap.set(d.cursoId, d.cursoNombre);
      }
    });

    const coursesInSchedule = Array.from(coursesMap.entries()).map(([id, nombre]) => ({ id, nombre }));

    // Build thead
    sabanaThead.innerHTML = `
      <tr>
        <th style="width: 110px; text-align: center; position: sticky; left: 0; background: #f8fafc; z-index: 3; border-right: 1px solid var(--border);">Día / Fecha</th>
        <th style="width: 105px; text-align: center; position: sticky; left: 110px; background: #f8fafc; z-index: 3; border-right: 2px solid #cbd5e1;">Periodo</th>
        ${coursesInSchedule.map(c => {
          const isBgu = isBguCourse(c.nombre);
          return `
            <th style="text-align: center; min-width: 155px; background: ${isBgu ? '#1e3a8a' : '#1e40af'}; color: white; border-right: 1px solid #3b82f6; padding: 8px 6px;">
              <div style="font-weight: 700; font-size: 12px;">${c.nombre}</div>
              <span style="font-size: 9.5px; opacity: 0.85; font-weight: normal;">${isBgu ? '7 Días (BGU)' : '5 Días (Básica)'}</span>
            </th>
          `;
        }).join('')}
      </tr>
    `;

    // Map details: key = `${cursoId}_${diaNumero}_${ordenDia}`
    const lookup = {};
    const datesMap = {};
    (currentGeneratedSchedule.detalles || []).forEach(d => {
      lookup[`${d.cursoId}_${d.diaNumero}_${d.ordenDia}`] = d;
      if (!datesMap[d.diaNumero]) {
        datesMap[d.diaNumero] = { fecha: d.fecha, diaSemana: d.diaSemana };
      }
    });

    sabanaTbody.innerHTML = '';
    const numDias = currentGeneratedSchedule.numDias || 7;

    for (let dia = 1; dia <= numDias; dia++) {
      const dateInfo = datesMap[dia] || {};
      const fechaFormatted = dateInfo.fecha ? App.formatDateDisplay(dateInfo.fecha) : '';
      const diaSemana = dateInfo.diaSemana || '';

      // Check if there is an extra period 3 on this day
      let maxPeriodos = 2;
      coursesInSchedule.forEach(c => {
        if (lookup[`${c.id}_${dia}_3`]) maxPeriodos = 3;
      });

      for (let p = 1; p <= maxPeriodos; p++) {
        const tr = document.createElement('tr');

        // Sticky col 1: Day (rowspan)
        if (p === 1) {
          const tdDia = document.createElement('td');
          tdDia.rowSpan = maxPeriodos;
          tdDia.style.cssText = 'text-align: center; position: sticky; left: 0; background: #f8fafc; z-index: 2; border-right: 1px solid var(--border); font-weight: 700; vertical-align: middle;';
          tdDia.innerHTML = `
            <div style="font-size: 12.5px; color: var(--primary);">DÍA ${dia}</div>
            <div style="font-size: 11px; color: #475569; font-weight: 600;">${diaSemana}</div>
            <div style="font-size: 10px; color: #64748b; margin-top: 2px;">${fechaFormatted}</div>
          `;
          tr.appendChild(tdDia);
        }

        // Sticky col 2: Period
        const tdPeriodo = document.createElement('td');
        tdPeriodo.style.cssText = 'text-align: center; position: sticky; left: 110px; background: #f8fafc; z-index: 2; border-right: 2px solid #cbd5e1; font-size: 11px; vertical-align: middle; padding: 6px 4px;';
        if (p === 1) {
          tdPeriodo.innerHTML = '<strong>1° Periodo</strong><br><span style="color:#64748b; font-size:10px;">07h30-08h50</span>';
        } else if (p === 2) {
          tdPeriodo.innerHTML = '<strong>2° Periodo</strong><br><span style="color:#64748b; font-size:10px;">09h10-10h30</span>';
        } else {
          tdPeriodo.innerHTML = '<strong>3° Periodo</strong><br><span style="color:#64748b; font-size:10px;">10h50-12h10</span>';
        }
        tr.appendChild(tdPeriodo);

        // Cells for each course
        coursesInSchedule.forEach(c => {
          const td = document.createElement('td');
          td.style.cssText = 'padding: 6px 8px; vertical-align: middle; border-right: 1px solid var(--border);';

          const det = lookup[`${c.id}_${dia}_${p}`];
          const isBgu = isBguCourse(c.nombre);

          if (det) {
            const isComp = det.tipoComplejidad === 'COMPLEJA';
            const badgeClass = isComp ? 'exam-badge-compleja' : 'exam-badge-nocompleja';
            const badgeText = isComp ? '<i class="fa-solid fa-brain"></i> Compleja' : '<i class="fa-solid fa-feather"></i> Menos Comp.';

            td.innerHTML = `
              <div class="sabana-cell-card">
                <div style="font-weight: 700; font-size: 11.5px; color: var(--primary); line-height: 1.2; margin-bottom: 3px;">
                  ${det.materiaNombre}
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; gap: 4px; margin-top: 3px;">
                  <span class="${badgeClass}" style="font-size: 9px; padding: 1px 5px;">
                    ${badgeText}
                  </span>
                  ${(det.docenteSupervisor || det.docenteNombre) ? `
                    <span style="font-size: 10px; color: #64748b; font-style: italic; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 90px;" title="${det.docenteSupervisor || det.docenteNombre}">
                      <i class="fa-solid fa-user-tie" style="font-size: 8px;"></i> ${(det.docenteSupervisor || det.docenteNombre).split(' ')[0]}
                    </span>
                  ` : ''}
                </div>
              </div>
            `;
          } else {
            if ((dia === 1 || dia === 2) && !isBgu) {
              td.innerHTML = `
                <div style="text-align: center; padding: 6px 4px; background: #f1f5f9; border-radius: 4px; color: #475569; font-size: 10.5px; font-weight: 600; font-style: italic;">
                  Clases Regulares
                </div>
              `;
            } else {
              td.innerHTML = `
                <div style="text-align: center; color: #94a3b8; font-size: 11px;">
                  -- Libre --
                </div>
              `;
            }
          }
          tr.appendChild(td);
        });

        sabanaTbody.appendChild(tr);
      }
    }
  }

  // ==========================================================
  // VISTA 1: CURSOS (TODOS EN CASCADA O FILTRADOS)
  // ==========================================================
  function renderCoursesView() {
    if (!coursesStackContainer) return;
    coursesStackContainer.innerHTML = '';

    const selectedVal = subselectCurso ? subselectCurso.value : 'TODOS';
    const weekRangeText = formatWeekRangeText(currentGeneratedSchedule?.fechaInicio, currentGeneratedSchedule?.fechaFin);
    const scheduleTitle = (currentGeneratedSchedule?.titulo || 'HORARIO DE EXÁMENES DEL PRIMER TRIMESTRE').toUpperCase();

    // Mapear cursos únicos presentes en el horario generado
    const coursesMap = new Map();
    (currentGeneratedSchedule?.detalles || []).forEach(d => {
      if (d.cursoId && !coursesMap.has(d.cursoId)) {
        coursesMap.set(d.cursoId, { id: d.cursoId, nombre: d.cursoNombre });
      }
    });

    let coursesToRender = Array.from(coursesMap.values());
    // Ordenar estrictamente empezando por Inicial hasta 3° BGU
    coursesToRender.sort((a, b) => {
      const orderA = getCursoSortOrder(a.nombre);
      const orderB = getCursoSortOrder(b.nombre);
      if (orderA !== orderB) return orderA - orderB;
      return a.nombre.localeCompare(b.nombre);
    });

    if (selectedVal !== 'TODOS' && selectedVal !== '') {
      const targetId = Number(selectedVal);
      coursesToRender = coursesToRender.filter(c => c.id === targetId);
    }

    if (coursesToRender.length === 0) {
      coursesStackContainer.innerHTML = `
        <div style="text-align: center; padding: 40px; color: #64748b; background: #fff; border-radius: 8px; border: 1px dashed #cbd5e1;">
          <i class="fa-solid fa-circle-info" style="font-size: 32px; margin-bottom: 10px; color: #94a3b8;"></i>
          <p style="margin: 0; font-size: 14px; font-weight: 600;">No hay datos de cursos disponibles para mostrar en este horario.</p>
        </div>
      `;
      return;
    }

    const cardsHtml = coursesToRender.map(c => {
      const detallesCurso = (currentGeneratedSchedule?.detalles || []).filter(d => d.cursoId === c.id);
      return generateCourseCardHtml(c, detallesCurso, scheduleTitle, weekRangeText);
    }).join('\n');

    coursesStackContainer.innerHTML = cardsHtml;
  }

  // Vista individual para cuando se generó sorteo de un solo curso específico desde el formulario
  function renderIndividualSingleCourseView() {
    if (!coursesStackContainer || !currentGeneratedSchedule) return;
    const weekRangeText = formatWeekRangeText(currentGeneratedSchedule.fechaInicio, currentGeneratedSchedule.fechaFin);
    const scheduleTitle = (currentGeneratedSchedule.titulo || 'HORARIO DE EXÁMENES').toUpperCase();
    const curso = {
      id: currentGeneratedSchedule.cursoId,
      nombre: currentGeneratedSchedule.cursoNombre || 'Curso'
    };
    coursesStackContainer.innerHTML = generateCourseCardHtml(
      curso,
      currentGeneratedSchedule.detalles || [],
      scheduleTitle,
      weekRangeText
    );
  }

  // ==========================================================
  // VISTA 2: DOCENTES EVALUADORES (TODOS EN CASCADA O FILTRADOS)
  // ==========================================================
  function renderDocentesView() {
    if (!docentesStackContainer) return;
    docentesStackContainer.innerHTML = '';

    const selectedDoc = subselectDocente ? subselectDocente.value : 'TODOS';
    const weekRangeText = formatWeekRangeText(currentGeneratedSchedule?.fechaInicio, currentGeneratedSchedule?.fechaFin);

    // Mapear docentes únicos
    const docentesSet = new Set();
    (currentGeneratedSchedule?.detalles || []).forEach(d => {
      const docName = (d.docenteSupervisor || d.docenteNombre || '').trim();
      if (docName) {
        docentesSet.add(docName);
      }
    });

    let docentesToRender = Array.from(docentesSet).sort((a, b) => a.localeCompare(b));

    if (selectedDoc !== 'TODOS' && selectedDoc !== '') {
      docentesToRender = docentesToRender.filter(doc => doc.trim().toUpperCase() === selectedDoc.trim().toUpperCase());
    }

    if (docentesToRender.length === 0) {
      docentesStackContainer.innerHTML = `
        <div style="text-align: center; padding: 40px; color: #64748b; background: #fff; border-radius: 8px; border: 1px dashed #cbd5e1;">
          <i class="fa-solid fa-user-xmark" style="font-size: 32px; margin-bottom: 10px; color: #94a3b8;"></i>
          <p style="margin: 0; font-size: 14px; font-weight: 600;">No se encontraron asignaciones de docentes evaluadores en este horario.</p>
        </div>
      `;
      return;
    }

    const cardsHtml = docentesToRender.map(doc => {
      return generateDocenteCardHtml(doc, currentGeneratedSchedule, weekRangeText);
    }).join('\n');

    docentesStackContainer.innerHTML = cardsHtml;
  }

  // ==========================================================
  // GENERADORES HTML DE FORMATO OFICIAL (TARJETAS IMPRIMIBLES)
  // ==========================================================
  function generateCourseCardHtml(curso, detallesCurso, scheduleTitle, weekRangeText) {
    const cursoNombre = curso.nombre;
    const isBgu = isBguCourse(cursoNombre);
    const displayCurso = getCourseDisplayTitle(cursoNombre);
    const seccion = getSeccionCurso(cursoNombre);
    const isEscuela = (seccion === 'ESCUELA');

    // Determinar días activos (días donde rinde exámenes)
    const activeDaysSet = new Set();
    (detallesCurso || []).forEach(d => {
      if (d.materiaNombre && d.materiaNombre.trim()) {
        activeDaysSet.add(d.diaNumero);
      }
    });

    let dayNumbers = Array.from(activeDaysSet).sort((a, b) => a - b);
    if (dayNumbers.length === 0) {
      const minD = isBgu ? 1 : 3;
      const maxD = currentGeneratedSchedule?.numDias || 7;
      for (let d = minD; d <= maxD; d++) dayNumbers.push(d);
    }

    // Mapeo de columnas por día
    const columns = dayNumbers.map(diaNum => {
      const sample = (currentGeneratedSchedule?.detalles || []).find(d => d.diaNumero === diaNum && d.fecha)
        || (detallesCurso || []).find(d => d.diaNumero === diaNum && d.fecha);

      const fechaStr = sample?.fecha || '';
      let diaSemana = sample?.diaSemana || '';

      const parts = fechaStr ? fechaStr.split('-') : [];
      const diaDelMes = parts.length === 3 ? parseInt(parts[2], 10) : '';
      const mesDelAno = parts.length === 3 ? parseInt(parts[1], 10) : '';

      if (!diaSemana && parts.length === 3) {
        const dObj = new Date(parseInt(parts[0], 10), mesDelAno - 1, diaDelMes);
        const dias = ['DOMINGO', 'LUNES', 'MARTES', 'MIÉRCOLES', 'JUEVES', 'VIERNES', 'SÁBADO'];
        diaSemana = dias[dObj.getDay()] || '';
      }

      const diaNameUpper = diaSemana ? diaSemana.toUpperCase() : `DÍA ${diaNum}`;
      const headerTitle = diaDelMes ? `${diaNameUpper} ${diaDelMes}` : diaNameUpper;
      const headerSub = (diaDelMes && mesDelAno) ? `(${diaDelMes}/${mesDelAno})` : '';

      // Exámenes del día ordenados
      const dayExams = (detallesCurso || []).filter(d => d.diaNumero === diaNum && d.materiaNombre)
        .sort((a, b) => (a.ordenDia || 1) - (b.ordenDia || 1));

      let slot07h30 = null;
      let slot08h30 = null;
      let slot09h30 = null;

      if (isEscuela) {
        // Escuela: Primer examen 07h30 (ordenDia 1), Segundo examen 08h30 (ordenDia 2)
        slot07h30 = dayExams.find(d => d.ordenDia === 1 || (d.horaInicio && d.horaInicio.includes('07h30'))) || dayExams[0] || null;
        slot08h30 = dayExams.find(d => d.ordenDia === 2 || (d.horaInicio && d.horaInicio.includes('08h30'))) || (dayExams.length > 1 ? dayExams[1] : null);
      } else {
        // Colegio: Franjas 07h30, 08h30 y 09h30 según ordenDia u horaInicio (con variación: a veces consecutivos, a veces con espacio intermedio)
        slot07h30 = dayExams.find(d => d.ordenDia === 1 || (d.horaInicio && (d.horaInicio.includes('07:30') || d.horaInicio.includes('07h30')))) || null;
        slot08h30 = dayExams.find(d => d.ordenDia === 2 || (d.horaInicio && (d.horaInicio.includes('08:30') || d.horaInicio.includes('08h30')))) || null;
        slot09h30 = dayExams.find(d => d.ordenDia === 3 || (d.horaInicio && (d.horaInicio.includes('09:30') || d.horaInicio.includes('09h30')))) || null;

        // Fallback defensivo si algún examen no tuviera ordenDia u horaInicio mapeada
        if (!slot07h30 && !slot08h30 && !slot09h30 && dayExams.length > 0) {
          if (dayExams.length === 1) {
            slot07h30 = dayExams[0];
          } else if (dayExams.length === 2) {
            slot07h30 = dayExams[0];
            slot08h30 = dayExams[1];
          } else if (dayExams.length >= 3) {
            slot07h30 = dayExams[0];
            slot08h30 = dayExams[1];
            slot09h30 = dayExams[2];
          }
        }
      }

      return {
        diaNumero: diaNum,
        title: headerTitle,
        sub: headerSub,
        slot07h30,
        slot08h30,
        slot09h30
      };
    });

    const renderExamCellHtml = (slot) => {
      if (!slot) return '<td class="cell-empty" style="border: 1.5px solid #000; background: #fff;"></td>';
      const doc = (slot.docenteSupervisor || slot.docenteNombre || '').trim();
      return `
        <td class="cell-materia" title="${doc ? 'Docente: ' + doc : ''}" style="border: 1.5px solid #000; padding: 8px 4px; font-weight: 800; font-size: 12px; text-transform: uppercase; line-height: 1.3;">
          <div>${slot.materiaNombre}</div>
          ${doc ? `<div class="cell-materia-docente" style="font-size: 9px; font-weight: 600; color: #475569; margin-top: 3px;"><i class="fa-solid fa-user-tie"></i> ${doc}</div>` : ''}
        </td>
      `;
    };

    const theadHtml = `
      <thead>
        <tr>
          <th class="col-hora" style="width: 135px; text-align: center; border: 1.5px solid #000; font-weight: 800; font-size: 12px; background: #f8fafc;">HORA</th>
          ${columns.map(col => `
            <th style="text-align: center; min-width: 120px; border: 1.5px solid #000; background: #f8fafc; padding: 6px 4px;">
              <div style="font-size: 12px; font-weight: 800; color: #000;">${col.title}</div>
              ${col.sub ? `<div style="font-size: 10.5px; font-weight: 700; color: #475569; margin-top: 2px;">${col.sub}</div>` : ''}
            </th>
          `).join('')}
        </tr>
      </thead>
    `;

    let tbodyRows = '';

    if (isEscuela) {
      // ESCUELA: 6 filas, almuerzo/lunch 09h30, salida 10h30
      tbodyRows = `
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">07H10-07H30</td>
          ${columns.map(() => `<td class="cell-preparacion" style="border: 1.5px solid #000; text-align: center; font-size: 11.5px; font-weight: 600;">Preparación de aula</td>`).join('')}
        </tr>
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">07H30-08H30</td>
          ${columns.map(c => renderExamCellHtml(c.slot07h30)).join('')}
        </tr>
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">08H30-09H30</td>
          ${columns.map(c => renderExamCellHtml(c.slot08h30)).join('')}
        </tr>
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">09H30-09H50</td>
          ${columns.map(() => `<td class="cell-receso" style="border: 1.5px solid #000; text-align: center; font-size: 12.5px; font-weight: 900; letter-spacing: 1px;">LUNCH</td>`).join('')}
        </tr>
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">09H50-10H30</td>
          ${columns.map((c, idx) => {
            const txt = (idx === 0) ? 'Acompañamiento del tutor de grado o curso' : 'Devolución y retroalimentación de Exámenes';
            return `<td class="cell-retroalimentacion" style="border: 1.5px solid #000; text-align: center; font-size: 11px; font-weight: 600; padding: 6px 4px;">${txt}</td>`;
          }).join('')}
        </tr>
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">10H30</td>
          ${columns.map(() => `<td class="cell-salida" style="border: 1.5px solid #000; text-align: center; font-size: 12.5px; font-weight: 900; letter-spacing: 1px;">SALIDA</td>`).join('')}
        </tr>
      `;
    } else {
      // COLEGIO: 7 filas, receso 10h30, salida 11h40
      tbodyRows = `
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">07H10-07H30</td>
          ${columns.map(() => `<td class="cell-preparacion" style="border: 1.5px solid #000; text-align: center; font-size: 11.5px; font-weight: 600;">Preparación de aula</td>`).join('')}
        </tr>
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">07H30-08H30</td>
          ${columns.map(c => renderExamCellHtml(c.slot07h30)).join('')}
        </tr>
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">08H30-09H30</td>
          ${columns.map(c => renderExamCellHtml(c.slot08h30)).join('')}
        </tr>
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">09H30-10H30</td>
          ${columns.map(c => renderExamCellHtml(c.slot09h30)).join('')}
        </tr>
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">10H30 -10H50</td>
          ${columns.map(() => `<td class="cell-receso" style="border: 1.5px solid #000; text-align: center; font-size: 12.5px; font-weight: 900; letter-spacing: 1px;">RECESO</td>`).join('')}
        </tr>
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">10H50-11H40</td>
          ${columns.map((c, idx) => {
            const txt = (idx === 0) ? 'Acompañamiento del tutor de grado o curso' : 'Devolución y retroalimentación de Exámenes';
            return `<td class="cell-retroalimentacion" style="border: 1.5px solid #000; text-align: center; font-size: 11px; font-weight: 600; padding: 6px 4px;">${txt}</td>`;
          }).join('')}
        </tr>
        <tr>
          <td class="col-hora" style="border: 1.5px solid #000; font-weight: 800; font-size: 11.5px; text-align: center;">11H40</td>
          ${columns.map(() => `<td class="cell-salida" style="border: 1.5px solid #000; text-align: center; font-size: 12.5px; font-weight: 900; letter-spacing: 1px;">SALIDA</td>`).join('')}
        </tr>
      `;
    }

    return `
      <div class="course-schedule-card" style="margin-bottom: 40px; background: #fff; padding: 20px; border-radius: 8px; border: 1px solid #e2e8f0;">
        <div class="print-header" style="text-align: center; margin-bottom: 12px;">
          <div style="display: flex; align-items: center; justify-content: center; gap: 14px; margin-bottom: 6px;">
            <img src="assets/logo.jpg" alt="Logo SBSG" style="height: 52px; object-fit: contain;">
            <div>
              <h2 style="font-size: 16px; font-weight: 800; color: #1e3a8a; margin: 0; text-transform: uppercase;">
                UNIDAD EDUCATIVA LOLA AROSEMENA DE CARBO
              </h2>
              <h3 style="font-size: 12px; font-weight: 600; color: #475569; margin: 2px 0 0 0;">
                CRONOGRAMA OFICIAL DE EXÁMENES Y EVALUACIONES TRIMESTRALES
              </h3>
            </div>
          </div>
          <hr style="border: 0; border-top: 1.5px solid #1e3a8a; margin: 8px 0 12px 0;">
          <div style="text-align: center; margin-bottom: 10px;">
            <div style="font-size: 13.5px; font-weight: 900; letter-spacing: 0.5px; text-transform: uppercase; color: #000;">
              ${scheduleTitle}
            </div>
            <div style="font-size: 11.5px; font-weight: 700; color: #334155; margin-top: 2px;">
              ${weekRangeText}
            </div>
            <div style="font-size: 16.5px; font-weight: 900; color: #000; margin-top: 4px; letter-spacing: 0.5px;">
              ${displayCurso}
            </div>
          </div>
        </div>

        <table class="official-grid-table" style="width: 100%; border-collapse: collapse; border: 2px solid #000; margin-bottom: 14px;">
          ${theadHtml}
          <tbody>
            ${tbodyRows}
          </tbody>
        </table>

        <div style="margin-top: 14px; font-size: 10.5px; color: #64748b; line-height: 1.35;">
          <strong>Instrucciones:</strong> Los estudiantes deben presentarse puntualmente con sus respectivos materiales de trabajo. Durante las evaluaciones no se permite el uso de dispositivos móviles sin autorización del docente evaluador.
        </div>

        <div class="print-signatures" style="margin-top: 26px; display: flex; justify-content: space-around; text-align: center;">
          <div style="flex: 1; max-width: 250px;">
            <div class="sig-line" style="border-top: 1px solid #000; padding-top: 4px; font-weight: 700; font-size: 11px;">Vicerrectorado Académico</div>
          </div>
          <div style="flex: 1; max-width: 250px;">
            <div class="sig-line" style="border-top: 1px solid #000; padding-top: 4px; font-weight: 700; font-size: 11px;">Tutor(a) / Docente</div>
          </div>
        </div>
      </div>
    `;
  }

  function generateDocenteCardHtml(docNombre, horario, weekRangeText) {
    const numDias = horario.numDias || 7;
    const docDetalles = (horario.detalles || []).filter(d => {
      const name = (d.docenteSupervisor || d.docenteNombre || '').trim().toUpperCase();
      return name === docNombre.trim().toUpperCase();
    });

    // Agrupar por día
    const byDay = {};
    for (let d = 1; d <= numDias; d++) {
      byDay[d] = {
        diaNumero: d,
        fecha: null,
        diaSemana: '',
        slot07h30: null,
        slot08h30: null,
        slot09h30: null,
        cursos: new Set()
      };
    }

    (horario.detalles || []).forEach(d => {
      if (byDay[d.diaNumero]) {
        if (!byDay[d.diaNumero].fecha && d.fecha) byDay[d.diaNumero].fecha = d.fecha;
        if (!byDay[d.diaNumero].diaSemana && d.diaSemana) byDay[d.diaNumero].diaSemana = d.diaSemana;
      }
    });

    docDetalles.forEach(d => {
      const dayObj = byDay[d.diaNumero];
      if (!dayObj) return;

      if (d.cursoNombre) dayObj.cursos.add(d.cursoNombre);

      const h = (d.horaInicio || '').toLowerCase();
      if (h.includes('07:30') || h.includes('07h30')) {
        dayObj.slot07h30 = d;
      } else if (h.includes('08:30') || h.includes('08h30')) {
        dayObj.slot08h30 = d;
      } else if (h.includes('09:30') || h.includes('09h30')) {
        dayObj.slot09h30 = d;
      } else {
        // Asignación por ordenDia
        if (d.ordenDia === 1) {
          dayObj.slot07h30 = d;
        } else if (d.ordenDia === 2) {
          const seccion = getSeccionCurso(d.cursoNombre);
          if (seccion === 'ESCUELA') {
            dayObj.slot08h30 = d;
          } else {
            dayObj.slot09h30 = d;
          }
        } else {
          dayObj.slot09h30 = d;
        }
      }
    });

    const formatSlotHtml = (slot) => {
      if (!slot) {
        return '<div style="color: #94a3b8; font-size: 11px; font-style: italic;">-- Libre --</div>';
      }
      const isComp = isDificilCompleja(slot.tipoComplejidad) || sugerirComplejidadPorNombre(slot.materiaNombre);
      const badgeClass = isComp ? 'exam-badge-compleja' : 'exam-badge-nocompleja';
      const badgeText = isComp ? '<i class="fa-solid fa-brain"></i> Compleja' : '<i class="fa-solid fa-feather"></i> Menos Comp.';

      return `
        <div style="font-weight: 800; font-size: 12px; color: var(--primary); text-transform: uppercase; margin-bottom: 3px;">
          ${slot.materiaNombre}
        </div>
        <div style="font-size: 11.5px; color: #1e40af; font-weight: 700; margin-bottom: 4px;">
          <i class="fa-solid fa-graduation-cap"></i> ${slot.cursoNombre || 'Curso'}
        </div>
        <div>
          <span class="${badgeClass}" style="font-size: 9.5px; padding: 2px 6px;">${badgeText}</span>
        </div>
      `;
    };

    const rowsHtml = Object.values(byDay).sort((a, b) => a.diaNumero - b.diaNumero).map(dayObj => {
      const fechaDisplay = dayObj.fecha ? App.formatDateDisplay(dayObj.fecha) : '';
      const diaSemanaUpper = dayObj.diaSemana ? dayObj.diaSemana.toUpperCase() : `DÍA ${dayObj.diaNumero}`;

      const s07 = formatSlotHtml(dayObj.slot07h30);
      const s08 = formatSlotHtml(dayObj.slot08h30);
      const s09 = formatSlotHtml(dayObj.slot09h30);

      const cursosArr = Array.from(dayObj.cursos);
      const resumenCursos = cursosArr.length > 0
        ? cursosArr.map(c => `<span class="badge" style="background:#e0e7ff; color:#3730a3; margin:2px; font-size:10px;">${c}</span>`).join(' ')
        : '<span style="color:#94a3b8; font-size:11px; font-style:italic;">Sin asignación</span>';

      return `
        <tr>
          <td style="text-align: center; font-weight: 700; background: #f8fafc; border: 1.5px solid #000; padding: 8px 6px;">
            <div style="color: var(--primary); font-size: 12.5px;">DÍA ${dayObj.diaNumero}</div>
            <div style="font-size: 11px; color: #475569; font-weight: 700;">${diaSemanaUpper}</div>
            ${fechaDisplay ? `<div style="font-size: 10px; color: #64748b; margin-top: 2px;">${fechaDisplay}</div>` : ''}
          </td>
          <td style="text-align: center; padding: 10px 8px; border: 1.5px solid #000; vertical-align: middle;">${s07}</td>
          <td style="text-align: center; padding: 10px 8px; border: 1.5px solid #000; vertical-align: middle;">${s08}</td>
          <td style="text-align: center; padding: 10px 8px; border: 1.5px solid #000; vertical-align: middle;">${s09}</td>
          <td style="text-align: center; padding: 10px 8px; border: 1.5px solid #000; vertical-align: middle;">${resumenCursos}</td>
        </tr>
      `;
    }).join('\n');

    return `
      <div class="docente-schedule-card" style="margin-bottom: 40px; background: #fff; padding: 20px; border-radius: 8px; border: 1px solid #e2e8f0;">
        <div class="print-header" style="text-align: center; margin-bottom: 12px;">
          <div style="display: flex; align-items: center; justify-content: center; gap: 14px; margin-bottom: 6px;">
            <img src="assets/logo.jpg" alt="Logo SBSG" style="height: 52px; object-fit: contain;">
            <div>
              <h2 style="font-size: 16px; font-weight: 800; color: #1e3a8a; margin: 0; text-transform: uppercase;">
                UNIDAD EDUCATIVA LOLA AROSEMENA DE CARBO
              </h2>
              <h3 style="font-size: 12px; font-weight: 600; color: #475569; margin: 2px 0 0 0;">
                CRONOGRAMA OFICIAL DE EXÁMENES Y EVALUACIONES TRIMESTRALES
              </h3>
            </div>
          </div>
          <hr style="border: 0; border-top: 1.5px solid #1e3a8a; margin: 8px 0 12px 0;">
          <div style="text-align: center; margin-bottom: 10px;">
            <div style="font-size: 13.5px; font-weight: 900; letter-spacing: 0.5px; text-transform: uppercase; color: #000;">
              HORARIO DE ASIGNACIÓN DE EVALUACIONES POR DOCENTE
            </div>
            <div style="font-size: 11.5px; font-weight: 700; color: #334155; margin-top: 2px;">
              ${weekRangeText}
            </div>
            <div style="font-size: 16.5px; font-weight: 900; color: #1e3a8a; margin-top: 4px; letter-spacing: 0.5px;">
              <i class="fa-solid fa-user-tie"></i> DOCENTE EVALUADOR: ${docNombre}
            </div>
          </div>
        </div>

        <table class="data-table" style="width: 100%; border-collapse: collapse; border: 2px solid #000; margin-bottom: 14px;">
          <thead>
            <tr>
              <th style="width: 130px; text-align: center; border: 1.5px solid #000; font-weight: 800; font-size: 12px; background: #f8fafc;">DÍA / FECHA</th>
              <th style="text-align: center; border: 1.5px solid #000; font-weight: 800; font-size: 12px; background: #f8fafc;">1° BLOQUE (07H30 - 08H30)</th>
              <th style="text-align: center; border: 1.5px solid #000; font-weight: 800; font-size: 12px; background: #f8fafc;">2° BLOQUE (08H30 - 09H30)</th>
              <th style="text-align: center; border: 1.5px solid #000; font-weight: 800; font-size: 12px; background: #f8fafc;">3° BLOQUE (09H30 - 10H30)</th>
              <th style="width: 200px; text-align: center; border: 1.5px solid #000; font-weight: 800; font-size: 12px; background: #f8fafc;">CURSOS ASIGNADOS</th>
            </tr>
          </thead>
          <tbody>
            ${rowsHtml}
          </tbody>
        </table>

        <div class="print-signatures" style="margin-top: 26px; display: flex; justify-content: space-around; text-align: center;">
          <div style="flex: 1; max-width: 250px;">
            <div class="sig-line" style="border-top: 1px solid #000; padding-top: 4px; font-weight: 700; font-size: 11px;">Vicerrectorado Académico</div>
          </div>
          <div style="flex: 1; max-width: 250px;">
            <div class="sig-line" style="border-top: 1px solid #000; padding-top: 4px; font-weight: 700; font-size: 11px;">Docente Evaluador: ${docNombre}</div>
          </div>
        </div>
      </div>
    `;
  }

  // ==========================================================
  // HELPERS OFICIALES
  // ==========================================================
  function getCursoSortOrder(nombre) {
    if (!nombre) return 999;
    const n = String(nombre).toUpperCase().trim();
    if (n.includes('INICIAL 1')) return 1;
    if (n.includes('INICIAL 2')) return 2;
    if (n.includes('INICIAL')) return 1;

    // BGU primero para que "1° BGU" no coincida con "1° EGB"
    if (n.includes('1° BGU') || n.includes('1 BGU') || n.includes('1RO BGU') || n.includes('PRIMERO BGU') || (n.includes('PRIMERO') && n.includes('BACHILLER'))) return 12;
    if (n.includes('2° BGU') || n.includes('2 BGU') || n.includes('2DO BGU') || n.includes('SEGUNDO BGU') || (n.includes('SEGUNDO') && n.includes('BACHILLER'))) return 13;
    if (n.includes('3° BGU') || n.includes('3 BGU') || n.includes('3RO BGU') || n.includes('TERCERO BGU') || (n.includes('TERCERO') && n.includes('BACHILLER'))) return 14;

    // EGB
    if (n.includes('PRIMERO') || n.startsWith('1°') || n.startsWith('1 ') || n.startsWith('1RO')) return 3;
    if (n.includes('SEGUNDO') || n.startsWith('2°') || n.startsWith('2 ') || n.startsWith('2DO')) return 4;
    if (n.includes('TERCERO') || n.startsWith('3°') || n.startsWith('3 ') || n.startsWith('3RO')) return 5;
    if (n.includes('CUARTO') || n.startsWith('4°') || n.startsWith('4 ') || n.startsWith('4TO')) return 6;
    if (n.includes('QUINTO') || n.startsWith('5°') || n.startsWith('5 ') || n.startsWith('5TO')) return 7;
    if (n.includes('SEXTO') || n.startsWith('6°') || n.startsWith('6 ') || n.startsWith('6TO')) return 8;
    if (n.includes('SÉPTIMO') || n.includes('SEPTIMO') || n.startsWith('7°') || n.startsWith('7 ') || n.startsWith('7MO')) return 9;
    if (n.includes('OCTAVO') || n.startsWith('8°') || n.startsWith('8 ') || n.startsWith('8VO')) return 10;
    if (n.includes('NOVENO') || n.startsWith('9°') || n.startsWith('9 ') || n.startsWith('9NO')) return 11;
    if (n.includes('DÉCIMO') || n.includes('DECIMO') || n.startsWith('10°') || n.startsWith('10 ') || n.startsWith('10MO')) return 11.5;
    return 999;
  }

  function isDificilCompleja(tipo) {
    if (!tipo) return false;
    const s = String(tipo).toUpperCase().trim();
    return s === 'DIFICIL' || s === 'COMPLEJA';
  }

  function sugerirComplejidadPorNombre(nombre) {
    if (!nombre) return false;
    const n = String(nombre).toUpperCase().trim();
    if (n.includes('FÍSICA') && n.includes('EDUCACIÓN')) return false;
    if (n.includes('EDUCACION FISICA') || n.includes('EDUCACIÓN FÍSICA') || n.includes('ED. FISICA') || n.includes('ED. FÍSICA')) return false;
    if (n.includes('CULTURAL') || n.includes('ARTÍSTICA') || n.includes('ARTISTICA') || n.includes('ECA') || n.includes('ARTE') || n.includes('DIBUJO')) return false;
    if (n.includes('INFORMÁTICA') || n.includes('INFORMATICA') || n.includes('COMPUTACIÓN') || n.includes('COMPUTACION') || n.includes('TIC') || n.includes('HERRAMIENTAS COMP') || n.includes('HABILID')) return false;
    if (n.includes('EMPRENDIMIENTO') || n.includes('GESTIÓN') || n.includes('GESTION')) return false;
    if (n.includes('CIUDADANÍA') || n.includes('CIUDADANIA') || n.includes('CÍVICA') || n.includes('CIVICA')) return false;
    if (n.includes('RELIGIÓN') || n.includes('RELIGION') || n.includes('VALORES') || n.includes('PASTORAL')) return false;
    if (n.includes('TUTORÍA') || n.includes('TUTORIA') || n.includes('PROYECTO') || n.includes('LECTURA') || n.includes('ROBÓTICA') || n.includes('ROBOTICA')) return false;
    if (n.includes('DESARROLLO DEL PENSAMIENTO') || n.includes('DESARROLLO HUMANO') || n === 'D.P.' || n.startsWith('D.P')) return false;
    if (n.includes('INGLÉS') || n.includes('INGLES') || n.includes('ENGLISH')) return false;
    return true;
  }

  function getCourseDisplayTitle(cursoNombre) {
    if (!cursoNombre) return 'CURSO';
    const n = String(cursoNombre).toUpperCase().trim();
    if (n.includes('INICIAL 1')) return 'INICIAL 1';
    if (n.includes('INICIAL 2')) return 'INICIAL 2';
    if (n.includes('INICIAL')) return 'INICIAL';
    if (n.includes('3° BGU') || n.includes('3 BGU') || n.includes('3RO BGU') || n.includes('TERCERO BGU')) return 'TERCERO BGU';
    if (n.includes('2° BGU') || n.includes('2 BGU') || n.includes('2DO BGU') || n.includes('SEGUNDO BGU')) return 'SEGUNDO BGU';
    if (n.includes('1° BGU') || n.includes('1 BGU') || n.includes('1RO BGU') || n.includes('PRIMERO BGU')) return 'PRIMERO BGU';
    if (n.includes('10') || n.includes('DECIMO') || n.includes('DÉCIMO')) return 'DÉCIMO DE BÁSICA';
    if (n.includes('9') || n.includes('NOVENO')) return 'NOVENO DE BÁSICA';
    if (n.includes('8') || n.includes('OCTAVO')) return 'OCTAVO DE BÁSICA';
    if (n.includes('7') || n.includes('SEPTIMO') || n.includes('SÉPTIMO')) return 'SÉPTIMO DE BÁSICA';
    if (n.includes('6') || n.includes('SEXTO')) return 'SEXTO DE BÁSICA';
    if (n.includes('5') || n.includes('QUINTO')) return 'QUINTO DE BÁSICA';
    if (n.includes('4') || n.includes('CUARTO')) return 'CUARTO DE BÁSICA';
    if (n.includes('3') || n.includes('TERCERO')) return 'TERCERO DE BÁSICA';
    if (n.includes('2') || n.includes('SEGUNDO')) return 'SEGUNDO DE BÁSICA';
    if (n.includes('1') || n.includes('PRIMERO')) return 'PRIMERO DE BÁSICA';
    return n;
  }

  function formatWeekRangeText(firstDateStr, lastDateStr) {
    if (!firstDateStr || !lastDateStr) return 'SEMANA DE EXÁMENES DEL TRIMESTRE';
    const meses = ['ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO', 'JULIO', 'AGOSTO', 'SEPTIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE'];
    const p1 = String(firstDateStr).split('-');
    const p2 = String(lastDateStr).split('-');
    if (p1.length === 3 && p2.length === 3) {
      const d1 = parseInt(p1[2], 10);
      const m1 = parseInt(p1[1], 10) - 1;
      const y1 = parseInt(p1[0], 10);

      const d2 = parseInt(p2[2], 10);
      const m2 = parseInt(p2[1], 10) - 1;
      const y2 = parseInt(p2[0], 10);

      if (m1 === m2 && y1 === y2) {
        return `SEMANA DEL ${d1} AL ${d2} DE ${meses[m1]} DEL ${y1}`;
      } else {
        return `SEMANA DEL ${d1} DE ${meses[m1]} AL ${d2} DE ${meses[m2]} DEL ${y2}`;
      }
    }
    return `SEMANA DEL ${firstDateStr} AL ${lastDateStr}`;
  }

  function getSeccionCurso(cursoNombre) {
    if (!cursoNombre) return 'ESCUELA';
    const n = String(cursoNombre).toUpperCase().trim();
    if (n.startsWith('8') || n.includes('OCTAVO') ||
        n.startsWith('9') || n.includes('NOVENO') ||
        n.startsWith('10') || n.includes('DECIMO') || n.includes('DÉCIMO') ||
        n.includes('BGU') || n.includes('BACHILLERATO') || n.includes('BACH')) {
      return 'COLEGIO';
    }
    return 'ESCUELA';
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
          <td><span class="badge" style="background:#e0e7ff; color:#3730a3;">${item.cursoNombre || 'Institucional'}</span></td>
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
  // VISTA 3: CONFIGURACIÓN DE MATERIAS POR CURSO (PARA EXÁMENES)
  // ==========================================================

  function renderConfigCoursePills() {
    if (!configCoursePills) return;
    configCoursePills.innerHTML = '';

    cursosList.forEach(c => {
      const pill = document.createElement('div');
      pill.className = 'course-pill';
      pill.dataset.id = c.id;
      pill.textContent = c.nombre;

      pill.addEventListener('click', () => {
        configSelectCurso.value = c.id;
        updateActiveCoursePill(c.id);
        loadMateriasForConfigCurso(c.id);
      });

      configCoursePills.appendChild(pill);
    });
  }

  function updateActiveCoursePill(cursoId) {
    if (!configCoursePills) return;
    const pills = configCoursePills.querySelectorAll('.course-pill');
    pills.forEach(p => {
      if (Number(p.dataset.id) === Number(cursoId)) {
        p.classList.add('active');
      } else {
        p.classList.remove('active');
      }
    });
  }

  async function loadMateriasForConfigCurso(cursoId) {
    if (!configMateriasListContainer) return;

    configMateriasListContainer.innerHTML = `
      <div style="text-align:center; padding: 40px 20px; color: var(--text-muted);">
        <i class="fa-solid fa-spinner fa-spin" style="font-size:26px; color:var(--primary); margin-bottom:12px;"></i>
        <div>Cargando asignaturas del curso según el horario alimentado...</div>
      </div>
    `;

    try {
      const materias = await API.getMateriasEvaluacionCurso(cursoId);
      currentConfigCursoMaterias = materias || [];
      renderConfigCursoMaterias();
    } catch (err) {
      configMateriasListContainer.innerHTML = `
        <div style="text-align:center; padding: 30px; color: #dc2626;">
          <i class="fa-solid fa-triangle-exclamation" style="font-size:28px; margin-bottom:10px;"></i>
          <div>Error al cargar las materias: ${err.message}</div>
        </div>
      `;
    }
  }

  function actualizarConfigMetricas() {
    const total = currentConfigCursoMaterias.length;
    const toman = currentConfigCursoMaterias.filter(m => m.tomaExamen !== false).length;
    const dificiles = currentConfigCursoMaterias.filter(m => m.tomaExamen !== false && (m.dificultad === 'DIFICIL' || m.tipoComplejidad === 'COMPLEJA' || m.tipoComplejidad === 'DIFICIL')).length;
    const faciles = currentConfigCursoMaterias.filter(m => m.tomaExamen !== false && (m.dificultad === 'FACIL' || m.tipoComplejidad === 'NO_COMPLEJA' || m.tipoComplejidad === 'FACIL')).length;
    const sinExamen = total - toman;

    if (metricConfigTotal) metricConfigTotal.textContent = total;
    if (metricConfigToman) metricConfigToman.textContent = toman;
    if (metricConfigDificiles) metricConfigDificiles.textContent = dificiles;
    if (metricConfigFaciles) metricConfigFaciles.textContent = faciles;
    if (metricConfigSin) metricConfigSin.textContent = sinExamen;
    if (configCursoCountBadge) configCursoCountBadge.textContent = `${total} materias`;
  }

  function mostrarConfigIndicadorGuardado(materiaId) {
    const ind = document.getElementById(`config-save-ind-${materiaId}`);
    if (ind) {
      ind.classList.add('show');
      setTimeout(() => ind.classList.remove('show'), 1600);
    }
  }

  function renderConfigCursoMaterias() {
    if (!configMateriasListContainer) return;
    configMateriasListContainer.innerHTML = '';

    const cursoId = configSelectCurso.value;
    const cursoObj = cursosList.find(c => Number(c.id) === Number(cursoId));
    if (configCursoNombreTitle) {
      configCursoNombreTitle.textContent = cursoObj ? `Materias de ${cursoObj.nombre}` : 'Materias del Curso';
    }

    actualizarConfigMetricas();

    if (!currentConfigCursoMaterias || currentConfigCursoMaterias.length === 0) {
      configMateriasListContainer.innerHTML = `
        <div style="text-align:center; padding: 40px; color: var(--text-muted);">
          <i class="fa-solid fa-folder-open" style="font-size:32px; margin-bottom:10px; opacity:0.5;"></i>
          <div>No se encontraron materias registradas en el horario de clases de este curso.</div>
        </div>
      `;
      return;
    }

    currentConfigCursoMaterias.forEach(m => {
      const row = document.createElement('div');
      const tomaExamen = (m.tomaExamen !== false);
      const dif = (m.dificultad || m.tipoComplejidad || 'FACIL').toUpperCase();
      const esDificil = (dif === 'DIFICIL' || dif === 'COMPLEJA');

      row.className = `materia-card-row ${tomaExamen ? 'active-row' : 'inactive-row'}`;
      row.id = `config-row-materia-${m.materiaId}`;

      const avatarClass = !tomaExamen ? 'inactiva' : (esDificil ? 'dificil' : 'facil');
      const avatarIcon = !tomaExamen ? 'fa-ban' : (esDificil ? 'fa-fire' : 'fa-feather');

      row.innerHTML = `
        <!-- Lado Izquierdo: Info de la Materia -->
        <div class="materia-left-info">
          <div class="materia-avatar ${avatarClass}" id="config-avatar-${m.materiaId}">
            <i class="fa-solid ${avatarIcon}"></i>
          </div>
          <div class="materia-title-group">
            <div class="materia-nombre-text" title="${m.materiaNombre}">
              ${m.materiaNombre}
            </div>
            <div class="materia-badges-group">
              <span class="docente-badge" title="Docente que imparte la materia en este curso">
                <i class="fa-solid fa-chalkboard-user"></i> ${m.docenteNombre || 'Docente sin asignar'}
              </span>
              <span class="horas-badge" title="Horas pedagógicas semanales según el horario alimentado">
                <i class="fa-regular fa-clock"></i> ${m.horasSemanales || 1} h/semana
              </span>
            </div>
          </div>
        </div>

        <!-- Lado Derecho: Controles Directos -->
        <div class="materia-right-controls">
          
          <!-- Switch Toma Examen -->
          <div class="switch-container" title="Active o desactive si esta materia rinde examen en este curso">
            <span class="switch-label-title">¿Examen?</span>
            <label class="switch-ios">
              <input type="checkbox" id="config-switch-${m.materiaId}" ${tomaExamen ? 'checked' : ''} onchange="window.configCambiarTomaExamen(${m.materiaId}, this.checked)">
              <span class="slider"></span>
            </label>
            <span class="switch-text-val ${tomaExamen ? 'val-si' : 'val-no'}" id="config-switch-val-${m.materiaId}">
              ${tomaExamen ? 'SÍ' : 'NO'}
            </span>
          </div>

          <!-- Botón 1-Click Dificultad -->
          <div title="Haga un solo clic para alternar de inmediato entre FÁCIL y DIFÍCIL">
            <button type="button" 
                    class="btn-dificultad-toggle ${esDificil ? 'btn-dificil' : 'btn-facil'}" 
                    id="config-btn-dif-${m.materiaId}" 
                    ${!tomaExamen ? 'disabled' : ''}
                    onclick="window.configToggleDificultadMateria(${m.materiaId})">
              <i class="fa-solid ${esDificil ? 'fa-fire' : 'fa-feather'}"></i>
              <span>${esDificil ? 'DIFÍCIL' : 'FÁCIL'}</span>
            </button>
          </div>

          <!-- Indicador visual de guardado -->
          <div class="save-indicator" id="config-save-ind-${m.materiaId}">
            <i class="fa-solid fa-check"></i>
          </div>

        </div>
      `;

      configMateriasListContainer.appendChild(row);
    });
  }

  // ACCIONES EN WINDOW PARA CONFIGURACIÓN DE MATERIAS
  window.configCambiarTomaExamen = async (materiaId, checked) => {
    const cursoId = configSelectCurso.value;
    if (!cursoId) return;

    const materia = currentConfigCursoMaterias.find(m => m.materiaId === materiaId);
    if (!materia) return;

    materia.tomaExamen = checked;
    materia.seleccionada = checked;

    const row = document.getElementById(`config-row-materia-${materiaId}`);
    const switchValText = document.getElementById(`config-switch-val-${materiaId}`);
    const btnDif = document.getElementById(`config-btn-dif-${materiaId}`);
    const avatar = document.getElementById(`config-avatar-${materiaId}`);

    if (row) {
      if (checked) {
        row.classList.remove('inactive-row');
        row.classList.add('active-row');
      } else {
        row.classList.remove('active-row');
        row.classList.add('inactive-row');
      }
    }

    if (switchValText) {
      switchValText.textContent = checked ? 'SÍ' : 'NO';
      switchValText.className = `switch-text-val ${checked ? 'val-si' : 'val-no'}`;
    }

    const dif = (materia.dificultad || materia.tipoComplejidad || 'FACIL').toUpperCase();
    const esDificil = (dif === 'DIFICIL' || dif === 'COMPLEJA');

    if (btnDif) {
      btnDif.disabled = !checked;
    }

    if (avatar) {
      avatar.className = `materia-avatar ${!checked ? 'inactiva' : (esDificil ? 'dificil' : 'facil')}`;
      avatar.innerHTML = `<i class="fa-solid ${!checked ? 'fa-ban' : (esDificil ? 'fa-fire' : 'fa-feather')}"></i>`;
    }

    actualizarConfigMetricas();
    mostrarConfigIndicadorGuardado(materiaId);

    try {
      await API.actualizarConfiguracionMateriaCurso(cursoId, materiaId, {
        tomaExamen: checked,
        dificultad: materia.dificultad || (esDificil ? 'DIFICIL' : 'FACIL')
      });
      App.showToast(`"${materia.materiaNombre}": ${checked ? 'Se incluye en exámenes' : 'Excluida de exámenes'}`, 'info', 1800);
    } catch (err) {
      App.showToast(`Error al guardar: ${err.message}`, 'error');
    }
  };

  window.configToggleDificultadMateria = async (materiaId) => {
    const cursoId = configSelectCurso.value;
    if (!cursoId) return;

    const materia = currentConfigCursoMaterias.find(m => m.materiaId === materiaId);
    if (!materia || materia.tomaExamen === false) return;

    const actual = (materia.dificultad || materia.tipoComplejidad || 'FACIL').toUpperCase();
    const nuevo = (actual === 'DIFICIL' || actual === 'COMPLEJA') ? 'FACIL' : 'DIFICIL';

    materia.dificultad = nuevo;
    materia.tipoComplejidad = nuevo;

    const esDificil = (nuevo === 'DIFICIL');

    const btnDif = document.getElementById(`config-btn-dif-${materiaId}`);
    const avatar = document.getElementById(`config-avatar-${materiaId}`);

    if (btnDif) {
      btnDif.className = `btn-dificultad-toggle ${esDificil ? 'btn-dificil' : 'btn-facil'}`;
      btnDif.innerHTML = `
        <i class="fa-solid ${esDificil ? 'fa-fire' : 'fa-feather'}"></i>
        <span>${esDificil ? 'DIFÍCIL' : 'FÁCIL'}</span>
      `;
    }

    if (avatar) {
      avatar.className = `materia-avatar ${esDificil ? 'dificil' : 'facil'}`;
      avatar.innerHTML = `<i class="fa-solid ${esDificil ? 'fa-fire' : 'fa-feather'}"></i>`;
    }

    actualizarConfigMetricas();
    mostrarConfigIndicadorGuardado(materiaId);

    try {
      await API.actualizarConfiguracionMateriaCurso(cursoId, materiaId, {
        tomaExamen: materia.tomaExamen !== false,
        dificultad: nuevo
      });
      App.showToast(`"${materia.materiaNombre}" ahora es ${esDificil ? '🔴 DIFÍCIL' : '🟢 FÁCIL'}`, 'info', 1800);
    } catch (err) {
      App.showToast(`Error al actualizar dificultad: ${err.message}`, 'error');
    }
  };

  // Start
  init();
});
