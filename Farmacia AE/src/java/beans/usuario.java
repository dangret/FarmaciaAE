/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JOptionPane;

/**
 *
 * @author sears
 */
public class usuario {

    private String login = "postgres";
    private String password = "postgres";
    private String url = "jdbc:postgresql://localhost:5432/Farmacia";

    public int ultimo() {
        Connection conn = null;
        PreparedStatement ps = null;
        Statement st = null;
        ResultSet rs = null;
        int ult = 0;

        try {
            //conexion a la base de datos   
            try {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection(url, login, password);
                System.out.println("CONECTADO CORRECTAMENTE");
            } catch (ClassNotFoundException ex) {
                JOptionPane.showMessageDialog(null, "Error en la Conexion con la Base de Datos");
            }
            String sql = "SELECT MAX(idusuario) from usuario";
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                ult = rs.getInt(1);
                System.out.println(ult);
            }

        } catch (SQLException ex) {
            System.out.println("Error al conectar la BD");

        } finally {

            try {
                if (st != null) {
                    st.close();
                }
                if (conn != null) {
                    conn.close();
                }

            } catch (SQLException ex) {
                JOptionPane.showMessageDialog(null, "ERROR AL CERRAR LA CONEXION A LA BASE DE DATOS.");
            }
        }

        return ult;
    }
}
