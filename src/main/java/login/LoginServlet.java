/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package login;

/**
 *
 * @author helen
 */

import java.io.IOException;
import jakarta.servlet.*;              
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    @Override 
     protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String contrasena = request.getParameter("contrasena");

        Usuario u = new UsuarioDAO().validar(nombre, contrasena);

        if (u == null) {
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("usuario", u);

        String base = request.getContextPath();
        switch (u.getTipo().toLowerCase()) {
            case "admin" -> response.sendRedirect(base + "/admin/inicio.jsp");
            case "doctor" -> response.sendRedirect(base + "/doctor/inicio.jsp");
            case "user" -> response.sendRedirect(base + "/user/inicio.jsp");
            default -> {
                session.invalidate();
                request.setAttribute("error", "Rol no reconocido");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        }
    }
}
