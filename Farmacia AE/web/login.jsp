<%-- 
    Document   : login
    Created on : 15/05/2013, 12:30:30 AM
    Author     : JESUS
--%>

<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="ittepic.edu.mx.clases.Codificador"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    EJBUsuariosRemote ejb = null;

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
    Usuario user = (Usuario) session.getAttribute("usuario") == null ? null : (Usuario) session.getAttribute("usuario");
    
    if (user == null){
        
        String usuario = request.getParameter("txtNombre") == null ? "" : request.getParameter("txtNombre");
        String password = request.getParameter("txtPasswd") == null ? "" : request.getParameter("txtPasswd");

        if ( !usuario.equals("") && !password.equals("") ){
            Codificador codec = new Codificador ();
            password = codec.encriptar(password, "MD5");

            user = ejb.obtenerUsuario(usuario, password);

            if (user != null){
                session.setAttribute("usuario", user);
            }

        }
    }else{
        response.sendRedirect("index.jsp");
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h2>Iniciar Sesion:</h2>
        <br>
        <form action="login.jsp" method="POST">
            <table>
                <tr>
                    
                    <td>Usuario:</td><td><input type="text" name="txtNombre"></td>
                </tr>
                <tr>
                    <td>Password:</td><td><input type="password" name="txtPasswd"></td>
                </tr>
            </table>
            <center> <input type="submit" name="btnEnviar" ></center>
        </form>
    </body>
</html>
