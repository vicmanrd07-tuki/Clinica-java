package consultas;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import login.Usuario;

@WebServlet("/consultas")
public class ConsultaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println(">>> Entró al servlet");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        Usuario u = (Usuario) session.getAttribute("usuario");
        int idUsuario = u.getIdUsuario();
        System.out.println(">>> idUsuario: " + idUsuario);

        Consulta c = new Consulta();
        c.setNombre(request.getParameter("nombre"));
        c.setApellido(request.getParameter("apellido"));
        c.setCui(request.getParameter("cui"));
        c.setFechaNacimiento(LocalDate.parse(request.getParameter("fechaNacimiento")));
        c.setTelefono(request.getParameter("telefono"));
        c.setCorreo(request.getParameter("correo"));
        c.setCausa(request.getParameter("causa"));
    c.setIdDoctor(Integer.parseInt(request.getParameter("doctor")));
    c.setFechaCita(LocalDate.parse(request.getParameter("fechaCita")));
    c.setHoraCita(LocalTime.parse(request.getParameter("hora")));

       try {
    boolean ok = new ConsultaDAO().registrar(c, idUsuario);
    if (ok) {
        session.setAttribute("mensaje", "La cita se registró con éxito.");
        session.setAttribute("tipoMensaje", "success");
    } else {
        session.setAttribute("mensaje", "El doctor no está disponible en esa fecha y hora. Elija otro horario.");
        session.setAttribute("tipoMensaje", "error");
    }
    response.sendRedirect(request.getContextPath() + "/user/inicio.jsp");
    } catch (SQLException e) {
    e.printStackTrace();
    throw new ServletException(e);
    }
    }
}