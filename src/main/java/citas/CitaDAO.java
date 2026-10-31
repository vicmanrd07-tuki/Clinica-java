package citas;

import config.Conexion;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class CitaDAO {

    // Subconsulta: ¿esta cita ya tiene un seguimiento que no esté cancelado?
    private static final String TIENE_SEGUIMIENTO =
              "EXISTS (SELECT 1 FROM cita s "
            + "WHERE s.cita_origen = c.idCita AND s.Estadodecita <> 'cancelada') "
            + "AS tiene_seguimiento ";

    // Citas del doctor que inició sesión (se busca por su idUsuario)
    public List<Cita> listarPorUsuarioDoctor(int idUsuario) {
        List<Cita> lista = new ArrayList<>();
        String sql = "SELECT c.idCita, c.Estadodecita, c.Causa, c.Horainicio, c.FechaCita, "
                   + "c.Paciente_idPaciente, c.Doctor_idDoctor, "
                   + "CONCAT(p.Nombre, ' ', p.Apellido) AS nombre_paciente, "
                   + TIENE_SEGUIMIENTO
                   + "FROM cita c "
                   + "JOIN doctor d   ON c.Doctor_idDoctor = d.idDoctor "
                   + "JOIN paciente p ON c.Paciente_idPaciente = p.idPaciente "
                   + "WHERE d.Usuario_idUsuario = ? "
                   + "ORDER BY c.FechaCita DESC, c.Horainicio DESC";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Una sola cita, SOLO si pertenece al doctor que inició sesión
    public Cita obtenerPorIdDeDoctor(int idCita, int idUsuario) {
        String sql = "SELECT c.idCita, c.Estadodecita, c.Causa, c.Horainicio, c.FechaCita, "
                   + "c.Paciente_idPaciente, c.Doctor_idDoctor, "
                   + "CONCAT(p.Nombre, ' ', p.Apellido) AS nombre_paciente, "
                   + TIENE_SEGUIMIENTO
                   + "FROM cita c "
                   + "JOIN doctor d   ON c.Doctor_idDoctor = d.idDoctor "
                   + "JOIN paciente p ON c.Paciente_idPaciente = p.idPaciente "
                   + "WHERE c.idCita = ? AND d.Usuario_idUsuario = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCita);
            ps.setInt(2, idUsuario);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapear(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ¿El doctor ya tiene una cita (no cancelada) a esa fecha y hora?
    public boolean existeCitaEnHorario(int idDoctor, LocalDate fecha, LocalTime hora) {
        String sql = "SELECT COUNT(*) FROM cita "
                   + "WHERE Doctor_idDoctor = ? AND FechaCita = ? AND Horainicio = ? "
                   + "AND Estadodecita <> 'cancelada'";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idDoctor);
            ps.setDate(2, Date.valueOf(fecha));
            ps.setTime(3, Time.valueOf(hora));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Crea la cita de seguimiento enlazada a la original
    public boolean crearSeguimiento(Cita nueva) {
        String sql = "INSERT INTO cita (Estadodecita, Causa, Horainicio, Paciente_idPaciente, "
                   + "Doctor_idDoctor, FechaCita, cita_origen) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "programada");
            ps.setString(2, nueva.getCausa());
            ps.setTime(3, Time.valueOf(nueva.getHoraInicio()));
            ps.setInt(4, nueva.getIdPaciente());
            ps.setInt(5, nueva.getIdDoctor());
            ps.setDate(6, Date.valueOf(nueva.getFechaCita()));
            ps.setInt(7, nueva.getIdCitaOrigen());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Convierte una fila de la base de datos en un objeto Cita
    private Cita mapear(ResultSet rs) throws SQLException {
        Cita c = new Cita();
        c.setIdCita(rs.getInt("idCita"));
        c.setEstado(rs.getString("Estadodecita"));
        c.setCausa(rs.getString("Causa"));
        c.setHoraInicio(rs.getTime("Horainicio").toLocalTime());
        Date fecha = rs.getDate("FechaCita");
        c.setFechaCita(fecha == null ? null : fecha.toLocalDate());
        c.setIdPaciente(rs.getInt("Paciente_idPaciente"));
        c.setIdDoctor(rs.getInt("Doctor_idDoctor"));
        c.setNombrePaciente(rs.getString("nombre_paciente"));
        c.setTieneSeguimiento(rs.getBoolean("tiene_seguimiento"));
        return c;
    }
}