package com.sbsg.contingencias.dto;

public class DocenteDisponibleDTO {
    private Long id;
    private String nombreCompleto;
    private String nombreCorto;
    private String email;
    private boolean disponibleSegunHorario;
    private boolean ocupadoPorOtraContingencia;
    private Long totalReemplazosRecientes;
    private String estadoDescripcion;
    private String categoriaPrioridad; // "MISMO_NIVEL", "OTRO_NIVEL", "AUTORIDAD"
    private int ordenPrioridad = 2; // 1 = Mismo nivel, 2 = Otro nivel, 3 = Autoridad
    private String nivelDocente; // "BÁSICO", "MEDIO", "SUPERIOR", etc.
    private String explicacionPrioridad;

    public DocenteDisponibleDTO() {}

    public DocenteDisponibleDTO(Long id, String nombreCompleto, String nombreCorto, boolean disponibleSegunHorario, boolean ocupadoPorOtraContingencia, Long totalReemplazosRecientes, String estadoDescripcion) {
        this.id = id;
        this.nombreCompleto = nombreCompleto;
        this.nombreCorto = nombreCorto;
        this.disponibleSegunHorario = disponibleSegunHorario;
        this.ocupadoPorOtraContingencia = ocupadoPorOtraContingencia;
        this.totalReemplazosRecientes = totalReemplazosRecientes;
        this.estadoDescripcion = estadoDescripcion;
    }

    public DocenteDisponibleDTO(Long id, String nombreCompleto, String nombreCorto, boolean disponibleSegunHorario, boolean ocupadoPorOtraContingencia, Long totalReemplazosRecientes, String estadoDescripcion, String categoriaPrioridad, int ordenPrioridad, String nivelDocente, String explicacionPrioridad) {
        this.id = id;
        this.nombreCompleto = nombreCompleto;
        this.nombreCorto = nombreCorto;
        this.disponibleSegunHorario = disponibleSegunHorario;
        this.ocupadoPorOtraContingencia = ocupadoPorOtraContingencia;
        this.totalReemplazosRecientes = totalReemplazosRecientes;
        this.estadoDescripcion = estadoDescripcion;
        this.categoriaPrioridad = categoriaPrioridad;
        this.ordenPrioridad = ordenPrioridad;
        this.nivelDocente = nivelDocente;
        this.explicacionPrioridad = explicacionPrioridad;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getNombreCorto() {
        return nombreCorto;
    }

    public void setNombreCorto(String nombreCorto) {
        this.nombreCorto = nombreCorto;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isDisponibleSegunHorario() {
        return disponibleSegunHorario;
    }

    public void setDisponibleSegunHorario(boolean disponibleSegunHorario) {
        this.disponibleSegunHorario = disponibleSegunHorario;
    }

    public boolean isOcupadoPorOtraContingencia() {
        return ocupadoPorOtraContingencia;
    }

    public void setOcupadoPorOtraContingencia(boolean ocupadoPorOtraContingencia) {
        this.ocupadoPorOtraContingencia = ocupadoPorOtraContingencia;
    }

    public Long getTotalReemplazosRecientes() {
        return totalReemplazosRecientes;
    }

    public void setTotalReemplazosRecientes(Long totalReemplazosRecientes) {
        this.totalReemplazosRecientes = totalReemplazosRecientes;
    }

    public String getEstadoDescripcion() {
        return estadoDescripcion;
    }

    public void setEstadoDescripcion(String estadoDescripcion) {
        this.estadoDescripcion = estadoDescripcion;
    }

    public String getCategoriaPrioridad() {
        return categoriaPrioridad;
    }

    public void setCategoriaPrioridad(String categoriaPrioridad) {
        this.categoriaPrioridad = categoriaPrioridad;
    }

    public int getOrdenPrioridad() {
        return ordenPrioridad;
    }

    public void setOrdenPrioridad(int ordenPrioridad) {
        this.ordenPrioridad = ordenPrioridad;
    }

    public String getNivelDocente() {
        return nivelDocente;
    }

    public void setNivelDocente(String nivelDocente) {
        this.nivelDocente = nivelDocente;
    }

    public String getExplicacionPrioridad() {
        return explicacionPrioridad;
    }

    public void setExplicacionPrioridad(String explicacionPrioridad) {
        this.explicacionPrioridad = explicacionPrioridad;
    }
}

