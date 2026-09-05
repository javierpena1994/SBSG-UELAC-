/* ==========================================================
   SISTEMA DE CRONOGRAMA DE ACTIVIDADES INSTITUCIONALES SBSG
   ========================================================== */

document.addEventListener('DOMContentLoaded', async () => {
  // Elements
  const tabBtnCalendario = document.getElementById('tab-btn-calendario');
  const tabBtnLista = document.getElementById('tab-btn-lista');
  const sectionCalendario = document.getElementById('section-calendario');
  const sectionLista = document.getElementById('section-lista');

  const btnNuevaActividadTop = document.getElementById('btn-nueva-actividad-top');
  const btnMesPrev = document.getElementById('btn-mes-prev');
  const btnMesHoy = document.getElementById('btn-mes-hoy');
  const btnMesNext = document.getElementById('btn-mes-next');
  const txtMesAnio = document.getElementById('txt-mes-anio');
  const calendarDaysContainer = document.getElementById('calendar-days-container');

  const filterCategoria = document.getElementById('filter-categoria');
  const filterEstado = document.getElementById('filter-estado');
  const filterDirigido = document.getElementById('filter-dirigido');
  const listaActividadesTbody = document.getElementById('lista-actividades-tbody');

  const btnImprimirTop = document.getElementById('btn-imprimir-cronograma-top');
  const btnImprimirList = document.getElementById('btn-imprimir-cronograma-list');

  // Modal Actividad
  const modalActividad = document.getElementById('modal-actividad');
  const modalActividadTitle = document.getElementById('modal-actividad-title');
  const formActividad = document.getElementById('form-actividad');
  const btnCerrarModal = document.getElementById('btn-cerrar-modal');
  const btnCancelarModal = document.getElementById('btn-cancelar-modal');

  const inputActId = document.getElementById('actividad-id');
  const inputTitulo = document.getElementById('actividad-titulo');
  const selectCategoria = document.getElementById('actividad-categoria');
  const selectEstado = document.getElementById('actividad-estado');
  const inputFechaInicio = document.getElementById('actividad-fecha-inicio');
  const inputFechaFin = document.getElementById('actividad-fecha-fin');
  const inputHoraInicio = document.getElementById('actividad-hora-inicio');
  const inputHoraFin = document.getElementById('actividad-hora-fin');
  const inputResponsable = document.getElementById('actividad-responsable');
  const selectDirigido = document.getElementById('actividad-dirigido');
  const textareaDescripcion = document.getElementById('actividad-descripcion');

  // Modal Detalle
  const modalDetalle = document.getElementById('modal-detalle');
  const detalleTitulo = document.getElementById('detalle-titulo');
  const detalleBody = document.getElementById('detalle-body');
  const btnCerrarDetalle = document.getElementById('btn-cerrar-detalle');
  const btnEditarDesdeDetalle = document.getElementById('btn-editar-desde-detalle');
  const btnEliminarDesdeDetalle = document.getElementById('btn-eliminar-desde-detalle');

  // State
  let currentDate = new Date(); // Year & Month of Calendar
  let actividadesCache = [];
  let selectedActividadParaDetalle = null;

  const NOMBRES_MESES = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
  ];

  const CATEGORIA_LABELS = {
    'ACADEMICO': { label: 'Académico', color: '#2563eb' },
    'EVALUACION': { label: 'Evaluación / Exámenes', color: '#2563eb' },
    'CIVICO_CULTURAL': { label: 'Cívico / Cultural', color: '#16a34a' },
    'DEPORTIVO': { label: 'Deportivo', color: '#ea580c' },
    'PASTORAL': { label: 'Pastoral / Institucional', color: '#9333ea' },
    'FERIADO': { label: 'Feriado / Vacaciones', color: '#dc2626' },
    'REUNION_PADRES': { label: 'Reunión de Padres', color: '#ca8a04' }
  };

  // Initialize
  async function init() {
    setupEventListeners();
    await reloadData();

    if (window.location.hash === '#lista') {
      switchTab('lista');
    } else if (window.location.hash === '#nueva') {
      switchTab('calendario');
      openModalActividad();
    } else {
      switchTab('calendario');
    }
  }

  // Switch Tabs
  function switchTab(tab) {
    if (tab === 'calendario') {
      tabBtnCalendario.classList.add('active');
      tabBtnLista.classList.remove('active');
      sectionCalendario.style.display = 'block';
      sectionLista.style.display = 'none';
      window.location.hash = '#calendario';
    } else {
      tabBtnLista.classList.add('active');
      tabBtnCalendario.classList.remove('active');
      sectionLista.style.display = 'block';
      sectionCalendario.style.display = 'none';
      window.location.hash = '#lista';
      renderListaView();
    }
  }

  function setupEventListeners() {
    tabBtnCalendario.addEventListener('click', () => switchTab('calendario'));
    tabBtnLista.addEventListener('click', () => switchTab('lista'));

    btnNuevaActividadTop.addEventListener('click', () => openModalActividad());

    btnMesPrev.addEventListener('click', () => {
      currentDate.setMonth(currentDate.getMonth() - 1);
      reloadData();
    });

    btnMesHoy.addEventListener('click', () => {
      currentDate = new Date();
      reloadData();
    });

    btnMesNext.addEventListener('click', () => {
      currentDate.setMonth(currentDate.getMonth() + 1);
      reloadData();
    });

    filterCategoria.addEventListener('change', renderListaView);
    filterEstado.addEventListener('change', renderListaView);
    filterDirigido.addEventListener('change', renderListaView);

    btnImprimirTop.addEventListener('click', () => window.print());
    btnImprimirList.addEventListener('click', () => window.print());

    // Modal Actividad Events
    btnCerrarModal.addEventListener('click', closeModalActividad);
    btnCancelarModal.addEventListener('click', closeModalActividad);
    formActividad.addEventListener('submit', handleGuardarActividad);

    // Modal Detalle Events
    btnCerrarDetalle.addEventListener('click', closeModalDetalle);
    btnEditarDesdeDetalle.addEventListener('click', () => {
      closeModalDetalle();
      if (selectedActividadParaDetalle) {
        openModalActividad(selectedActividadParaDetalle);
      }
    });
    btnEliminarDesdeDetalle.addEventListener('click', async () => {
      if (!selectedActividadParaDetalle) return;
      if (confirm(`¿Está seguro de que desea eliminar la actividad "${selectedActividadParaDetalle.titulo}"?`)) {
        try {
          await API.eliminarActividadCronograma(selectedActividadParaDetalle.id);
          App.showToast('Actividad eliminada del cronograma.', 'success');
          closeModalDetalle();
          reloadData();
        } catch (err) {
          App.showToast('Error al eliminar: ' + err.message, 'error');
        }
      }
    });
  }

  // Reload All Data
  async function reloadData() {
    const year = currentDate.getFullYear();
    const month = currentDate.getMonth();

    txtMesAnio.textContent = `${NOMBRES_MESES[month]} ${year}`;

    // Get First and Last Date to display in calendar
    const firstDayOfMonth = new Date(year, month, 1);
    const lastDayOfMonth = new Date(year, month + 1, 0);

    const startDateStr = new Date(year, month, -6).toISOString().split('T')[0];
    const endDateStr = new Date(year, month + 1, 7).toISOString().split('T')[0];

    try {
      const data = await API.getActividadesCronogramaRango(startDateStr, endDateStr);
      actividadesCache = data || [];
      renderCalendarView();
      renderListaView();
    } catch (err) {
      console.error('Error cargando cronograma:', err);
      App.showToast('Error al cargar actividades: ' + err.message, 'error');
    }
  }

  // Render Calendar Grid
  function renderCalendarView() {
    calendarDaysContainer.innerHTML = '';

    const year = currentDate.getFullYear();
    const month = currentDate.getMonth();

    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);

    // Monday-based indexing: (0 = Lun, 6 = Dom)
    let startDayOfWeek = firstDay.getDay() - 1;
    if (startDayOfWeek === -1) startDayOfWeek = 6;

    const todayStr = new Date().toISOString().split('T')[0];

    // Previous month filler days
    const prevMonthLastDay = new Date(year, month, 0).getDate();
    for (let i = startDayOfWeek - 1; i >= 0; i--) {
      const dayNum = prevMonthLastDay - i;
      const prevDate = new Date(year, month - 1, dayNum);
      const dateStr = prevDate.toISOString().split('T')[0];
      calendarDaysContainer.appendChild(createDayCell(dayNum, dateStr, true, dateStr === todayStr));
    }

    // Current month days
    for (let d = 1; d <= lastDay.getDate(); d++) {
      const curDate = new Date(year, month, d);
      const dateStr = curDate.toISOString().split('T')[0];
      calendarDaysContainer.appendChild(createDayCell(d, dateStr, false, dateStr === todayStr));
    }

    // Next month filler days to complete grid (multiples of 7)
    const totalCells = calendarDaysContainer.children.length;
    const remaining = (7 - (totalCells % 7)) % 7;
    for (let n = 1; n <= remaining; n++) {
      const nextDate = new Date(year, month + 1, n);
      const dateStr = nextDate.toISOString().split('T')[0];
      calendarDaysContainer.appendChild(createDayCell(n, dateStr, true, dateStr === todayStr));
    }
  }

  // Create Individual Day Cell
  function createDayCell(dayNumber, dateStr, isOtherMonth, isToday) {
    const cell = document.createElement('div');
    cell.className = `calendar-day-cell ${isOtherMonth ? 'other-month' : ''} ${isToday ? 'today' : ''}`;
    cell.dataset.date = dateStr;

    cell.innerHTML = `
      <div style="display:flex; justify-content:space-between; align-items:center;">
        <span class="day-number">${dayNumber}</span>
      </div>
      <div class="events-list-cell"></div>
    `;

    const eventsList = cell.querySelector('.events-list-cell');

    // Find activities happening on this date
    const dayActivities = actividadesCache.filter(a => {
      const ini = a.fechaInicio;
      const fin = a.fechaFin || a.fechaInicio;
      return dateStr >= ini && dateStr <= fin;
    });

    dayActivities.forEach(act => {
      const chip = document.createElement('div');
      chip.className = 'event-chip';
      const catInfo = CATEGORIA_LABELS[act.categoria] || { color: act.color || '#2563eb' };
      chip.style.backgroundColor = act.color || catInfo.color;
      chip.title = `${act.titulo} (${act.responsable || 'Institucional'})`;

      chip.innerHTML = `
        <i class="fa-solid fa-circle" style="font-size:6px;"></i>
        <span>${act.titulo}</span>
      `;

      chip.addEventListener('click', (e) => {
        e.stopPropagation();
        openModalDetalle(act);
      });

      eventsList.appendChild(chip);
    });

    // Click on empty space of day -> New activity on that date
    cell.addEventListener('click', () => {
      openModalActividad({ fechaInicio: dateStr, fechaFin: dateStr });
    });

    return cell;
  }

  // Render Table / List View
  function renderListaView() {
    const catFiltro = filterCategoria.value;
    const estFiltro = filterEstado.value;
    const dirFiltro = filterDirigido.value;

    const filtered = actividadesCache.filter(a => {
      const matchCat = catFiltro === 'TODAS' || a.categoria === catFiltro;
      const matchEst = estFiltro === 'TODOS' || a.estado === estFiltro;
      const matchDir = dirFiltro === 'TODOS' || a.dirigidoA === dirFiltro;
      return matchCat && matchEst && matchDir;
    });

    listaActividadesTbody.innerHTML = '';

    if (filtered.length === 0) {
      listaActividadesTbody.innerHTML = `
        <tr>
          <td colspan="7" style="text-align:center; padding:24px; color:var(--text-muted);">
            No hay actividades que coincidan con los filtros seleccionados.
          </td>
        </tr>
      `;
      return;
    }

    filtered.forEach(act => {
      const tr = document.createElement('tr');

      const catInfo = CATEGORIA_LABELS[act.categoria] || { label: act.categoria, color: '#2563eb' };
      const badgeCat = `<span class="badge" style="background:${catInfo.color}15; color:${catInfo.color}; border:1px solid ${catInfo.color}40; font-weight:700;">${catInfo.label}</span>`;

      const estadoColor = act.estado === 'FINALIZADO' ? '#16a34a' : act.estado === 'EN_CURSO' ? '#ea580c' : '#2563eb';
      const badgeEstado = `<span class="badge" style="background:${estadoColor}15; color:${estadoColor}; font-weight:700;">${act.estado}</span>`;

      let fechaDisplay = App.formatDateDisplay(act.fechaInicio);
      if (act.fechaFin && act.fechaFin !== act.fechaInicio) {
        fechaDisplay += ` al ${App.formatDateDisplay(act.fechaFin)}`;
      }

      tr.innerHTML = `
        <td style="font-weight:700; font-size:12.5px; color:var(--primary);">
          ${fechaDisplay}
          ${act.horaInicio ? `<div style="font-size:11.5px; color:#64748b; font-weight:normal;">${act.horaInicio} - ${act.horaFin || ''}</div>` : ''}
        </td>
        <td>
          <div style="font-weight:700; font-size:13.5px; color:var(--text-main);">${act.titulo}</div>
          ${act.descripcion ? `<div style="font-size:12px; color:var(--text-muted); margin-top:2px;">${act.descripcion}</div>` : ''}
        </td>
        <td>${badgeCat}</td>
        <td style="font-size:12.5px; font-weight:600;">${act.responsable || 'Institucional'}</td>
        <td style="font-size:12.5px;"><span class="badge" style="background:#f1f5f9; color:#475569;">${act.dirigidoA || 'Todos'}</span></td>
        <td style="text-align:center;">${badgeEstado}</td>
        <td style="text-align:center;" class="no-print">
          <div style="display:inline-flex; gap:6px;">
            <button type="button" class="btn btn-secondary btn-sm btn-edit-act" style="padding:4px 8px;" title="Editar">
              <i class="fa-solid fa-pen-to-square" style="color:var(--primary);"></i>
            </button>
            <button type="button" class="btn btn-secondary btn-sm btn-del-act" style="padding:4px 8px; color:#dc2626;" title="Eliminar">
              <i class="fa-solid fa-trash-can"></i>
            </button>
          </div>
        </td>
      `;

      tr.querySelector('.btn-edit-act').addEventListener('click', () => openModalActividad(act));
      tr.querySelector('.btn-del-act').addEventListener('click', async () => {
        if (confirm(`¿Desea eliminar la actividad "${act.titulo}"?`)) {
          try {
            await API.eliminarActividadCronograma(act.id);
            App.showToast('Actividad eliminada.', 'success');
            reloadData();
          } catch (err) {
            App.showToast('Error al eliminar: ' + err.message, 'error');
          }
        }
      });

      listaActividadesTbody.appendChild(tr);
    });
  }

  // Open Activity Modal (New or Edit)
  function openModalActividad(act = null) {
    if (act && act.id) {
      modalActividadTitle.textContent = 'Editar Actividad del Cronograma';
      inputActId.value = act.id;
      inputTitulo.value = act.titulo || '';
      selectCategoria.value = act.categoria || 'ACADEMICO';
      selectEstado.value = act.estado || 'PLANIFICADO';
      inputFechaInicio.value = act.fechaInicio || '';
      inputFechaFin.value = act.fechaFin || act.fechaInicio || '';
      inputHoraInicio.value = act.horaInicio || '';
      inputHoraFin.value = act.horaFin || '';
      inputResponsable.value = act.responsable || '';
      selectDirigido.value = act.dirigidoA || 'TODOS';
      textareaDescripcion.value = act.descripcion || '';
    } else {
      modalActividadTitle.textContent = 'Registrar Nueva Actividad Institucional';
      formActividad.reset();
      inputActId.value = '';
      const defaultDate = act && act.fechaInicio ? act.fechaInicio : new Date().toISOString().split('T')[0];
      inputFechaInicio.value = defaultDate;
      inputFechaFin.value = defaultDate;
      selectCategoria.value = 'ACADEMICO';
      selectEstado.value = 'PLANIFICADO';
      selectDirigido.value = 'TODOS';
    }

    modalActividad.style.display = 'flex';
    inputTitulo.focus();
  }

  function closeModalActividad() {
    modalActividad.style.display = 'none';
  }

  // Handle Save Activity
  async function handleGuardarActividad(e) {
    e.preventDefault();

    const payload = {
      titulo: inputTitulo.value.trim(),
      categoria: selectCategoria.value,
      estado: selectEstado.value,
      fechaInicio: inputFechaInicio.value,
      fechaFin: inputFechaFin.value || inputFechaInicio.value,
      horaInicio: inputHoraInicio.value.trim(),
      horaFin: inputHoraFin.value.trim(),
      responsable: inputResponsable.value.trim(),
      dirigidoA: selectDirigido.value,
      descripcion: textareaDescripcion.value.trim()
    };

    const id = inputActId.value;

    try {
      if (id) {
        await API.actualizarActividadCronograma(id, payload);
        App.showToast('✅ Actividad actualizada exitosamente.', 'success');
      } else {
        await API.crearActividadCronograma(payload);
        App.showToast('✅ Nueva actividad registrada en el cronograma.', 'success');
      }

      closeModalActividad();
      await reloadData();
    } catch (err) {
      App.showToast('Error al guardar actividad: ' + err.message, 'error');
    }
  }

  // Open Activity Detail Quick View
  function openModalDetalle(act) {
    selectedActividadParaDetalle = act;
    detalleTitulo.textContent = act.titulo;

    const catInfo = CATEGORIA_LABELS[act.categoria] || { label: act.categoria, color: '#2563eb' };

    let fechaRango = App.formatDateDisplay(act.fechaInicio);
    if (act.fechaFin && act.fechaFin !== act.fechaInicio) {
      fechaRango += ` al ${App.formatDateDisplay(act.fechaFin)}`;
    }

    detalleBody.innerHTML = `
      <div style="display:flex; gap:8px; margin-bottom:12px;">
        <span class="badge" style="background:${catInfo.color}; color:#fff; font-weight:700;">${catInfo.label}</span>
        <span class="badge" style="background:#e2e8f0; color:#334155; font-weight:700;">${act.estado}</span>
      </div>
      <div style="margin-bottom:8px;">
        <strong><i class="fa-regular fa-calendar" style="color:var(--primary); margin-right:6px;"></i> Fecha:</strong> ${fechaRango}
      </div>
      ${act.horaInicio ? `
        <div style="margin-bottom:8px;">
          <strong><i class="fa-regular fa-clock" style="color:var(--primary); margin-right:6px;"></i> Horario:</strong> ${act.horaInicio} - ${act.horaFin || ''}
        </div>
      ` : ''}
      <div style="margin-bottom:8px;">
        <strong><i class="fa-solid fa-user-tie" style="color:var(--primary); margin-right:6px;"></i> Responsable:</strong> ${act.responsable || 'Institucional'}
      </div>
      <div style="margin-bottom:12px;">
        <strong><i class="fa-solid fa-users" style="color:var(--primary); margin-right:6px;"></i> Dirigido A:</strong> ${act.dirigidoA || 'Toda la institución'}
      </div>
      ${act.descripcion ? `
        <div style="background:#f8fafc; border:1px solid var(--border); padding:10px 12px; border-radius:6px; margin-top:8px;">
          <strong>Detalles:</strong>
          <div style="margin-top:4px; color:#475569;">${act.descripcion}</div>
        </div>
      ` : ''}
    `;

    modalDetalle.style.display = 'flex';
  }

  function closeModalDetalle() {
    modalDetalle.style.display = 'none';
    selectedActividadParaDetalle = null;
  }

  // Start
  init();
});

