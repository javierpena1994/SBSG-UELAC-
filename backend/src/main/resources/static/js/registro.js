/* ==========================================================
   SISTEMA DE GESTIÓN DE CONTINGENCIAS SBSG - REGISTRO JS (MULTI-HORA)
   ========================================================== */

document.addEventListener('DOMContentLoaded', async () => {
  // Elementos del DOM
  const form = document.getElementById('form-contingencia');
  const fechaInput = document.getElementById('fecha');
  const diaSemanaBadge = document.getElementById('dia-semana-badge');
  const docenteAusenteSelect = document.getElementById('docente-ausente');
  const observacionInput = document.getElementById('observacion');

  // Herramientas de horas clase
  const clasesQuickBar = document.getElementById('clases-quick-bar');
  const numHorasInput = document.getElementById('num-horas-input');
  const btnSelectAllClases = document.getElementById('btn-select-all-clases');
  const btnDeselectAllClases = document.getElementById('btn-deselect-all-clases');
  const clasesLoading = document.getElementById('clases-loading');
  const clasesEmpty = document.getElementById('clases-empty');
  const clasesListContainer = document.getElementById('clases-list-container');
  const clasesSummaryBadge = document.getElementById('clases-summary-badge');
  const btnSubmitText = document.getElementById('btn-submit-text');
  const btnLimpiar = document.getElementById('btn-limpiar');
  const conflictAlertBox = document.getElementById('contingencia-conflict-alert');
  const conflictAlertText = document.getElementById('contingencia-conflict-text');

  // Panel lateral de Docentes Disponibles
  const activeHoraIndicator = document.getElementById('active-hora-indicator');
  const activeHoraText = document.getElementById('active-hora-text');
  const candidatesLoading = document.getElementById('candidates-loading');
  const candidatesEmpty = document.getElementById('candidates-empty');
  const candidatesContainer = document.getElementById('candidates-list');

  // Estado global del registro
  let catalogos = {
    docentes: [],
    cursos: [],
    materias: [],
    franjasHorarias: []
  };

  let clasesDocente = [];
  let activeClaseIndex = -1;
  let candidateTeachers = [];

  // 1. Carga Inicial de Catálogos
  async function init() {
    try {
      const [docentes, cursos, materias, franjas] = await Promise.all([
        API.getDocentes(),
        API.getCursos(),
        API.getMaterias(),
        API.getFranjas()
      ]);

      catalogos = {
        docentes: (docentes || []).filter(d => d.activo !== false),
        cursos: cursos || [],
        materias: materias || [],
        franjasHorarias: franjas || []
      };

      // Poblar select de docente ausente
      docenteAusenteSelect.innerHTML = '<option value="">-- Seleccione docente ausente --</option>';
      catalogos.docentes.forEach(d => {
        const opt = document.createElement('option');
        opt.value = d.id;
        opt.textContent = d.nombreCompleto;
        docenteAusenteSelect.appendChild(opt);
      });

      // Establecer fecha de hoy por defecto
      const today = new Date().toISOString().split('T')[0];
      fechaInput.value = today;
      updateDiaSemana();

    } catch (err) {
      console.error('Error cargando catálogos:', err);
      App.showToast('Error cargando datos del sistema: ' + err.message, 'error');
    }
  }

  // 2. Actualizar día de la semana
  function updateDiaSemana() {
    const fecha = fechaInput.value;
    if (!fecha) {
      diaSemanaBadge.textContent = '';
      return;
    }
    const dia = App.getDiaSemana(fecha);
    diaSemanaBadge.textContent = `Día: ${dia}`;
  }

  // 3. Cargar las horas clase del docente ausente para la fecha seleccionada
  async function loadClasesDocenteAusente() {
    const fecha = fechaInput.value;
    const docenteId = docenteAusenteSelect.value;

    clasesDocente = [];
    activeClaseIndex = -1;
    clasesListContainer.innerHTML = '';
    candidatesContainer.innerHTML = '';
    if (conflictAlertBox) conflictAlertBox.style.display = 'none';

    if (!fecha || !docenteId) {
      clasesQuickBar.style.display = 'none';
      clasesEmpty.style.display = 'block';
      clasesEmpty.innerHTML = '<i class="fa-solid fa-calendar-day" style="font-size:24px; color:#94a3b8; display:block; margin-bottom:8px;"></i>Seleccione una fecha y el docente ausente para cargar sus horas de clase correspondientes.';
      updateClasesSummary();
      resetCandidatesPanel('Seleccione una hora clase de la izquierda para evaluar los docentes disponibles.');
      return;
    }

    const diaSemana = App.getDiaSemana(fecha);

    try {
      clasesEmpty.style.display = 'none';
      clasesLoading.style.display = 'block';

      const scheduleSlots = await API.getHorarioClasesDocente(docenteId);
      clasesLoading.style.display = 'none';

      // Filtrar únicamente los slots correspondientes al día de la semana y que sean horas de clase
      const daySlots = (scheduleSlots || []).filter(s => {
        const matchDia = s.diaSemana && s.diaSemana.toLowerCase() === diaSemana.toLowerCase();
        return matchDia && s.esClase === true;
      });

      // Ordenar cronológicamente por franja horaria
      daySlots.sort((a, b) => {
        const fa = catalogos.franjasHorarias.find(f => f.id === a.franjaHorariaId);
        const fb = catalogos.franjasHorarias.find(f => f.id === b.franjaHorariaId);
        const oa = fa ? fa.orden : a.franjaHorariaId;
        const ob = fb ? fb.orden : b.franjaHorariaId;
        return oa - ob;
      });

      if (daySlots.length === 0) {
        clasesQuickBar.style.display = 'none';
        clasesEmpty.style.display = 'block';
        clasesEmpty.innerHTML = `<i class="fa-solid fa-circle-info" style="font-size:24px; color:#3b82f6; display:block; margin-bottom:8px;"></i>El docente seleccionado no tiene horas de clase asignadas para los días <strong>${diaSemana}</strong>.`;
        updateClasesSummary();
        resetCandidatesPanel('El docente no tiene clases este día.');
        return;
      }

      // Mapear al modelo de clases de contingencia
      clasesDocente = daySlots.map((s, idx) => {
        const franjaObj = catalogos.franjasHorarias.find(f => f.id === s.franjaHorariaId);
        const ordenNum = franjaObj ? franjaObj.orden : (idx + 1);
        const horaTime = franjaObj ? franjaObj.etiqueta : (s.franjaHorariaEtiqueta || '');
        const horaTitle = `${ordenNum}° Hora (${horaTime})`;

        const cursoObj = catalogos.cursos.find(c => c.id === s.cursoId);
        const cursoNombre = cursoObj ? cursoObj.nombre : (s.cursoNombre || 'Sin curso asignado');
        const nivel = App.getNivelCurso(cursoNombre);

        const materiaObj = catalogos.materias.find(m => m.id === s.materiaId);
        const materiaNombre = materiaObj ? materiaObj.nombre : (s.materiaNombre || s.actividad || 'CLASE GENERAL');

        return {
          id: `clase_${idx}`,
          index: idx,
          franjaHorariaId: s.franjaHorariaId,
          orden: ordenNum,
          horaTime: horaTime,
          horaTitle: horaTitle,
          cursoId: s.cursoId || (catalogos.cursos.length > 0 ? catalogos.cursos[0].id : null),
          cursoNombre: cursoNombre,
          cursoNivel: nivel,
          materiaId: s.materiaId || (catalogos.materias.length > 0 ? catalogos.materias[0].id : null),
          materiaNombre: materiaNombre,
          actividad: s.actividad || '',
          seleccionada: true, // Por defecto todas seleccionadas para cubrir
          docenteReemplazo: null
        };
      });

      // Configurar barra rápida
      clasesQuickBar.style.display = 'flex';
      numHorasInput.max = clasesDocente.length;
      numHorasInput.value = clasesDocente.length;

      // Renderizar tarjetas de clases
      renderClasesCards();

      // Enfocar la primera clase para evaluar candidatos
      setActiveClase(0);

    } catch (err) {
      clasesLoading.style.display = 'none';
      clasesEmpty.style.display = 'block';
      clasesEmpty.textContent = 'Error al cargar horario del docente: ' + err.message;
      App.showToast('Error cargando horario: ' + err.message, 'error');
    }
  }

  // 4. Renderizar tarjetas de clases
  function renderClasesCards() {
    clasesListContainer.innerHTML = '';

    clasesDocente.forEach((c, idx) => {
      const card = document.createElement('div');

      let stateClass = 'is-unassigned';
      if (!c.seleccionada) {
        stateClass = 'is-unchecked';
      } else if (c.docenteReemplazo) {
        stateClass = 'is-assigned';
      }

      const isActive = idx === activeClaseIndex;
      card.className = `clase-item-card ${stateClass} ${isActive ? 'is-active' : ''}`;
      card.dataset.index = idx;

      // Badge de reemplazante
      let reemplazoHtml = '';
      if (!c.seleccionada) {
        reemplazoHtml = `<span style="color:#94a3b8; font-size:11px; font-weight:600;"><i class="fa-solid fa-ban" style="margin-right:4px;"></i>No a cubrir</span>`;
      } else if (c.docenteReemplazo) {
        reemplazoHtml = `
          <div class="reemplazo-assigned-tag" title="${c.docenteReemplazo.nombreCompleto}">
            <i class="fa-solid fa-circle-check" style="font-size:12px; flex-shrink:0;"></i>
            <span class="reemplazo-assigned-name">${c.docenteReemplazo.nombreCompleto}</span>
            <button type="button" class="btn-icon" title="Quitar este docente" onclick="window.quitarReemplazoClase(${idx}, event)" style="background:none; border:none; cursor:pointer; color:#dc2626; padding:0 2px; font-size:11px; flex-shrink:0;">
              <i class="fa-solid fa-xmark"></i>
            </button>
          </div>
        `;
      } else {
        reemplazoHtml = `
          <div class="reemplazo-pending-tag">
            <i class="fa-solid fa-user-plus" style="font-size:11px;"></i>
            <span>Asignar Reemplazo</span>
          </div>
        `;
      }

      card.innerHTML = `
        <div class="clase-chk-col">
          <input type="checkbox" class="clase-checkbox" data-index="${idx}" ${c.seleccionada ? 'checked' : ''} style="width:16px; height:16px; cursor:pointer;" title="Marcar/desmarcar hora a cubrir">
        </div>
        <div class="clase-time-box">
          <div class="clase-time-num">${c.orden}° Hora Clase</div>
          <div class="clase-time-hour">${c.horaTime}</div>
        </div>
        <div class="clase-details">
          <div class="clase-materia-title" title="${c.materiaNombre}">${c.materiaNombre}</div>
          <div class="clase-curso-sub" title="${c.cursoNombre}">
            <span class="badge" style="background:#e0e7ff; color:#3730a3; font-weight:700;"><i class="fa-solid fa-graduation-cap" style="margin-right:3px;"></i>${c.cursoNombre}</span>
            <span class="badge" style="background:#f1f5f9; color:#475569; font-size:9.5px;">${c.cursoNivel}</span>
          </div>
        </div>
        <div class="clase-right-action">
          ${reemplazoHtml}
        </div>
      `;

      // Evento de clic en la tarjeta para activarla
      card.addEventListener('click', (e) => {
        if (e.target.closest('.clase-checkbox') || e.target.closest('button')) {
          return; // Dejar que el checkbox o botón maneje su propio evento
        }
        if (!c.seleccionada) {
          c.seleccionada = true;
          const chk = card.querySelector('.clase-checkbox');
          if (chk) chk.checked = true;
          updateClasesSummary();
        }
        setActiveClase(idx);
      });

      // Evento de checkbox
      const chk = card.querySelector('.clase-checkbox');
      if (chk) {
        chk.addEventListener('change', (e) => {
          e.stopPropagation();
          c.seleccionada = chk.checked;
          if (!c.seleccionada) {
            c.docenteReemplazo = null; // Limpiar asignación si se desmarca
          }
          renderClasesCards();
          updateClasesSummary();

          if (c.seleccionada) {
            setActiveClase(idx);
          } else if (activeClaseIndex === idx) {
            // Buscar la siguiente clase seleccionada
            const nextIdx = clasesDocente.findIndex(cl => cl.seleccionada);
            if (nextIdx !== -1) {
              setActiveClase(nextIdx);
            } else {
              activeClaseIndex = -1;
              resetCandidatesPanel('Ninguna hora seleccionada para cubrir.');
            }
          }
        });
      }

      clasesListContainer.appendChild(card);
    });

    updateClasesSummary();
  }

  // 5. Establecer clase activa para buscar candidatos
  function setActiveClase(index) {
    if (index < 0 || index >= clasesDocente.length) return;
    activeClaseIndex = index;

    const activeClase = clasesDocente[activeClaseIndex];

    // Actualizar estilo de tarjetas activas
    const cards = clasesListContainer.querySelectorAll('.clase-item-card');
    cards.forEach((card, i) => {
      if (i === activeClaseIndex) {
        card.classList.add('is-active');
      } else {
        card.classList.remove('is-active');
      }
    });

    // Actualizar texto del panel de candidatos
    activeHoraText.innerHTML = `Evaluando: <strong>${activeClase.horaTitle}</strong> — ${activeClase.materiaNombre} (${activeClase.cursoNombre})`;

    // Consultar candidatos disponibles para esta clase específica
    fetchCandidatesForActiveClass();
  }

  // 6. Consultar Docentes Disponibles para la Clase Activa
  async function fetchCandidatesForActiveClass() {
    if (activeClaseIndex < 0 || activeClaseIndex >= clasesDocente.length) return;

    const activeClase = clasesDocente[activeClaseIndex];
    const fecha = fechaInput.value;
    const docenteAusenteId = docenteAusenteSelect.value;

    try {
      candidatesLoading.style.display = 'block';
      candidatesEmpty.style.display = 'none';
      candidatesContainer.innerHTML = '';

      candidateTeachers = await API.getDisponibles(fecha, activeClase.franjaHorariaId, docenteAusenteId, activeClase.cursoId);
      candidatesLoading.style.display = 'none';

      if (!candidateTeachers || candidateTeachers.length === 0) {
        candidatesEmpty.style.display = 'block';
        candidatesEmpty.textContent = `No se encontraron docentes disponibles para la ${activeClase.horaTitle}.`;
        return;
      }

      renderCandidateCards(candidateTeachers, activeClase);

    } catch (err) {
      candidatesLoading.style.display = 'none';
      candidatesEmpty.style.display = 'block';
      candidatesEmpty.textContent = 'Error al consultar docentes disponibles: ' + err.message;
    }
  }

  // 7. Renderizar tarjetas de candidatos
  function renderCandidateCards(teachers, activeClase) {
    candidatesContainer.innerHTML = '';
    const currentAssignedId = activeClase.docenteReemplazo ? activeClase.docenteReemplazo.id : null;

    teachers.forEach(t => {
      const card = document.createElement('div');
      const isSelected = currentAssignedId && currentAssignedId === t.id;
      const isAvailable = t.disponibleSegunHorario && !t.ocupadoPorOtraContingencia;

      card.className = `candidate-card ${isSelected ? 'selected' : ''} ${!isAvailable ? 'disabled' : ''}`;

      let priorityBadgeHtml = '';
      if (t.categoriaPrioridad === 'MISMO_NIVEL') {
        priorityBadgeHtml = `<span class="badge" style="background:#15803d; color:#fff; font-weight:700;"><i class="fa-solid fa-star" style="margin-right:2px;"></i>MISMO NIVEL</span>`;
      } else if (t.categoriaPrioridad === 'OTRO_NIVEL') {
        priorityBadgeHtml = `<span class="badge" style="background:#0284c7; color:#fff; font-weight:600;"><i class="fa-solid fa-arrows-rotate" style="margin-right:2px;"></i>OTRO NIVEL</span>`;
      } else if (t.categoriaPrioridad === 'AUTORIDAD') {
        priorityBadgeHtml = `<span class="badge" style="background:#7e22ce; color:#fff; font-weight:600;"><i class="fa-solid fa-building-columns" style="margin-right:2px;"></i>AUTORIDAD</span>`;
      }

      let statusBadgeHtml = '';
      if (t.ocupadoPorOtraContingencia) {
        statusBadgeHtml = `<span class="badge badge-busy"><i class="fa-solid fa-lock" style="margin-right:2px;"></i>En otra</span>`;
      } else if (!t.disponibleSegunHorario) {
        statusBadgeHtml = `<span class="badge badge-class"><i class="fa-solid fa-xmark" style="margin-right:2px;"></i>Ocupado</span>`;
      } else {
        statusBadgeHtml = `<span class="badge badge-available"><i class="fa-solid fa-check" style="margin-right:2px;"></i>Libre</span>`;
      }

      card.innerHTML = `
        <div class="candidate-main">
          <div class="candidate-name" title="${t.nombreCompleto}">
            ${t.nombreCompleto}
          </div>
          <div class="candidate-badge-group">
            ${priorityBadgeHtml}
            ${statusBadgeHtml}
            <span class="badge badge-workload"><i class="fa-solid fa-clock-rotate-left" style="margin-right:2px;"></i>${t.totalReemplazosRecientes} reemplazos</span>
          </div>
        </div>
        <div>
          <button type="button" class="btn-select-candidate" ${t.ocupadoPorOtraContingencia ? 'disabled' : ''} style="display:inline-flex; align-items:center; justify-content:center; gap:4px;">
            ${isSelected ? '<i class="fa-solid fa-circle-check"></i> Asignado' : 'Asignar'}
          </button>
        </div>
      `;

      card.addEventListener('click', () => {
        if (t.ocupadoPorOtraContingencia) {
          App.showToast('Este docente ya está asignado a otra contingencia en este mismo horario.', 'warning');
          return;
        }
        assignTeacherToActiveClass(t);
      });

      candidatesContainer.appendChild(card);
    });
  }

  // 8. Asignar docente a la clase activa y avanzar a la siguiente pendiente
  function assignTeacherToActiveClass(teacher) {
    if (activeClaseIndex < 0 || activeClaseIndex >= clasesDocente.length) return;

    const currentClase = clasesDocente[activeClaseIndex];
    currentClase.docenteReemplazo = {
      id: teacher.id,
      nombreCompleto: teacher.nombreCompleto
    };

    App.showToast(`✓ ${teacher.nombreCompleto} asignado para ${currentClase.horaTitle}`, 'success', 2000);

    // Re-renderizar tarjetas para reflejar estado
    renderClasesCards();

    // Buscar automáticamente la siguiente clase seleccionada que aún no tenga reemplazante asignado
    let nextIdx = -1;
    for (let i = activeClaseIndex + 1; i < clasesDocente.length; i++) {
      if (clasesDocente[i].seleccionada && !clasesDocente[i].docenteReemplazo) {
        nextIdx = i;
        break;
      }
    }
    // Si no encontró hacia adelante, buscar desde el principio
    if (nextIdx === -1) {
      for (let i = 0; i < activeClaseIndex; i++) {
        if (clasesDocente[i].seleccionada && !clasesDocente[i].docenteReemplazo) {
          nextIdx = i;
          break;
        }
      }
    }

    if (nextIdx !== -1) {
      setActiveClase(nextIdx);
    } else {
      // Todas las horas seleccionadas ya están asignadas
      renderClasesCards();
      fetchCandidatesForActiveClass(); // Refrescar vista actual
    }
  }

  // Quitar asignación de una clase específica
  window.quitarReemplazoClase = (index, event) => {
    if (event) event.stopPropagation();
    if (index >= 0 && index < clasesDocente.length) {
      clasesDocente[index].docenteReemplazo = null;
      renderClasesCards();
      setActiveClase(index);
    }
  };

  // 9. Actualizar resumen de selección y estado del botón de guardar
  function updateClasesSummary() {
    const selected = clasesDocente.filter(c => c.seleccionada);
    const assigned = selected.filter(c => c.docenteReemplazo !== null);

    const totalSelected = selected.length;
    const totalAssigned = assigned.length;

    clasesSummaryBadge.textContent = `${totalSelected} horas clase seleccionadas (${totalAssigned} con reemplazo)`;

    if (totalSelected === 0) {
      clasesSummaryBadge.className = 'badge badge-class';
      btnSubmitText.textContent = 'Guardar Contingencias (0 horas)';
    } else if (totalAssigned === totalSelected) {
      clasesSummaryBadge.className = 'badge badge-available';
      btnSubmitText.textContent = `Guardar ${totalSelected} Contingencia(s) Completa(s)`;
    } else {
      clasesSummaryBadge.className = 'badge badge-busy';
      btnSubmitText.textContent = `Guardar (${totalAssigned} de ${totalSelected} asignadas)`;
    }
  }

  function resetCandidatesPanel(msg) {
    activeHoraIndicator.style.display = 'flex';
    activeHoraText.textContent = msg;
    candidatesLoading.style.display = 'none';
    candidatesEmpty.style.display = 'block';
    candidatesEmpty.textContent = msg;
    candidatesContainer.innerHTML = '';
  }

  // 10. Selección Rápida por Cantidad de Horas
  numHorasInput.addEventListener('input', () => {
    const count = parseInt(numHorasInput.value) || 0;
    clasesDocente.forEach((c, idx) => {
      c.seleccionada = idx < count;
      if (!c.seleccionada) c.docenteReemplazo = null;
    });
    renderClasesCards();
    if (clasesDocente.length > 0 && clasesDocente[0].seleccionada) {
      setActiveClase(0);
    }
  });

  btnSelectAllClases.addEventListener('click', () => {
    numHorasInput.value = clasesDocente.length;
    clasesDocente.forEach(c => c.seleccionada = true);
    renderClasesCards();
    if (clasesDocente.length > 0) setActiveClase(0);
  });

  btnDeselectAllClases.addEventListener('click', () => {
    numHorasInput.value = 0;
    clasesDocente.forEach(c => {
      c.seleccionada = false;
      c.docenteReemplazo = null;
    });
    renderClasesCards();
    activeClaseIndex = -1;
    resetCandidatesPanel('Ninguna hora seleccionada para cubrir.');
  });

  // 11. Envío y Registro en Lote de las Contingencias
  form.addEventListener('submit', async (e) => {
    e.preventDefault();

    const fecha = fechaInput.value;
    const docenteAusenteId = docenteAusenteSelect.value;
    const observacion = observacionInput.value.trim();
    const recursos = document.querySelector('input[name="recursos"]:checked')?.value || 'NO';

    if (!fecha || !docenteAusenteId) {
      App.showToast('Por favor seleccione la fecha y el docente ausente.', 'warning');
      return;
    }

    if (!observacion) {
      App.showToast('Por favor ingrese el motivo u observación de la inasistencia.', 'warning');
      observacionInput.focus();
      return;
    }

    const selectedClases = clasesDocente.filter(c => c.seleccionada);

    if (selectedClases.length === 0) {
      App.showToast('Debe seleccionar al menos una hora clase a cubrir.', 'warning');
      return;
    }

    // Validar que todas las clases seleccionadas tengan reemplazante asignado
    const unassignedClases = selectedClases.filter(c => !c.docenteReemplazo);
    if (unassignedClases.length > 0) {
      const missingTitles = unassignedClases.map(c => c.horaTitle).join(', ');
      App.showToast(`Falta asignar docente de reemplazo en: ${missingTitles}`, 'warning', 5000);
      // Enfocar la primera clase sin asignar
      const firstUnassignedIdx = clasesDocente.findIndex(c => c.seleccionada && !c.docenteReemplazo);
      if (firstUnassignedIdx !== -1) setActiveClase(firstUnassignedIdx);
      return;
    }

    // Construir lista de payloads
    const diaSemana = App.getDiaSemana(fecha);
    const requests = selectedClases.map(c => ({
      fecha: fecha,
      diaSemana: diaSemana,
      docenteAusenteId: Number(docenteAusenteId),
      docenteReemplazoId: Number(c.docenteReemplazo.id),
      franjaHorariaId: Number(c.franjaHorariaId),
      cursoId: Number(c.cursoId),
      materiaId: Number(c.materiaId),
      recursos: recursos,
      periodos: 1, // Cada período cuenta como 1 hora pedagógica
      observacion: observacion
    }));

    const btnSubmit = document.getElementById('btn-guardar-lote');

    try {
      btnSubmit.disabled = true;
      btnSubmit.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Registrando contingencias...';

      await API.crearContingenciasLote(requests);

      App.showToast(`🎉 ¡Se registraron exitosamente ${requests.length} contingencias de reemplazo!`, 'success', 4000);

      // Limpiar formulario y recargar
      setTimeout(() => {
        window.location.href = 'historial.html';
      }, 1200);

    } catch (err) {
      btnSubmit.disabled = false;
      btnSubmit.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Guardar Contingencias';
      App.showToast('Error al registrar contingencias: ' + err.message, 'error', 6000);
    }
  });

  // Limpiar formulario completo
  btnLimpiar.addEventListener('click', () => {
    form.reset();
    const today = new Date().toISOString().split('T')[0];
    fechaInput.value = today;
    updateDiaSemana();
    loadClasesDocenteAusente();
  });

  // Event Listeners de Cambio
  fechaInput.addEventListener('change', () => {
    updateDiaSemana();
    loadClasesDocenteAusente();
  });

  docenteAusenteSelect.addEventListener('change', loadClasesDocenteAusente);

  // Inicializar
  await init();
});
