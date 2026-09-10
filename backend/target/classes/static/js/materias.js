/* ==========================================================
   SISTEMA DE GESTIÓN DE CONTINGENCIAS SBSG - MATERIAS & EXÁMENES JS
   ========================================================== */

document.addEventListener('DOMContentLoaded', async () => {
  // Estado global de la vista
  let cursosList = [];
  let cursoSeleccionadoId = null;
  let materiasCursoActual = [];
  let materiasCatalogoList = [];

  // Elementos de la Pestaña 1: Configuración por Curso
  const selectCurso = document.getElementById('select-curso-config');
  const pillsContainer = document.getElementById('course-pills-container');
  const listaContainer = document.getElementById('lista-materias-curso-container');
  const listTitle = document.getElementById('curso-list-title');
  const countBadge = document.getElementById('curso-materias-count-badge');

  // Elementos de Métricas
  const metricTotal = document.getElementById('metric-total-materias');
  const metricToman = document.getElementById('metric-toman-examen');
  const metricDificiles = document.getElementById('metric-dificiles');
  const metricFaciles = document.getElementById('metric-faciles');
  const metricNoExamen = document.getElementById('metric-no-examen');

  // Elementos de la Pestaña 2: Catálogo General
  const tableBody = document.getElementById('materias-tbody');
  const searchInput = document.getElementById('search-materia');
  const totalBadge = document.getElementById('total-materias-badge');

  // Modal Catálogo
  const modal = document.getElementById('modal-materia');
  const modalTitle = document.getElementById('modal-materia-title');
  const formMateria = document.getElementById('form-materia');
  const btnNuevaMateria = document.getElementById('btn-nueva-materia');
  const btnCerrarModal = document.getElementById('btn-cerrar-modal');
  const btnCancelar = document.getElementById('btn-cancelar-materia');
  const btnGuardar = document.getElementById('btn-guardar-materia');
  const inputId = document.getElementById('materia-id');
  const inputNombre = document.getElementById('materia-nombre');
  const inputAplicaExamen = document.getElementById('materia-aplica-examen');

  // -------------------------------------------------------------------------
  // PESTAÑAS
  // -------------------------------------------------------------------------
  window.cambiarPestana = (tab) => {
    const btnCurso = document.getElementById('tab-btn-curso');
    const btnCat = document.getElementById('tab-btn-catalogo');
    const contentCurso = document.getElementById('tab-content-curso');
    const contentCat = document.getElementById('tab-content-catalogo');

    if (tab === 'curso') {
      btnCurso.classList.add('active');
      btnCat.classList.remove('active');
      contentCurso.style.display = 'block';
      contentCat.style.display = 'none';
    } else {
      btnCat.classList.add('active');
      btnCurso.classList.remove('active');
      contentCat.style.display = 'block';
      contentCurso.style.display = 'none';
      if (materiasCatalogoList.length === 0) {
        loadCatalogoMaterias();
      }
    }
  };

  // -------------------------------------------------------------------------
  // INICIALIZACIÓN DE CURSOS
  // -------------------------------------------------------------------------
  async function initCursos() {
    try {
      cursosList = await API.getCursos();
      // Ordenar cursos por ID o nivel
      cursosList.sort((a, b) => a.id - b.id);

      selectCurso.innerHTML = '<option value="">-- Seleccione un curso --</option>';
      pillsContainer.innerHTML = '';

      cursosList.forEach((c, idx) => {
        // Opción dropdown
        const opt = document.createElement('option');
        opt.value = c.id;
        opt.textContent = c.nombre;
        selectCurso.appendChild(opt);

        // Pastilla rápida
        const pill = document.createElement('button');
        pill.type = 'button';
        pill.className = 'course-pill' + (idx === 0 ? ' active' : '');
        pill.id = `pill-curso-${c.id}`;
        pill.textContent = c.nombre;
        pill.onclick = () => seleccionarCurso(c.id);
        pillsContainer.appendChild(pill);
      });

      // Seleccionar por defecto el primer curso (o el que se prefiera)
      if (cursosList.length > 0) {
        seleccionarCurso(cursosList[0].id);
      }
    } catch (err) {
      App.showToast('Error cargando cursos: ' + err.message, 'error');
    }
  }

  // -------------------------------------------------------------------------
  // SELECCIÓN Y CARGA DE MATERIAS POR CURSO
  // -------------------------------------------------------------------------
  async function seleccionarCurso(cursoId) {
    if (!cursoId) return;
    cursoSeleccionadoId = Number(cursoId);
    selectCurso.value = cursoSeleccionadoId;

    // Actualizar clase activa en pastillas
    document.querySelectorAll('.course-pill').forEach(p => p.classList.remove('active'));
    const activePill = document.getElementById(`pill-curso-${cursoSeleccionadoId}`);
    if (activePill) activePill.classList.add('active');

    const cursoObj = cursosList.find(c => c.id === cursoSeleccionadoId);
    const nomCurso = cursoObj ? cursoObj.nombre : `Curso #${cursoSeleccionadoId}`;
    listTitle.innerHTML = `<i class="fa-solid fa-graduation-cap" style="color:var(--primary); margin-right:6px;"></i> Materias de <strong>${nomCurso}</strong>`;

    listaContainer.innerHTML = `
      <div style="text-align:center; padding: 40px 20px; color: var(--text-muted);">
        <i class="fa-solid fa-spinner fa-spin" style="font-size:24px; color:var(--primary); margin-bottom:10px;"></i>
        <div>Cargando materias del horario alimentado...</div>
      </div>
    `;

    try {
      materiasCursoActual = await API.getMateriasEvaluacionCurso(cursoSeleccionadoId);
      renderMateriasCurso();
      actualizarMetricas();
    } catch (err) {
      listaContainer.innerHTML = `
        <div style="text-align:center; padding: 30px; color: #dc2626;">
          <i class="fa-solid fa-triangle-exclamation" style="font-size:24px; margin-bottom:8px;"></i>
          <div>Error cargando materias: ${err.message}</div>
        </div>
      `;
    }
  }

  selectCurso.addEventListener('change', (e) => {
    if (e.target.value) {
      seleccionarCurso(e.target.value);
    }
  });

  // -------------------------------------------------------------------------
  // RENDERIZADO DE MATERIAS POR CURSO
  // -------------------------------------------------------------------------
  function renderMateriasCurso() {
    listaContainer.innerHTML = '';
    countBadge.textContent = `${materiasCursoActual.length} materias`;

    if (!materiasCursoActual || materiasCursoActual.length === 0) {
      listaContainer.innerHTML = `
        <div style="text-align:center; padding: 40px; color: var(--text-muted);">
          <i class="fa-solid fa-folder-open" style="font-size:32px; margin-bottom:10px; opacity:0.5;"></i>
          <div>No se encontraron materias registradas en el horario de este curso.</div>
        </div>
      `;
      return;
    }

    materiasCursoActual.forEach(m => {
      const row = document.createElement('div');
      const tomaExamen = (m.tomaExamen === true || m.seleccionada === true);
      const dificultad = (m.dificultad || m.tipoComplejidad || 'FACIL').toUpperCase();
      const esDificil = (dificultad === 'DIFICIL' || dificultad === 'COMPLEJA');

      row.className = `materia-card-row ${tomaExamen ? 'active-row' : 'inactive-row'}`;
      row.id = `row-materia-${m.materiaId}`;

      const avatarClass = !tomaExamen ? 'inactiva' : (esDificil ? 'dificil' : 'facil');
      const avatarIcon = !tomaExamen ? 'fa-ban' : (esDificil ? 'fa-fire' : 'fa-feather');

      row.innerHTML = `
        <!-- Lado Izquierdo: Info de la Materia -->
        <div class="materia-left-info">
          <div class="materia-avatar ${avatarClass}" id="avatar-${m.materiaId}">
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
              <input type="checkbox" id="switch-examen-${m.materiaId}" ${tomaExamen ? 'checked' : ''} onchange="window.cambiarTomaExamen(${m.materiaId}, this.checked)">
              <span class="slider"></span>
            </label>
            <span class="switch-text-val ${tomaExamen ? 'val-si' : 'val-no'}" id="switch-val-text-${m.materiaId}">
              ${tomaExamen ? 'SÍ' : 'NO'}
            </span>
          </div>

          <!-- Botón 1-Click Dificultad -->
          <div title="Haga un solo clic para alternar de inmediato entre FÁCIL y DIFÍCIL">
            <button type="button" 
                    class="btn-dificultad-toggle ${esDificil ? 'btn-dificil' : 'btn-facil'}" 
                    id="btn-dif-${m.materiaId}" 
                    ${!tomaExamen ? 'disabled' : ''}
                    onclick="window.toggleDificultadMateria(${m.materiaId})">
              <i class="fa-solid ${esDificil ? 'fa-fire' : 'fa-feather'}"></i>
              <span>${esDificil ? 'DIFÍCIL' : 'FÁCIL'}</span>
            </button>
          </div>

          <!-- Indicador visual de guardado -->
          <div class="save-indicator" id="save-ind-${m.materiaId}">
            <i class="fa-solid fa-check"></i>
          </div>

        </div>
      `;

      listaContainer.appendChild(row);
    });
  }

  // -------------------------------------------------------------------------
  // ACCIÓN 1: CAMBIAR SWITCH "TOMA EXAMEN"
  // -------------------------------------------------------------------------
  window.cambiarTomaExamen = async (materiaId, checked) => {
    const materia = materiasCursoActual.find(m => m.materiaId === materiaId);
    if (!materia) return;

    // Actualizar estado local
    materia.tomaExamen = checked;
    materia.seleccionada = checked;

    // Actualizar UI inmediata
    const row = document.getElementById(`row-materia-${materiaId}`);
    const switchValText = document.getElementById(`switch-val-text-${materiaId}`);
    const btnDif = document.getElementById(`btn-dif-${materiaId}`);
    const avatar = document.getElementById(`avatar-${materiaId}`);

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

    const dificultad = (materia.dificultad || 'FACIL').toUpperCase();
    const esDificil = (dificultad === 'DIFICIL');

    if (btnDif) {
      btnDif.disabled = !checked;
    }

    if (avatar) {
      avatar.className = `materia-avatar ${!checked ? 'inactiva' : (esDificil ? 'dificil' : 'facil')}`;
      avatar.innerHTML = `<i class="fa-solid ${!checked ? 'fa-ban' : (esDificil ? 'fa-fire' : 'fa-feather')}"></i>`;
    }

    actualizarMetricas();
    mostrarIndicadorGuardado(materiaId);

    // Persistir de inmediato en backend
    try {
      await API.actualizarConfiguracionMateriaCurso(cursoSeleccionadoId, materiaId, {
        tomaExamen: checked,
        dificultad: materia.dificultad
      });
      App.showToast(`"${materia.materiaNombre}": ${checked ? 'Se incluye en exámenes' : 'Excluida de exámenes'}`, 'info', 2000);
    } catch (err) {
      App.showToast(`Error al guardar: ${err.message}`, 'error');
    }
  };

  // -------------------------------------------------------------------------
  // ACCIÓN 2: TOGGLE 1-CLICK DIFICULTAD (FÁCIL <-> DIFÍCIL)
  // -------------------------------------------------------------------------
  window.toggleDificultadMateria = async (materiaId) => {
    const materia = materiasCursoActual.find(m => m.materiaId === materiaId);
    if (!materia || materia.tomaExamen === false) return;

    const actual = (materia.dificultad || 'FACIL').toUpperCase();
    const nuevo = (actual === 'DIFICIL') ? 'FACIL' : 'DIFICIL';

    // Actualizar estado local
    materia.dificultad = nuevo;
    materia.tipoComplejidad = nuevo;

    const esDificil = (nuevo === 'DIFICIL');

    // Actualizar UI inmediata
    const btnDif = document.getElementById(`btn-dif-${materiaId}`);
    const avatar = document.getElementById(`avatar-${materiaId}`);

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

    actualizarMetricas();
    mostrarIndicadorGuardado(materiaId);

    // Persistir de inmediato en backend
    try {
      await API.actualizarConfiguracionMateriaCurso(cursoSeleccionadoId, materiaId, {
        tomaExamen: materia.tomaExamen,
        dificultad: nuevo
      });
      App.showToast(`"${materia.materiaNombre}" cambiada a ${nuevo === 'DIFICIL' ? '🔴 DIFÍCIL' : '🟢 FÁCIL'}`, 'info', 2000);
    } catch (err) {
      App.showToast(`Error actualizando dificultad: ${err.message}`, 'error');
    }
  };

  function mostrarIndicadorGuardado(materiaId) {
    const ind = document.getElementById(`save-ind-${materiaId}`);
    if (ind) {
      ind.classList.add('show');
      setTimeout(() => ind.classList.remove('show'), 1500);
    }
  }

  // -------------------------------------------------------------------------
  // MÉTRICAS EN TIEMPO REAL
  // -------------------------------------------------------------------------
  function actualizarMetricas() {
    const total = materiasCursoActual.length;
    const toman = materiasCursoActual.filter(m => m.tomaExamen !== false).length;
    const noToman = total - toman;
    const dificiles = materiasCursoActual.filter(m => m.tomaExamen !== false && (m.dificultad === 'DIFICIL' || m.tipoComplejidad === 'COMPLEJA')).length;
    const faciles = toman - dificiles;

    if (metricTotal) metricTotal.textContent = total;
    if (metricToman) metricToman.textContent = toman;
    if (metricDificiles) metricDificiles.textContent = dificiles;
    if (metricFaciles) metricFaciles.textContent = faciles;
    if (metricNoExamen) metricNoExamen.textContent = noToman;
  }

  // -------------------------------------------------------------------------
  // PESTAÑA 2: CATÁLOGO GENERAL DE MATERIAS
  // -------------------------------------------------------------------------
  async function loadCatalogoMaterias() {
    try {
      materiasCatalogoList = await API.getMaterias();
      renderCatalogoTable();
    } catch (err) {
      App.showToast('Error cargando catálogo de materias: ' + err.message, 'error');
    }
  }

  function renderCatalogoTable() {
    tableBody.innerHTML = '';
    const search = (searchInput.value || '').toLowerCase().trim();

    const filtered = materiasCatalogoList.filter(m => {
      if (!search) return true;
      const nom = (m.nombre || '').toLowerCase();
      return nom.includes(search);
    });

    totalBadge.textContent = `${filtered.length} de ${materiasCatalogoList.length} materias`;

    if (filtered.length === 0) {
      tableBody.innerHTML = '<tr><td colspan="4" style="text-align:center; padding:24px; color:var(--text-muted);">No se encontraron materias con el término de búsqueda ingresado.</td></tr>';
      return;
    }

    filtered.forEach(m => {
      const tr = document.createElement('tr');
      const aplica = m.aplicaExamen !== false;

      tr.innerHTML = `
        <td><strong>#${m.id}</strong></td>
        <td style="font-weight:700; color:var(--primary); font-size:13.5px;">${m.nombre}</td>
        <td style="text-align:center;">
          <button type="button" class="btn-toggle-examen ${aplica ? 'active' : 'inactive'}" onclick="window.toggleExamenMateriaCatalogo(${m.id})" title="Haga clic para alternar si esta materia aplica examen en general">
            <i class="fa-solid ${aplica ? 'fa-circle-check' : 'fa-circle-xmark'}"></i>
            <span>${aplica ? 'Sí aplica examen' : 'No aplica examen'}</span>
          </button>
        </td>
        <td style="text-align:center; white-space:nowrap;">
          <button type="button" class="btn btn-secondary btn-sm" onclick="window.editarMateriaCatalogo(${m.id})" style="padding:4px 12px; font-size:12px; margin-right:6px; display:inline-flex; align-items:center; gap:4px;">
            <i class="fa-solid fa-pen-to-square"></i> Editar
          </button>
          <button type="button" class="btn btn-danger btn-sm" onclick="window.eliminarMateriaCatalogo(${m.id})" style="padding:4px 12px; font-size:12px; display:inline-flex; align-items:center; gap:4px;">
            <i class="fa-solid fa-trash-can"></i> Eliminar
          </button>
        </td>
      `;
      tableBody.appendChild(tr);
    });
  }

  window.toggleExamenMateriaCatalogo = async (id) => {
    const materia = materiasCatalogoList.find(m => m.id === id);
    if (!materia) return;

    try {
      const updated = await API.toggleExamenMateria(id);
      materia.aplicaExamen = updated.aplicaExamen;
      renderCatalogoTable();
      App.showToast(`Materia "${materia.nombre}": ${materia.aplicaExamen ? 'Ahora SÍ aplica examen' : 'Marcada como NO aplica examen'}`, 'info');
    } catch (err) {
      App.showToast('Error actualizando estado de examen: ' + err.message, 'error');
    }
  };

  function openModal(materia = null) {
    if (materia) {
      modalTitle.textContent = 'Editar Materia / Asignatura';
      inputId.value = materia.id;
      inputNombre.value = materia.nombre;
      if (inputAplicaExamen) inputAplicaExamen.checked = (materia.aplicaExamen !== false);
    } else {
      modalTitle.textContent = 'Registrar Nueva Materia / Asignatura';
      inputId.value = '';
      inputNombre.value = '';
      if (inputAplicaExamen) inputAplicaExamen.checked = true;
    }
    modal.style.display = 'flex';
    setTimeout(() => inputNombre.focus(), 100);
  }

  function closeModal() {
    modal.style.display = 'none';
  }

  window.editarMateriaCatalogo = (id) => {
    const materia = materiasCatalogoList.find(m => m.id === id);
    if (materia) openModal(materia);
  };

  window.eliminarMateriaCatalogo = async (id) => {
    const materia = materiasCatalogoList.find(m => m.id === id);
    if (!materia) return;

    const confirm = App.confirmDialog(`¿Está seguro de que desea eliminar la materia "${materia.nombre}"?\n\nNota: Si la materia está asignada a horarios, el sistema impedirá el borrado por seguridad.`);
    if (!confirm) return;

    try {
      await API.eliminarMateria(id);
      App.showToast(`Materia "${materia.nombre}" eliminada exitosamente.`, 'success');
      await loadCatalogoMaterias();
    } catch (err) {
      App.showToast('No se pudo eliminar: ' + err.message, 'error', 5000);
    }
  };

  // Form Submit Catálogo
  formMateria.addEventListener('submit', async (e) => {
    e.preventDefault();

    const nombre = inputNombre.value.trim().toUpperCase();
    if (!nombre) {
      App.showToast('El nombre de la materia es requerido.', 'warning');
      return;
    }

    const id = inputId.value;
    const payload = {
      nombre: nombre,
      aplicaExamen: inputAplicaExamen ? inputAplicaExamen.checked : true
    };

    try {
      btnGuardar.disabled = true;
      btnGuardar.textContent = 'Guardando...';

      if (id) {
        await API.actualizarMateria(id, payload);
        App.showToast('Materia actualizada correctamente.', 'success');
      } else {
        await API.crearMateria(payload);
        App.showToast('Materia creada exitosamente.', 'success');
      }

      closeModal();
      await loadCatalogoMaterias();
      // Si estamos en la vista de curso, recargar también
      if (cursoSeleccionadoId) {
        seleccionarCurso(cursoSeleccionadoId);
      }
    } catch (err) {
      App.showToast('Error al guardar materia: ' + err.message, 'error');
    } finally {
      btnGuardar.disabled = false;
      btnGuardar.textContent = 'Guardar Materia';
    }
  });

  // Event Listeners Catálogo
  btnNuevaMateria.addEventListener('click', () => {
    window.cambiarPestana('catalogo');
    openModal();
  });
  btnCerrarModal.addEventListener('click', closeModal);
  btnCancelar.addEventListener('click', closeModal);

  modal.addEventListener('click', (e) => {
    if (e.target === modal) closeModal();
  });

  searchInput.addEventListener('input', renderCatalogoTable);

  // Carga inicial
  await initCursos();
});
