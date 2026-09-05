/* ==========================================================
   SISTEMA DE GESTIÓN DE CONTINGENCIAS SBSG - GESTIÓN MATERIAS JS
   ========================================================== */

document.addEventListener('DOMContentLoaded', async () => {
  const tableBody = document.getElementById('materias-tbody');
  const searchInput = document.getElementById('search-materia');
  const totalBadge = document.getElementById('total-materias-badge');

  // Modal
  const modal = document.getElementById('modal-materia');
  const modalTitle = document.getElementById('modal-materia-title');
  const formMateria = document.getElementById('form-materia');
  const btnNuevaMateria = document.getElementById('btn-nueva-materia');
  const btnCerrarModal = document.getElementById('btn-cerrar-modal');
  const btnCancelar = document.getElementById('btn-cancelar-materia');
  const btnGuardar = document.getElementById('btn-guardar-materia');

  const inputId = document.getElementById('materia-id');
  const inputNombre = document.getElementById('materia-nombre');

  let materiasList = [];

  async function loadMaterias() {
    try {
      materiasList = await API.getMaterias();
      renderTable();
    } catch (err) {
      App.showToast('Error cargando lista de materias: ' + err.message, 'error');
    }
  }

  function renderTable() {
    tableBody.innerHTML = '';
    const search = (searchInput.value || '').toLowerCase().trim();

    const filtered = materiasList.filter(m => {
      if (!search) return true;
      const nom = (m.nombre || '').toLowerCase();
      return nom.includes(search);
    });

    totalBadge.textContent = `${filtered.length} de ${materiasList.length} materias`;

    if (filtered.length === 0) {
      tableBody.innerHTML = '<tr><td colspan="3" style="text-align:center; padding:24px; color:var(--text-muted);">No se encontraron materias con el término de búsqueda ingresado.</td></tr>';
      return;
    }

    filtered.forEach(m => {
      const tr = document.createElement('tr');

      tr.innerHTML = `
        <td><strong>#${m.id}</strong></td>
        <td style="font-weight:700; color:var(--primary); font-size:13.5px;">${m.nombre}</td>
        <td style="text-align:center; white-space:nowrap;">
          <button type="button" class="btn btn-secondary btn-sm" onclick="window.editarMateria(${m.id})" style="padding:4px 12px; font-size:12px; margin-right:6px; display:inline-flex; align-items:center; gap:4px;">
            <i class="fa-solid fa-pen-to-square"></i> Editar
          </button>
          <button type="button" class="btn btn-danger btn-sm" onclick="window.eliminarMateria(${m.id})" style="padding:4px 12px; font-size:12px; display:inline-flex; align-items:center; gap:4px;">
            <i class="fa-solid fa-trash-can"></i> Eliminar
          </button>
        </td>
      `;
      tableBody.appendChild(tr);
    });
  }

  function openModal(materia = null) {
    if (materia) {
      modalTitle.textContent = 'Editar Materia / Asignatura';
      inputId.value = materia.id;
      inputNombre.value = materia.nombre;
    } else {
      modalTitle.textContent = 'Registrar Nueva Materia / Asignatura';
      inputId.value = '';
      inputNombre.value = '';
    }
    modal.style.display = 'flex';
    setTimeout(() => inputNombre.focus(), 100);
  }

  function closeModal() {
    modal.style.display = 'none';
  }

  // Global actions
  window.editarMateria = (id) => {
    const materia = materiasList.find(m => m.id === id);
    if (materia) {
      openModal(materia);
    }
  };

  window.eliminarMateria = async (id) => {
    const materia = materiasList.find(m => m.id === id);
    if (!materia) return;

    const confirm = App.confirmDialog(`¿Está seguro de que desea eliminar la materia "${materia.nombre}"?\n\nNota: Si la materia está asignada a horarios o contingencias, el sistema no permitirá borrarla por seguridad.`);
    if (!confirm) return;

    try {
      await API.eliminarMateria(id);
      App.showToast(`Materia "${materia.nombre}" eliminada exitosamente.`, 'success');
      await loadMaterias();
    } catch (err) {
      App.showToast('No se pudo eliminar: ' + err.message, 'error', 5000);
    }
  };

  // Form Submit
  formMateria.addEventListener('submit', async (e) => {
    e.preventDefault();

    const nombre = inputNombre.value.trim().toUpperCase();
    if (!nombre) {
      App.showToast('El nombre de la materia es requerido.', 'warning');
      return;
    }

    const id = inputId.value;
    const payload = {
      nombre: nombre
    };

    try {
      btnGuardar.disabled = true;
      btnGuardar.textContent = 'Guardando...';

      if (id) {
        // Actualizar
        await API.actualizarMateria(id, payload);
        App.showToast('Materia actualizada correctamente.', 'success');
      } else {
        // Crear
        await API.crearMateria(payload);
        App.showToast('Materia creada exitosamente.', 'success');
      }

      closeModal();
      await loadMaterias();

    } catch (err) {
      App.showToast('Error al guardar materia: ' + err.message, 'error');
    } finally {
      btnGuardar.disabled = false;
      btnGuardar.textContent = 'Guardar Materia';
    }
  });

  // Event Listeners
  btnNuevaMateria.addEventListener('click', () => openModal());
  btnCerrarModal.addEventListener('click', closeModal);
  btnCancelar.addEventListener('click', closeModal);

  // Close on backdrop click
  modal.addEventListener('click', (e) => {
    if (e.target === modal) closeModal();
  });

  // Filter input event
  searchInput.addEventListener('input', renderTable);

  // Initial load
  await loadMaterias();
});
