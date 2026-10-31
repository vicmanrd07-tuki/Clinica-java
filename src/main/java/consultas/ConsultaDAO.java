package consultas;

import config.Conexion;
import java.sql.*;

public class ConsultaDAO {

    public boolean registrar(Consulta c, int idUsuario) throws SQLException {

        String sqlBuscar = "SELECT idPaciente FROM clinica_db.paciente WHERE Cui = ?";

        String sqlPaciente = "INSERT INTO clinica_db.paciente "
                + "(Nombre, Apellido, Cui, Fechadenacimiento, Telefono, Correo, Usuario_idUsuario) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        String sqlCita = "INSERT INTO clinica_db.cita "
                + "(Estadodecita, Causa, Horainicio, Paciente_idPaciente, Doctor_idDoctor, FechaCita) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        Date fecha = Date.valueOf(c.getFechaCita());   // java.sql.Date
        Time hora  = Time.valueOf(c.getHoraCita());    // java.sql.Time

        try (Connection con = Conexion.getConexion()) {
            con.setAutoCommit(false);
            try {

                // 0) ¿El doctor ya tiene cita en esa fecha y hora?
                if (doctorOcupado(con, c.getIdDoctor(), fecha, hora)) {
                    con.rollback();
                    return false;
                }

                // 1) ¿El paciente ya existe?
                int idPaciente = 0;
                try (PreparedStatement ps = con.prepareStatement(sqlBuscar)) {
                    ps.setString(1, c.getCui());
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) idPaciente = rs.getInt(1);
                    }
                }

                // 2) Si no existe, insertarlo
                if (idPaciente == 0) {
                    try (PreparedStatement ps = con.prepareStatement(sqlPaciente, Statement.RETURN_GENERATED_KEYS)) {
                        ps.setString(1, c.getNombre());
                        ps.setString(2, c.getApellido());
                        ps.setString(3, c.getCui());
                        ps.setDate(4, Date.valueOf(c.getFechaNacimiento()));
                        ps.setString(5, c.getTelefono());
                        ps.setString(6, c.getCorreo());
                        ps.setInt(7, idUsuario);
                        ps.executeUpdate();
                        try (ResultSet rs = ps.getGeneratedKeys()) {
                            rs.next();
                            idPaciente = rs.getInt(1);
                        }
                    }
                }

                // 3) Insertar la cita
                try (PreparedStatement ps = con.prepareStatement(sqlCita)) {
                    ps.setString(1, "Programada");   // valor válido de tu Estadodecita
                    ps.setString(2, c.getCausa());
                    ps.setTime(3, hora);
                    ps.setInt(4, idPaciente);
                    ps.setInt(5, c.getIdDoctor());
                    ps.setDate(6, fecha);
                    ps.executeUpdate();
                }

                con.commit();
                return true;

            } catch (SQLException e) {
                con.rollback();
                throw e;
            }
        }
    }

    private boolean doctorOcupado(Connection con, int idDoctor, Date fecha, Time hora) throws SQLException {
        String sql = "SELECT COUNT(*) FROM clinica_db.cita "
                + "WHERE Doctor_idDoctor = ? AND FechaCita = ? AND Horainicio = ? "
                + "AND Estadodecita <> 'Cancelada'";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idDoctor);
            ps.setDate(2, fecha);
            ps.setTime(3, hora);
            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getInt(1) > 0;
            }
        }
    }
    public boolean cambiarEstado(int idCita, String nuevoEstado) throws SQLException {
    String sql = "UPDATE clinica_db.cita SET Estadodecita = ? WHERE idCita = ?";
    try (Connection con = Conexion.getConexion();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, nuevoEstado);   
        ps.setInt(2, idCita);
        return ps.executeUpdate() > 0;
    }
}
}