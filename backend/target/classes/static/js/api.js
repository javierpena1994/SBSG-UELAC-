/* ==========================================================
   SISTEMA DE GESTIÓN DE CONTINGENCIAS SBSG - API CLIENT
   ========================================================== */

const API = (() => {
  const host = (window.location.hostname === '127.0.0.1') ? '127.0.0.1' : (window.location.hostname || 'localhost');
  const BASE_URL = (window.location.protocol === 'file:' || window.location.port !== '8080')
    ? `http://${host}:8080/api`
    : '/api';

  async function request(endpoint, options = {}) {
    const url = `${BASE_URL}${endpoint}`;
    const defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    const config = {
      ...options,
      headers: {
        ...defaultHeaders,
        ...options.headers
      }
    };

    try {
      const response = await fetch(url, config);

      if (!response.ok) {
        let errorMsg = `Error ${response.status}: ${response.statusText}`;
        try {
          const errorData = await response.json();
          if (errorData.message) errorMsg = errorData.message;
          else if (errorData.error) errorMsg = errorData.error;
        } catch (_) {}
        throw new Error(errorMsg);
      }

      if (response.status === 204) {
        return null;
      }

      return await response.json();
    } catch (error) {
      console.error(`API Request Error [${endpoint}]:`, error);
      throw error;
    }
  }

  return {
    BASE_URL,

    // Catálogos
    getCatalogos: () => request('/catalogos'),
    getCursos: () => request('/catalogos/cursos'),
    getFranjas: () => request('/catalogos/franjas'),

    // Materias (Catálogo y Gestión)
    getMaterias: () => request('/materias'),
    getMateria: (id) => request(`/materias/${id}`),
    crearMateria: (data) => request('/materias', { method: 'POST', body: JSON.stringify(data) }),
    actualizarMateria: (id, data) => request(`/materias/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
    eliminarMateria: (id) => request(`/materias/${id}`, { method: 'DELETE' }),

    // Docentes
    getDocentes: () => request('/docentes'),
    getTodosDocentes: () => request('/docentes/todos'),
    getDocente: (id) => request(`/docentes/${id}`),
    crearDocente: (data) => request('/docentes', { method: 'POST', body: JSON.stringify(data) }),
    actualizarDocente: (id, data) => request(`/docentes/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
    toggleEstadoDocente: (id) => request(`/docentes/${id}/toggle-estado`, { method: 'PATCH' }),

    // Disponibilidad & Horarios
    getDisponibles: (fecha, franjaHorariaId, docenteAusenteId, cursoId) => {
      let query = `?fecha=${encodeURIComponent(fecha)}&franjaHorariaId=${encodeURIComponent(franjaHorariaId)}`;
      if (docenteAusenteId) {
        query += `&docenteAusenteId=${encodeURIComponent(docenteAusenteId)}`;
      }
      if (cursoId) {
        query += `&cursoId=${encodeURIComponent(cursoId)}`;
      }
      return request(`/disponibilidad/disponibles${query}`);
    },
    getDisponibilidadDocente: (docenteId) => request(`/disponibilidad/docente/${docenteId}`),
    getTodasDisponibilidades: () => request('/disponibilidad/todos'),
    guardarHorarioDocente: (docenteId, slots) => request('/disponibilidad/guardar', { method: 'POST', body: JSON.stringify({ docenteId, slots }) }),
    toggleHorarioSlot: (docenteId, diaSemana, franjaHorariaId) => {
      const qs = `?docenteId=${docenteId}&diaSemana=${encodeURIComponent(diaSemana)}&franjaHorariaId=${franjaHorariaId}`;
      return request(`/disponibilidad/toggle${qs}`, { method: 'POST' });
    },
    limpiarTodosLosHorarios: () => request('/disponibilidad/limpiar-todos', { method: 'POST' }),

    // Horarios de Clases (Docentes y Cursos)
    getHorarioClasesDocente: (docenteId) => request(`/horarios-clases/docente/${docenteId}`),
    getHorarioClasesCurso: (cursoId) => request(`/horarios-clases/curso/${cursoId}`),
    detectarClaseDocente: (docenteId, fecha, franjaHorariaId) => {
      const qs = `?docenteId=${docenteId}&fecha=${encodeURIComponent(fecha)}&franjaHorariaId=${franjaHorariaId}`;
      return request(`/horarios-clases/detectar${qs}`);
    },
    guardarHorarioClasesDocente: (data) => request('/horarios-clases/guardar-docente', { method: 'POST', body: JSON.stringify(data) }),
    guardarHorarioClasesCurso: (data) => request('/horarios-clases/guardar-curso', { method: 'POST', body: JSON.stringify(data) }),

    // Contingencias
    getContingencias: (params = {}) => {
      const qs = new URLSearchParams();
      if (params.fechaInicio) qs.append('fechaInicio', params.fechaInicio);
      if (params.fechaFin) qs.append('fechaFin', params.fechaFin);
      if (params.docenteAusenteId) qs.append('docenteAusenteId', params.docenteAusenteId);
      if (params.docenteReemplazoId) qs.append('docenteReemplazoId', params.docenteReemplazoId);
      if (params.cursoId) qs.append('cursoId', params.cursoId);
      if (params.materiaId) qs.append('materiaId', params.materiaId);
      return request(`/contingencias?${qs.toString()}`);
    },

    getContingenciasPaginado: (params = {}) => {
      const qs = new URLSearchParams();
      if (params.fechaInicio) qs.append('fechaInicio', params.fechaInicio);
      if (params.fechaFin) qs.append('fechaFin', params.fechaFin);
      if (params.docenteAusenteId) qs.append('docenteAusenteId', params.docenteAusenteId);
      if (params.docenteReemplazoId) qs.append('docenteReemplazoId', params.docenteReemplazoId);
      if (params.cursoId) qs.append('cursoId', params.cursoId);
      if (params.materiaId) qs.append('materiaId', params.materiaId);
      qs.append('page', params.page || 0);
      qs.append('size', params.size || 15);
      return request(`/contingencias/paginado?${qs.toString()}`);
    },

    getContingenciasRecientes: () => request('/contingencias/recientes'),
    getContingencia: (id) => request(`/contingencias/${id}`),
    crearContingencia: (data) => request('/contingencias', { method: 'POST', body: JSON.stringify(data) }),
    crearContingenciasLote: (data) => request('/contingencias/lote', { method: 'POST', body: JSON.stringify(data) }),
    actualizarContingencia: (id, data) => request(`/contingencias/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
    eliminarContingencia: (id) => request(`/contingencias/${id}`, { method: 'DELETE' }),

    // Reportes
    getReporte: (params = {}) => {
      const qs = new URLSearchParams();
      if (params.fechaInicio) qs.append('fechaInicio', params.fechaInicio);
      if (params.fechaFin) qs.append('fechaFin', params.fechaFin);
      if (params.docenteAusenteId) qs.append('docenteAusenteId', params.docenteAusenteId);
      if (params.docenteReemplazoId) qs.append('docenteReemplazoId', params.docenteReemplazoId);
      if (params.cursoId) qs.append('cursoId', params.cursoId);
      if (params.materiaId) qs.append('materiaId', params.materiaId);
      return request(`/reportes?${qs.toString()}`);
    },

    getExcelExportUrl: (params = {}) => {
      const qs = new URLSearchParams();
      if (params.fechaInicio) qs.append('fechaInicio', params.fechaInicio);
      if (params.fechaFin) qs.append('fechaFin', params.fechaFin);
      if (params.docenteAusenteId) qs.append('docenteAusenteId', params.docenteAusenteId);
      if (params.docenteReemplazoId) qs.append('docenteReemplazoId', params.docenteReemplazoId);
      if (params.cursoId) qs.append('cursoId', params.cursoId);
      if (params.materiaId) qs.append('materiaId', params.materiaId);
      return `${BASE_URL}/reportes/exportar-excel?${qs.toString()}`;
    },

    // Importación / Estado
    importarExcelPorDefecto: () => request('/import/excel-default', { method: 'POST' }),
    getStatus: () => request('/import/status')
  };
})();
