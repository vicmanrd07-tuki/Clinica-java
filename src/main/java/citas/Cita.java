package citas;

import java.time.LocalDate;
import java.time.LocalTime;

public class Cita {

    private int idCita;
    private String estado;
    private String causa;
    private LocalTime horaInicio;
    private LocalDate fechaCita;
    private int idPaciente;
    private int idDoctor;
    private String nombrePaciente;
    private Integer idCitaOrigen;
    private boolean tieneSeguimiento;

    public int getIdCita() { return idCita; }
    public void setIdCita(int idCita) { this.idCita = idCita; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getCausa() { return causa; }
    public void setCausa(String causa) { this.causa = causa; }

    public LocalTime getHoraInicio() { return horaInicio; }
    public void setHoraInicio(LocalTime horaInicio) { this.horaInicio = horaInicio; }

    public LocalDate getFechaCita() { return fechaCita; }
    public void setFechaCita(LocalDate fechaCita) { this.fechaCita = fechaCita; }

    public int getIdPaciente() { return idPaciente; }
    public void setIdPaciente(int idPaciente) { this.idPaciente = idPaciente; }

    public int getIdDoctor() { return idDoctor; }
    public void setIdDoctor(int idDoctor) { this.idDoctor = idDoctor; }

    public String getNombrePaciente() { return nombrePaciente; }
    public void setNombrePaciente(String nombrePaciente) { this.nombrePaciente = nombrePaciente; }

    public Integer getIdCitaOrigen() { return idCitaOrigen; }
    public void setIdCitaOrigen(Integer idCitaOrigen) { this.idCitaOrigen = idCitaOrigen; }

    public boolean isTieneSeguimiento() { return tieneSeguimiento; }
    public void setTieneSeguimiento(boolean tieneSeguimiento) { this.tieneSeguimiento = tieneSeguimiento; }
}