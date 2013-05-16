<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!    EJBUsuariosRemote ejb = null;

    public void jspInit() {
        try {
            InitialContext ic = new InitialContext();
            ejb = (EJBUsuariosRemote) ic.lookup(EJBUsuariosRemote.class.getName());
            System.out.println("Bean cargado");
        } catch (Exception ex) {
            System.out.println("Error:"
                    + ex.getMessage());
        }
    }
%>
<%
    String nombre = request.getParameter("nombre");
    if (nombre != null) {
        String apepat = request.getParameter("apepat");
        String apemat = request.getParameter("apemat");
        String fecnac = request.getParameter("fecnac");
        String telf = request.getParameter("telf");
        String celular = request.getParameter("celular");
        String direccion = request.getParameter("direccion");
        String email = request.getParameter("email");
        Usuario usr = new Usuario();
        

    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta de alumnos</title>
    </head>
    <body>
        <div align="center">
            <H2>REGISTRO DE USUARIOS</H1>
        </div>

        <form name="formulario" action="consultaGeneral.jsp" method="POST">
            <script>
                function cancelar1() {
                    window.location="index.jsp";
                }
            </script>
            <div align="center">
                <table border="1">
                    <tr>
                        <td>Nombre: </td>
                        <td><input type="text" name="nombre" id="nombre"></td>
                    </tr> 
                    <tr>
                        <td>Apellido Paterno: </td>
                        <td><input type="text" name="apepat" id="apepat"></td>
                    </tr>
                    <tr>
                        <td>Apellido Materno: </td>
                        <td><input type="text" name="apemat" id="apemat"></td>
                    </tr>
                    <tr>
                        <td>Fecha de Nacimiento: </td>
                        <td><input type="date" name="fecnac" id="fecnac"></td>
                    </tr>
                    <tr>
                        <td>Teléfono Fijo: </td>
                        <td><input type="text" name="telf" id="telf"></td>
                    </tr>
                    <tr>
                        <td>Celular: </td>
                        <td><input type="text" name="celular" id="celular"></td>
                    </tr>
                    <tr>
                        <td>Direccion:<br>
                        <td>   <textarea name="direccion" cols="25" rows="5"></textarea></td>
                        </td>
                    </tr>
                    <tr>
                        <td>E-Mail: </td>
                        <td><input type="text" name="email" id="email"></td>
                    </tr>

                </table>
                <table border="1">
                    <br>
                    <tr>
                    <input type="submit" name="guardar" value="Guardar">
                    </tr>
                    <tr>
                    <input type="button" name="cancelar" value="Cancelar" onclick="cancelar1();">
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>
