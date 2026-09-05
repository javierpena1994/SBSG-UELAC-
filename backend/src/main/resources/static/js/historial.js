/* ==========================================================
   SISTEMA DE GESTIÓN DE CONTINGENCIAS SBSG - HISTORIAL Y REPORTES JS
   ========================================================== */

document.addEventListener('DOMContentLoaded', async () => {
  const fechaInicioInput = document.getElementById('rep-fecha-inicio');
  const fechaFinInput = document.getElementById('rep-fecha-fin');
  const docenteReemplazoSelect = document.getElementById('rep-docente-reemplazo');
  const docenteAusenteSelect = document.getElementById('rep-docente-ausente');
  const btnConsultar = document.getElementById('btn-consultar-reporte');
  const btnImprimir = document.getElementById('btn-imprimir-reporte');
  const btnGenerarImagen = document.getElementById('btn-generar-imagen');
  const printableReportCard = document.getElementById('printable-report-card');

  // Metricas KPI
  const kpiTotalHoras = document.getElementById('kpi-total-horas');
  const kpiTotalContingencias = document.getElementById('kpi-total-contingencias');
  const kpiConRecursos = document.getElementById('kpi-con-recursos');
  const kpiSinRecursos = document.getElementById('kpi-sin-recursos');

  // Reporte Detalle y Rankings
  const rankingReemplazos = document.getElementById('ranking-reemplazos-list');
  const rankingAusentes = document.getElementById('ranking-ausentes-list');
  const reportTableBody = document.getElementById('report-tbody');
  const reportPeriodoText = document.getElementById('report-periodo-text');

  // Modal de Detalle
  const modalDetalle = document.getElementById('modal-detalle-contingencia');
  const modalTitle = document.getElementById('modal-detalle-title');
  const modalFecha = document.getElementById('modal-det-fecha');
  const modalFranja = document.getElementById('modal-det-franja');
  const modalAusente = document.getElementById('modal-det-ausente');
  const modalReemplazo = document.getElementById('modal-det-reemplazo');
  const modalCurso = document.getElementById('modal-det-curso');
  const modalMateria = document.getElementById('modal-det-materia');
  const modalRecursos = document.getElementById('modal-det-recursos');
  const modalPeriodos = document.getElementById('modal-det-periodos');
  const modalObs = document.getElementById('modal-det-obs');
  const modalCreated = document.getElementById('modal-det-created');

  // Quick preset buttons
  const presetButtons = document.querySelectorAll('.preset-btn');

  let currentReportDetalles = [];
  let selectedContingenciaId = null;

  // Inicialmente campos vacíos para ver histórico general
  fechaInicioInput.value = '';
  fechaFinInput.value = '';

  async function loadDocentesFilter() {
    try {
      const docentes = await API.getDocentes();
      docenteReemplazoSelect.innerHTML = '<option value="">Todos los docentes</option>';
      docenteAusenteSelect.innerHTML = '<option value="">Todos los docentes</option>';

      docentes.forEach(d => {
        const opt1 = document.createElement('option');
        opt1.value = d.id;
        opt1.textContent = d.nombreCompleto;
        docenteReemplazoSelect.appendChild(opt1);

        const opt2 = document.createElement('option');
        opt2.value = d.id;
        opt2.textContent = d.nombreCompleto;
        docenteAusenteSelect.appendChild(opt2);
      });
    } catch (err) {
      console.error('Error cargando docentes para filtros de reporte:', err);
    }
  }

  async function generarReporte() {
    const params = {
      fechaInicio: fechaInicioInput.value || null,
      fechaFin: fechaFinInput.value || null,
      docenteReemplazoId: docenteReemplazoSelect.value || null,
      docenteAusenteId: docenteAusenteSelect.value || null
    };

    try {
      btnConsultar.disabled = true;
      btnConsultar.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Generando reporte...';

      const data = await API.getReporte(params);
      btnConsultar.disabled = false;
      btnConsultar.innerHTML = '<i class="fa-solid fa-chart-pie"></i> Generar Reporte';

      currentReportDetalles = data.detalles || [];

      // Actualizar texto periodo
      let periodoTexto = 'Período comprendido: Histórico general';
      if (params.fechaInicio && params.fechaFin) {
        periodoTexto = `Período comprendido: ${App.formatDateDisplay(params.fechaInicio)} al ${App.formatDateDisplay(params.fechaFin)}`;
      } else if (params.fechaInicio) {
        periodoTexto = `Período comprendido: Desde ${App.formatDateDisplay(params.fechaInicio)}`;
      } else if (params.fechaFin) {
        periodoTexto = `Período comprendido: Hasta ${App.formatDateDisplay(params.fechaFin)}`;
      }
      reportPeriodoText.textContent = periodoTexto;

      // Actualizar KPIs
      kpiTotalHoras.textContent = `${data.totalPeriodos || 0} h`;
      kpiTotalContingencias.textContent = data.totalContingencias || 0;
      kpiConRecursos.textContent = data.totalConRecursos || 0;
      kpiSinRecursos.textContent = data.totalSinRecursos || 0;

      // Renderizar Rankings
      renderRankings(data.resumenDocentesReemplazo, rankingReemplazos, 'Reemplazos');
      renderRankings(data.resumenDocentesAusentes, rankingAusentes, 'Inasistencias');

      // Renderizar Tabla Detallada
      renderReportTable(currentReportDetalles);

    } catch (err) {
      btnConsultar.disabled = false;
      btnConsultar.innerHTML = '<i class="fa-solid fa-chart-pie"></i> Generar Reporte';
      App.showToast('Error al generar reporte: ' + err.message, 'error');
    }
  }

  function renderRankings(items, container, type) {
    container.innerHTML = '';
    if (!items || items.length === 0) {
      container.innerHTML = '<div style="padding:12px; color:var(--text-muted); text-align:center;">No hay registros en el período</div>';
      return;
    }

    const maxHours = items[0].totalPeriodos || 1;

    items.slice(0, 8).forEach((item, index) => {
      const pct = Math.min(100, Math.round((item.totalPeriodos / maxHours) * 100));
      const row = document.createElement('div');
      row.className = 'ranking-row';
      row.innerHTML = `
        <div style="display:flex; align-items:center; gap:8px; width:60%;">
          <span style="font-weight:700; color:var(--text-muted); font-size:12px; width:18px;">#${index + 1}</span>
          <span class="name" style="white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="${item.nombreDocente}">${item.nombreDocente}</span>
        </div>
        <div style="display:flex; align-items:center; gap:12px;">
          <span style="font-size:12px; color:var(--text-muted);">${item.cantidadContingencias} ${type.toLowerCase()}</span>
          <span class="hours">${item.totalPeriodos} hrs</span>
        </div>
      `;
      container.appendChild(row);
    });
  }

  function renderReportTable(detalles) {
    reportTableBody.innerHTML = '';
    if (!detalles || detalles.length === 0) {
      reportTableBody.innerHTML = '<tr><td colspan="7" style="text-align:center; padding:24px; color:var(--text-muted);">No se encontraron contingencias en este rango de fechas.</td></tr>';
      return;
    }

    detalles.forEach(c => {
      const tr = document.createElement('tr');

      tr.innerHTML = `
        <td class="col-fecha">${App.formatFechaConDia(c.fecha, c.diaSemana)}</td>
        <td class="col-docente col-docente-ausente">${c.docenteAusenteNombre || '-'}</td>
        <td class="col-docente col-docente-reemplazo">${c.docenteReemplazoNombre || '-'}</td>
        <td class="col-franja"><span class="badge-franja">${c.franjaHorariaEtiqueta || '-'}</span></td>
        <td class="col-curso">${c.cursoNombre || '-'}</td>
        <td class="col-materia">${c.materiaNombre || '-'}</td>
        <td class="no-print" style="text-align: center; white-space: nowrap;">
          <button type="button" class="btn-icon" title="Ver Detalle Completo" onclick="window.verDetalleContingencia(${c.id})" style="color:var(--primary-light); margin-right:6px; cursor:pointer; font-size:14px; background:none; border:none; padding:4px;">
            <i class="fa-solid fa-eye"></i>
          </button>
          <button type="button" class="btn-icon" title="Eliminar Contingencia" onclick="window.eliminarContingencia(${c.id})" style="color:var(--danger); cursor:pointer; font-size:14px; background:none; border:none; padding:4px;">
            <i class="fa-solid fa-trash-can"></i>
          </button>
        </td>
      `;
      reportTableBody.appendChild(tr);
    });
  }

  // Ver Detalle de Contingencia en Modal
  window.verDetalleContingencia = (id) => {
    const item = currentReportDetalles.find(d => d.id === id);
    if (!item) return;

    selectedContingenciaId = id;
    modalTitle.textContent = `Detalle de Contingencia #${item.id}`;
    modalFecha.textContent = `${item.diaSemana ? item.diaSemana + ', ' : ''}${App.formatDateDisplay(item.fecha)}`;
    modalFranja.textContent = `${item.franjaHorariaEtiqueta || '-'} (${item.franjaHorariaInicio || ''} - ${item.franjaHorariaFin || ''})`;
    modalAusente.textContent = item.docenteAusenteNombre || '-';
    modalReemplazo.textContent = item.docenteReemplazoNombre || '-';
    modalCurso.textContent = item.cursoNombre || '-';
    modalMateria.textContent = item.materiaNombre || '-';

    const isSi = item.recursos === 'SI';
    modalRecursos.innerHTML = isSi
      ? '<span class="badge badge-si" style="background:#dcfce7; color:#15803d; padding:2px 8px; border-radius:12px; font-weight:700;">SI (Dejó Material)</span>'
      : '<span class="badge badge-no" style="background:#fee2e2; color:#991b1b; padding:2px 8px; border-radius:12px; font-weight:700;">NO (Sin Material)</span>';

    modalPeriodos.textContent = `${item.periodos || 1} hora(s) pedagógica(s)`;
    modalObs.textContent = item.observacion || 'Sin observación registrada.';
    modalCreated.textContent = item.createdAt ? new Date(item.createdAt).toLocaleString('es-EC') : '-';

    modalDetalle.style.display = 'flex';
  };

  window.cerrarModalDetalle = () => {
    modalDetalle.style.display = 'none';
    selectedContingenciaId = null;
  };

  // Cerrar modal al hacer clic en el backdrop
  modalDetalle.addEventListener('click', (e) => {
    if (e.target === modalDetalle) {
      window.cerrarModalDetalle();
    }
  });

  // Eliminar Contingencia desde la tabla
  window.eliminarContingencia = async (id) => {
    if (!App.confirmDialog(`¿Está seguro de que desea eliminar la contingencia #${id}? Esta acción descontará las horas registradas.`)) {
      return;
    }

    try {
      await API.eliminarContingencia(id);
      App.showToast(`Contingencia #${id} eliminada correctamente.`, 'success');
      await generarReporte();
    } catch (err) {
      App.showToast('Error al eliminar: ' + err.message, 'error');
    }
  };

  // Eliminar Contingencia desde el Modal
  window.eliminarDesdeModal = async () => {
    if (!selectedContingenciaId) return;
    const id = selectedContingenciaId;
    window.cerrarModalDetalle();
    await window.eliminarContingencia(id);
  };

  // Action Buttons
  btnConsultar.addEventListener('click', () => {
    generarReporte();
  });

  btnImprimir.addEventListener('click', () => window.print());

  btnGenerarImagen.addEventListener('click', async () => {
    try {
      btnGenerarImagen.disabled = true;
      btnGenerarImagen.textContent = 'Generando imagen JPG...';
      App.showToast('Generando imagen JPG (A4 con recuadros)...', 'info', 2000);

      let periodoTexto = 'Período comprendido: Histórico general';
      if (fechaInicioInput.value && fechaFinInput.value) {
        periodoTexto = `Período comprendido: ${App.formatDateDisplay(fechaInicioInput.value)} al ${App.formatDateDisplay(fechaFinInput.value)}`;
      } else if (fechaInicioInput.value) {
        periodoTexto = `Período comprendido: Desde ${App.formatDateDisplay(fechaInicioInput.value)}`;
      } else if (fechaFinInput.value) {
        periodoTexto = `Período comprendido: Hasta ${App.formatDateDisplay(fechaFinInput.value)}`;
      }

      // Construir filas de la tabla sin la columna de acciones para la imagen
      let tableRowsHtml = '';
      if (!currentReportDetalles || currentReportDetalles.length === 0) {
        tableRowsHtml = `
          <tr>
            <td colspan="6" style="border: 1px solid #94a3b8; padding: 16px; text-align: center; color: #64748b; font-size: 11px;">
              No se registraron contingencias en este período.
            </td>
          </tr>
        `;
      } else {
        currentReportDetalles.forEach((c, idx) => {
          const bg = idx % 2 === 0 ? '#ffffff' : '#f8fafc';
          tableRowsHtml += `
            <tr style="background-color: ${bg};">
              <td style="border: 1px solid #94a3b8; padding: 7px 6px; font-size: 10.5px; font-weight: 700; color: #0f172a; white-space: nowrap;">
                ${App.formatFechaConDia(c.fecha, c.diaSemana)}
              </td>
              <td style="border: 1px solid #94a3b8; padding: 7px 6px; font-size: 10.5px; font-weight: 700; color: #b91c1c;">
                ${c.docenteAusenteNombre || '-'}
              </td>
              <td style="border: 1px solid #94a3b8; padding: 7px 6px; font-size: 10.5px; font-weight: 700; color: #15803d;">
                ${c.docenteReemplazoNombre || '-'}
              </td>
              <td style="border: 1px solid #94a3b8; padding: 7px 6px; font-size: 10.5px; text-align: center;">
                <span style="background: #f1f5f9; border: 1px solid #cbd5e1; padding: 3px 6px; border-radius: 4px; font-weight: 700; color: #1e293b; white-space: nowrap; font-size: 10px; display: inline-block;">
                  ${c.franjaHorariaEtiqueta || '-'}
                </span>
              </td>
              <td style="border: 1px solid #94a3b8; padding: 7px 6px; font-size: 10.5px; text-align: center; font-weight: 700; color: #0f172a;">
                ${c.cursoNombre || '-'}
              </td>
              <td style="border: 1px solid #94a3b8; padding: 7px 6px; font-size: 10.5px; color: #0f172a;">
                ${c.materiaNombre || '-'}
              </td>
            </tr>
          `;
        });
      }

      // Crear contenedor temporal estructurado con proporciones y márgenes de hoja A4
      const a4Container = document.createElement('div');
      a4Container.id = 'temp-a4-export-card';
      a4Container.style.position = 'fixed';
      a4Container.style.left = '-9999px';
      a4Container.style.top = '0';
      a4Container.style.width = '820px';
      a4Container.style.minHeight = '1160px';
      a4Container.style.padding = '45px 50px';
      a4Container.style.backgroundColor = '#ffffff';
      a4Container.style.boxSizing = 'border-box';
      a4Container.style.fontFamily = "Arial, Helvetica, sans-serif";
      a4Container.style.color = '#0f172a';
      a4Container.style.zIndex = '-999';

      a4Container.innerHTML = `
        <div style="text-align: center; margin-bottom: 22px; border-bottom: 2px solid #0f172a; padding-bottom: 16px;">
          <img src="assets/logo.jpg" alt="Logo Institución" style="width: 76px; height: 76px; border-radius: 50%; object-fit: cover; border: 1px solid #cbd5e1; padding: 2px; margin-bottom: 10px; display: inline-block;">
          <div style="font-size: 16px; font-weight: bold; color: #0f172a; text-transform: uppercase; margin-bottom: 4px;">
            UNIDAD EDUCATIVA LOLA AROSEMENA DE CARBO
          </div>
          <div style="font-size: 13px; font-weight: bold; color: #334155; text-transform: uppercase; margin-bottom: 4px;">
            COORDINACIÓN PEDAGÓGICA
          </div>
          <div style="font-size: 13.5px; font-weight: bold; color: #1e3a8a; text-transform: uppercase; margin-bottom: 6px;">
            INFORME DE CONTINGENCIA Y COBERTURA DOCENTE
          </div>
          <div style="font-size: 11.5px; font-weight: bold; color: #64748b; margin-top: 4px;">
            ${periodoTexto}
          </div>
        </div>

        <div style="margin-top: 20px; margin-bottom: 15px;">
          <div style="font-size: 13px; font-weight: bold; color: #0f172a; text-transform: uppercase; margin-bottom: 10px;">
            DETALLE PORMENORIZADO DE CONTINGENCIAS DEL PERÍODO
          </div>
          <table style="width: 100%; border-collapse: collapse; table-layout: fixed; font-size: 10.5px; border: 1px solid #94a3b8;">
            <thead>
              <tr style="background-color: #e2e8f0; color: #0f172a; text-transform: uppercase; font-size: 10px; font-weight: bold;">
                <th style="width: 12%; border: 1px solid #94a3b8; padding: 8px 6px; text-align: left;">Fecha</th>
                <th style="width: 22%; border: 1px solid #94a3b8; padding: 8px 6px; text-align: left; color: #b91c1c;">Docente Ausente</th>
                <th style="width: 22%; border: 1px solid #94a3b8; padding: 8px 6px; text-align: left; color: #15803d;">Docente Reemplazante</th>
                <th style="width: 16%; border: 1px solid #94a3b8; padding: 8px 6px; text-align: center;">Hora</th>
                <th style="width: 10%; border: 1px solid #94a3b8; padding: 8px 6px; text-align: center;">Curso</th>
                <th style="width: 18%; border: 1px solid #94a3b8; padding: 8px 6px; text-align: left;">Materia</th>
              </tr>
            </thead>
            <tbody>
              ${tableRowsHtml}
            </tbody>
          </table>
        </div>

        <div style="display: flex; justify-content: center; margin-top: 60px;">
          <div style="text-align: center; width: 260px; border-top: 1.5px solid #0f172a; padding-top: 8px; font-size: 11px; font-weight: bold; color: #0f172a;">
            COORDINACIÓN PEDAGÓGICA
          </div>
        </div>
      `;

      document.body.appendChild(a4Container);

      // Esperar brevemente para renderizado completo
      await new Promise(r => setTimeout(r, 120));

      // Captura ultra nítida en escala 3 (aprox. 2460px de ancho)
      const canvas = await html2canvas(a4Container, {
        scale: 3,
        useCORS: true,
        backgroundColor: '#ffffff',
        logging: false
      });

      // Limpiar elemento temporal
      document.body.removeChild(a4Container);

      // Convertir y descargar en formato JPG con máxima calidad (0.98)
      const imageURL = canvas.toDataURL('image/jpeg', 0.98);
      const link = document.createElement('a');
      const fileIni = fechaInicioInput.value ? fechaInicioInput.value : 'historico';
      const fileFin = fechaFinInput.value ? `_al_${fechaFinInput.value}` : '';
      link.download = `informe_contingencias_${fileIni}${fileFin}.jpg`;
      link.href = imageURL;
      link.click();

      btnGenerarImagen.disabled = false;
      btnGenerarImagen.textContent = 'Generar como Imagen';
      App.showToast('¡Imagen JPG (formato A4) generada con éxito!', 'success');

    } catch (err) {
      btnGenerarImagen.disabled = false;
      btnGenerarImagen.textContent = 'Generar como Imagen';
      App.showToast('Error al generar la imagen: ' + err.message, 'error');
    }
  });

  await loadDocentesFilter();
  await generarReporte();
});


