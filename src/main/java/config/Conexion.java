package config;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String URL = "jdbc:mysql://localhost:3306/clinica_db"
        + "?useSSL=false&allowPublicKeyRetrieval=true"
        + "&serverTimezone=UTC&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "EtuKyi9032i";

    public static Connection getConexion() throws SQLException {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        throw new SQLException("No se encontró el driver de MySQL", e);
    }
    return DriverManager.getConnection(URL, USER, PASSWORD);
}

}