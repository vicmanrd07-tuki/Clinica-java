package citas;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import login.Usuario;

@WebServlet("/medico/seguimiento")
public class SeguimientoServlet extends HttpServlet {

    // Devuelve el doctor logueado, o null si no hay sesión o no es doctor
    private Usuario doctorLogueado(HttpServletRequest req) {
        HttpSession sesion = req.getSession(false);
        Usuario u = (sesion == null) ? null : (Usuario) sesion.getAttribute("usuario");
        return (u != null && "doctor".equalsIgnoreCase(u.getTipo())) ? u : null;
    }

    private void volver(HttpServletRequest req, HttpServletResponse resp, String parametro)
            throws IOException {
        resp.sendRedirect(req.getContextPath() + "/medico/citas?" + parametro);
    }

    // Revisa si a esta cita se le puede dar seguimiento.
    // Devuelve null si sí se puede, o el código de error si no.
    private String motivoRechazo(Cita origen) {
        if ("cancelada".equalsIgnoreCase(origen.getEstado())) {
            return "error=cancelada";
        }
        if (origen.isTieneSeguimiento()) {
            return "error=yaseguimiento";
        }
        return null;
    }

    // Muestra el formulario con los datos de la cita original
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Usuario doctor = doctorLogueado(req);
        if (doctor == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException e) {
            volver(req, resp, "error=cita");
            return;
        }

        // Solo devuelve la cita si es de este doctor
        Cita origen = new CitaDAO().obtenerPorIdDeDoctor(id, doctor.getIdUsuario());
        if (origen == null) {
            volver(req, resp, "error=cita");
            return;
        }

        String rechazo = motivoRechazo(origen);
        if (rechazo != null) {
            volver(req, resp, rechazo);
            return;
        }

        req.setAttribute("citaOrigen", origen);
        req.getRequestDispatcher("/medico/seguimiento.jsp").forward(req, resp);
    }

    // Guarda la nueva cita
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        Usuario doctor = doctorLogueado(req);
        if (doctor == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        try {
            int idOrigen = Integer.parseInt(req.getParameter("idOrigen"));
            LocalDate fecha = LocalDate.parse(req.getParameter("fecha"));
            LocalTime hora = LocalTime.parse(req.getParameter("hora"));
            String causa = req.getParameter("causa");

            if (fecha.isBefore(LocalDate.now())) {
                volver(req, resp, "error=fecha");
                return;
            }
            if (causa == null || causa.isBlank()) {
                volver(req, resp, "error=datos");
                return;
            }

            // Se vuelve a leer la cita desde la base: paciente y doctor
            // salen de aquí, no de lo que mande el navegador
            CitaDAO dao = new CitaDAO();
            Cita origen = dao.obtenerPorIdDeDoctor(idOrigen, doctor.getIdUsuario());
            if (origen == null) {
                volver(req, resp, "error=cita");
                return;
            }

            // Cita cancelada o que ya tiene seguimiento
            String rechazo = motivoRechazo(origen);
            if (rechazo != null) {
                volver(req, resp, rechazo);
                return;
            }

            // Choque de horario con otra cita del mismo doctor
            if (dao.existeCitaEnHorario(origen.getIdDoctor(), fecha, hora)) {
                volver(req, resp, "error=horario");
                return;
            }

            Cita nueva = new Cita();
            nueva.setIdCitaOrigen(origen.getIdCita());
            nueva.setIdPaciente(origen.getIdPaciente());
            nueva.setIdDoctor(origen.getIdDoctor());
            nueva.setFechaCita(fecha);
            nueva.setHoraInicio(hora);
            nueva.setCausa(causa.trim());

            boolean guardado = dao.crearSeguimiento(nueva);
            volver(req, resp, guardado ? "ok=1" : "error=guardar");

        } catch (NumberFormatException | NullPointerException | DateTimeParseException e) {
            volver(req, resp, "error=datos");
        }
    }
}