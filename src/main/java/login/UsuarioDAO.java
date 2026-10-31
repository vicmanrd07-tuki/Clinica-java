/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package login;



import config.Conexion;
import java.sql.*;

public class UsuarioDAO {

    public Usuario validar(String nombre, String contrasena) {
        System.out.println("Buscando: [" + nombre + "] [" + contrasena + "]");
        String sql ="SELECT idUsuario, Nombreusuario, Tipo, Clinica_idClinica " 
         + "FROM usuario WHERE Nombreusuario = ? AND Contrasena = ?";
        
        try (Connection con = Conexion.getConexion();
                PreparedStatement ps=con.prepareStatement(sql)){
            
            ps.setString(1, nombre);
            ps.setString(2, contrasena);
            
            try(ResultSet rs= ps.executeQuery()){
                if (rs.next()){
                    int id = rs.getInt("idUsuario");
                    //SesionUsuario.setIdUsuario(id); 
                    Usuario u = new Usuario();
                    u.setIdUsuario(rs.getInt("idUsuario"));
                    u.setNombre(rs.getString("Nombreusuario"));
                    u.setTipo(rs.getString("Tipo"));
                    u.setIdClinica(rs.getInt("Clinica_idClinica"));
                    return u;
                }
            }
           
        }catch (SQLException e){
            e.printStackTrace();
        }
        return null;
    }
}