/* ==========================================================
   SISTEMA DE GESTIÓN DE CONTINGENCIAS SBSG - GESTIÓN DOCENTES JS
   ========================================================== */

document.addEventListener('DOMContentLoaded', async () => {
  const tableBody = document.getElementById('docentes-tbody');
  const searchInput = document.getElementById('search-docente');
  const filterEstado = document.getElementById('filter-estado-docente');
  const totalBadge = document.getElementById('total-docentes-badge');

  // Modal
  const modal = document.getElementById('modal-docente');
  const modalTitle = document.getElementById('modal-docente-title');
  const formDocente = document.getElementById('form-docente');
  const btnNuevoDocente = document.getElementById('btn-nuevo-docente');
  const btnCerrarModal = document.getElementById('btn-cerrar-modal');
  const btnCancelar = document.getElementById('btn-cancelar-docente');

  const inputId = document.getElementById('docente-id');
  const inputNombreCompleto = document.getElementById('docente-nombre-completo');
  const inputActivo = document.getElementById('docente-activo');

  let docentesList = [];

  async function loadDocentes() {
    try {
      docentesList = await API.getTodosDocentes();
      renderTable();
    } catch (err) {
      App.showToast('Error cargando lista de docentes: ' + err.message, 'error');
    }
  }

  function renderTable() {
    tableBody.innerHTML = '';
    const search = (searchInput.value || '').toLowerCase().trim();
    const estado = filterEstado.value;

    const filtered = docentesList.filter(d => {
      // Filtro de estado
      if (estado === 'activo' && !d.activo) return false;
      if (estado === 'inactivo' && d.activo) return false;

      // Filtro de búsqueda
      if (!search) return true;
      const nomC = (d.nombreCompleto || '').toLowerCase();
      return nomC.includes(search);
    });

    totalBadge.textContent = `${filtered.length} de ${docentesList.length} docentes`;

    if (filtered.length === 0) {
      tableBody.innerHTML = '<tr><td colspan="4" style="text-align:center; padding:24px; color:var(--text-muted);">No se encontraron docentes con los criterios seleccionados.</td></tr>';
      return;
    }

    filtered.forEach(d => {
      const tr = document.createElement('tr');
      const badgeEstado = d.activo
        ? '<span class="badge badge-available">ACTIVO</span>'
        : '<span class="badge badge-class">INACTIVO</span>';

      tr.innerHTML = `
        <td><strong>#${d.id}</strong></td>
        <td style="font-weight:700; color:var(--primary);">${d.nombreCompleto}</td>
        <td style="text-align:center;">${badgeEstado}</td>
        <td style="text-align:center; white-space:nowrap;">
          <button type="button" class="btn btn-secondary btn-sm" onclick="window.editarDocente(${d.id})" style="padding:4px 10px; font-size:11.5px; margin-right:4px; display:inline-flex; align-items:center; gap:4px;">
            <i class="fa-solid fa-pen-to-square"></i> Editar
          </button>
          <button type="button" class="btn ${d.activo ? 'btn-danger' : 'btn-success'} btn-sm" onclick="window.toggleEstadoDocente(${d.id})" style="padding:4px 10px; font-size:11.5px; display:inline-flex; align-items:center; gap:4px;">
            ${d.activo ? '<i class="fa-solid fa-user-slash"></i> Desactivar' : '<i class="fa-solid fa-user-check"></i> Activar'}
          </button>
        </td>
      `;
      tableBody.appendChild(tr);
    });
  }

  function openModal(docente = null) {
    if (docente) {
      modalTitle.textContent = 'Editar Docente';
      inputId.value = docente.id;
      inputNombreCompleto.value = docente.nombreCompleto;
      inputActivo.checked = docente.activo !== false;
    } else {
      modalTitle.textContent = 'Registrar Nuevo Docente';
      inputId.value = '';
      inputNombreCompleto.value = '';
      inputActivo.checked = true;
    }
    modal.style.display = 'flex';
  }

  function closeModal() {
    modal.style.display = 'none';
  }

  // Global actions
  window.editarDocente = (id) => {
    const d = docentesList.find(item => item.id === id);
    if (d) openModal(d);
  };

  window.toggleEstadoDocente = async (id) => {
    try {
      const res = await API.toggleEstadoDocente(id);
      App.showToast(res.message, 'info');
      await loadDocentes();
    } catch (err) {
      App.showToast('Error al cambiar estado: ' + err.message, 'error');
    }
  };

  // Form submit
  formDocente.addEventListener('submit', async (e) => {
    e.preventDefault();

    const id = inputId.value ? Number(inputId.value) : null;
    const nombreCompleto = inputNombreCompleto.value.trim();
    const activo = inputActivo.checked;

    if (!nombreCompleto) {
      App.showToast('El nombre completo es obligatorio.', 'warning');
      return;
    }

    const payload = {
      nombreCompleto,
      nombreCorto: nombreCompleto,
      activo
    };

    try {
      if (id) {
        await API.actualizarDocente(id, payload);
        App.showToast('Docente actualizado con éxito.', 'success');
      } else {
        await API.crearDocente(payload);
        App.showToast('Docente registrado con éxito.', 'success');
      }

      closeModal();
      await loadDocentes();
    } catch (err) {
      App.showToast('Error al guardar docente: ' + err.message, 'error');
    }
  });

  btnNuevoDocente.addEventListener('click', () => openModal(null));
  btnCerrarModal.addEventListener('click', closeModal);
  btnCancelar.addEventListener('click', closeModal);

  searchInput.addEventListener('input', renderTable);
  filterEstado.addEventListener('change', renderTable);

  await loadDocentes();
});
