package citas;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import login.Usuario;

@WebServlet("/medico/citas")
public class CitasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession sesion = req.getSession(false);
        Usuario usuario = (sesion == null) ? null : (Usuario) sesion.getAttribute("usuario");

        // Solo entra quien haya iniciado sesión Y sea doctor
        if (usuario == null || !"doctor".equalsIgnoreCase(usuario.getTipo())) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        req.setAttribute("citas", new CitaDAO().listarPorUsuarioDoctor(usuario.getIdUsuario()));
        req.getRequestDispatcher("/medico/citas.jsp").forward(req, resp);
    }
}