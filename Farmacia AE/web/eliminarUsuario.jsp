<%-- 
    Document   : eliminarUsuario
    Created on : 17/05/2013, 02:00:41 AM
    Author     : sears
--%>

<%@page import="ittepic.edu.mx.entidades.CatTiposusuario"%>
<%@page import="ittepic.edu.mx.entidades.CatTiposusuario"%>
<%@page import="ittepic.edu.mx.entidades.CatTiposusuario"%>
<%@page import="ittepic.edu.mx.entidades.CatTiposusuario"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="ittepic.edu.mx.entidades.Persona"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBTipoUsuarioLocal"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
<%@page import="ittepic.edu.mx.ejbs.EJBPersonasRemote"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%! EJBPersonasRemote ejb = null;
    EJBUsuariosRemote ejb2 = null;
    EJBTipoUsuarioLocal ejb3 = null;

    public void jspInit() {
        try {
            InitialContext ic = new InitialContext();
            ejb = (EJBPersonasRemote) ic.lookup(EJBPersonasRemote.class.getName());

            InitialContext ic2 = new InitialContext();
            ejb2 = (EJBUsuariosRemote) ic2.lookup(EJBUsuariosRemote.class.getName());

            InitialContext ic3 = new InitialContext();
            ejb3 = (EJBTipoUsuarioLocal) ic3.lookup(EJBTipoUsuarioLocal.class.getName());

            System.out.println("Bean cargado");
        } catch (Exception ex) {
            System.out.println("Error:"
                    + ex.getMessage());
        }
    }
%>
<%
    String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("nombre");
    Usuario usr;
    Persona per;
    CatTiposusuario tipoUsr;
    
    if (!usuario.equals("")) {
       usr=new Usuario();
       usr=ejb2.consultaPorNombre(usuario);
       ejb2.eliminarPorId(usr.getIdusuario());
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Usuarios</title>
        <script>
            function cancelar1() {
                window.location="index.jsp";
            }
                
        </script>
    </head>
    <body>
        <table border="1">
            <tr>
                <td>Usuario Eliminar:</td>
                <td><input type="text" name="usuario"></td>
            </tr>
            <tr>
                <td><input type="submit" name="guardar" value="Guardar"></td>
                <td> <input type="button" name="cancelar" value="Cancelar" onclick="cancelar1();"></td>
            </tr>
        </table>
    </body>
</html>
