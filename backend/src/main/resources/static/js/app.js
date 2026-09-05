/* ==========================================================
   SISTEMA DE GESTIÓN DE CONTINGENCIAS SBSG - APP UTILS
   ========================================================== */

const App = (() => {
  // Toast notifications
  function showToast(message, type = 'info', duration = 3500) {
    let container = document.getElementById('toast-container');
    if (!container) {
      container = document.createElement('div');
      container.id = 'toast-container';
      document.body.appendChild(container);
    }

    const icons = {
      success: '<i class="fa-solid fa-circle-check" style="font-size:14px;"></i>',
      error: '<i class="fa-solid fa-circle-xmark" style="font-size:14px;"></i>',
      warning: '<i class="fa-solid fa-triangle-exclamation" style="font-size:14px;"></i>',
      info: '<i class="fa-solid fa-circle-info" style="font-size:14px;"></i>'
    };
    const iconHtml = icons[type] || icons.info;

    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.innerHTML = `
      <div style="display:flex; align-items:center; gap:8px;">
        ${iconHtml}
        <span>${message}</span>
      </div>
      <span style="cursor:pointer; margin-left:12px; opacity:0.8;" onclick="this.parentElement.remove()" title="Cerrar">
        <i class="fa-solid fa-xmark"></i>
      </span>
    `;

    container.appendChild(toast);

    setTimeout(() => {
      if (toast.parentElement) {
        toast.remove();
      }
    }, duration);
  }

  // Calculate day of week in Spanish
  function getDiaSemana(dateStr) {
    if (!dateStr) return '';
    const [year, month, day] = dateStr.split('-').map(Number);
    const date = new Date(year, month - 1, day);
    const dias = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
    return dias[date.getDay()];
  }

  // Format date display
  function formatDateDisplay(dateStr) {
    if (!dateStr) return '-';
    const [year, month, day] = dateStr.split('-');
    return `${day}/${month}/${year}`;
  }

  // Format date with short day e.g. "LUN 18/06/26"
  function formatFechaConDia(dateStr, diaSemana) {
    if (!dateStr) return '-';
    let diaAbrev = '';
    const diaRef = diaSemana || getDiaSemana(dateStr);
    if (diaRef) {
      const d = diaRef.toLowerCase();
      if (d.startsWith('lun')) diaAbrev = 'LUN';
      else if (d.startsWith('mar')) diaAbrev = 'MAR';
      else if (d.startsWith('mi')) diaAbrev = 'MIÉ';
      else if (d.startsWith('jue')) diaAbrev = 'JUE';
      else if (d.startsWith('vie')) diaAbrev = 'VIE';
      else if (d.startsWith('s')) diaAbrev = 'SÁB';
      else if (d.startsWith('d')) diaAbrev = 'DOM';
    }
    const [year, month, day] = dateStr.split('-');
    const shortYear = year ? (year.length === 4 ? year.slice(-2) : year) : '26';
    const tag = diaAbrev ? `<span style="font-weight:700; color:var(--primary); font-size:11.5px; margin-right:4px;">${diaAbrev}</span>` : '';
    return `${tag}${day}/${month}/${shortYear}`;
  }

  // Clasificación oficial de cursos en 3 niveles
  function getNivelCurso(nombreCurso) {
    if (!nombreCurso) return 'DESCONOCIDO';
    const n = nombreCurso.toUpperCase().trim();
    // Nivel Superior: 8° a 10° EGB y 1° a 3° BGU
    if (n.includes('BGU') || n.includes('BACH') || n.startsWith('8') || n.startsWith('9') || n.startsWith('10')
        || n.startsWith('8°') || n.startsWith('9°') || n.startsWith('10°')) {
      return 'SUPERIOR';
    }
    // Nivel Básico: Inicial 2, 1° a 3° EGB
    if (n.includes('INICIAL') || n.startsWith('1°') || n.startsWith('1 ') || n.startsWith('1RO') || n.startsWith('PRIMERO')
        || n.startsWith('2°') || n.startsWith('2 ') || n.startsWith('2DO') || n.startsWith('SEGUNDO')
        || n.startsWith('3°') || n.startsWith('3 ') || n.startsWith('3RO') || n.startsWith('TERCERO')) {
      return 'BÁSICO';
    }
    // Nivel Medio: 4° a 7° EGB
    if (n.startsWith('4°') || n.startsWith('4 ') || n.startsWith('4TO') || n.startsWith('CUARTO')
        || n.startsWith('5°') || n.startsWith('5 ') || n.startsWith('5TO') || n.startsWith('QUINTO')
        || n.startsWith('6°') || n.startsWith('6 ') || n.startsWith('6TO') || n.startsWith('SEXTO')
        || n.startsWith('7°') || n.startsWith('7 ') || n.startsWith('7MO') || n.startsWith('SEPTIMO') || n.startsWith('SÉPTIMO')) {
      return 'MEDIO';
    }
    return 'SUPERIOR';
  }

  // Poblar un <select> de cursos agrupado en los 3 niveles
  function populateCursoSelect(selectEl, cursos, defaultOptionText = '-- Seleccione curso --') {
    if (!selectEl) return;
    selectEl.innerHTML = '';
    if (defaultOptionText) {
      const defaultOpt = document.createElement('option');
      defaultOpt.value = '';
      defaultOpt.textContent = defaultOptionText;
      selectEl.appendChild(defaultOpt);
    }

    const optgroupBasico = document.createElement('optgroup');
    optgroupBasico.label = 'Nivel Básico (Inicial 2 a 3° EGB)';

    const optgroupMedio = document.createElement('optgroup');
    optgroupMedio.label = 'Nivel Medio (4° EGB a 7° EGB)';

    const optgroupSuperior = document.createElement('optgroup');
    optgroupSuperior.label = 'Nivel Superior (8° EGB a 3° BGU)';

    (cursos || []).forEach(c => {
      const opt = document.createElement('option');
      opt.value = c.id;
      opt.textContent = c.nombre;
      const nivel = getNivelCurso(c.nombre);
      if (nivel === 'BÁSICO') {
        optgroupBasico.appendChild(opt);
      } else if (nivel === 'MEDIO') {
        optgroupMedio.appendChild(opt);
      } else {
        optgroupSuperior.appendChild(opt);
      }
    });

    if (optgroupBasico.children.length > 0) selectEl.appendChild(optgroupBasico);
    if (optgroupMedio.children.length > 0) selectEl.appendChild(optgroupMedio);
    if (optgroupSuperior.children.length > 0) selectEl.appendChild(optgroupSuperior);
  }

  // Centralized Sidebar Component
  function renderSidebar() {
    const sidebarContainer = document.getElementById('app-sidebar') || document.querySelector('aside.sidebar');
    if (!sidebarContainer) return;

    const currentPath = window.location.pathname;
    const isHome = currentPath.endsWith('index.html') || currentPath === '/' || currentPath.endsWith('/') || currentPath.endsWith('SBSG/');

    const menuSections = [
      {
        title: 'GESTIÓN DE CONTINGENCIAS',
        items: [
          { href: 'registro.html', icon: '<i class="fa-solid fa-circle-plus"></i>', label: 'Nueva Contingencia' },
          { href: 'historial.html', icon: '<i class="fa-solid fa-chart-line"></i>', label: 'Historial y Reportes' }
        ]
      },
      {
        title: 'ADMINISTRACIÓN & AÑO LECTIVO',
        items: [
          { href: 'docentes.html', icon: '<i class="fa-solid fa-users"></i>', label: 'Gestión de Docentes' },
          { href: 'materias.html', icon: '<i class="fa-solid fa-book-bookmark"></i>', label: 'Gestión de Materias' },
          { href: 'horarios.html', icon: '<i class="fa-solid fa-calendar-days"></i>', label: 'Editor de Horarios' }
        ]
      }
    ];

    let navHtml = '';
    menuSections.forEach(sec => {
      navHtml += `<div class="sidebar-section-title">${sec.title}</div>`;
      sec.items.forEach(item => {
        const isActive = currentPath.endsWith(item.href);
        navHtml += `
          <a href="${item.href}" class="nav-item ${isActive ? 'active' : ''}">
            <span class="nav-icon">${item.icon}</span>
            <span>${item.label}</span>
          </a>
        `;
      });
    });

    sidebarContainer.classList.add('sidebar');
    sidebarContainer.innerHTML = `
      <div class="sidebar-header">
        <a href="index.html" class="sidebar-logo-wrapper" title="Ir al Inicio">
          <img src="assets/logo.jpg" alt="Logo Institución" class="sidebar-logo">
        </a>
        <div class="sidebar-home-bar">
          <a href="index.html" class="btn-home-icon ${isHome ? 'active' : ''}" title="Inicio / Panel Principal">
            <i class="fa-solid fa-house"></i>
          </a>
        </div>
      </div>

      <nav class="sidebar-nav">
        ${navHtml}
      </nav>

      <div class="sidebar-footer">
        <div>Gestión Docente v1.0</div>
        <div>Base de Datos MySQL</div>
      </div>
    `;
  }

  // Common quick modal confirm
  function confirmDialog(message) {
    return window.confirm(message);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
      renderSidebar();
    });
  } else {
    renderSidebar();
  }

  return {
    showToast,
    getDiaSemana,
    formatDateDisplay,
    formatFechaConDia,
    getNivelCurso,
    populateCursoSelect,
    confirmDialog,
    renderSidebar
  };
})();
