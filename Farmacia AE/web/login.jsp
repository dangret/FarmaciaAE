<%-- 
    Document   : login
    Created on : 15/05/2013, 12:30:30 AM
    Author     : JESUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h2>Iniciar Sesion:</h2>
        <br>
        <form action="http://localhost/Farmacia_AE/ServletLogin" method="POST">
            <table>
                <tr>
                    <td>Usuario:</td><td><input type="text" name="txtNombre"></td>
                </tr>
                <tr>
                    <td>Password:</td><td><input type="text" name="txtPasswd"></td>
                </tr>
            </table>
            <input type="submit" name="btnEnviar">
            <a href="portal.jsp">Portal</a>
            <a href="registroUsuario.jsp">Registrarse</a>
        </form>
    </body>
</html>
