<%-- 
    Document   : index
    Created on : 14-may-2013, 0:28:41
    Author     : Daniel
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
        <form action="/ServletLogin" method="POST">
            <table>
                <tr>
                    <td>Usuario:</td><td><input type="text" name="txtNombre"></td>
                </tr>
                <tr>
                    <td>Password:</td><td><input type="text" name="txtPasswd"></td>
                </tr>
            </table>
            <input type="submit" name="btnEnviar">
        </form>
    </body>
</html>
