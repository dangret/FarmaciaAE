<%-- 
    Document   : principal
    Created on : 07-jun-2013, 4:21:20
    Author     : dangret
--%>

<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Usuario user = (Usuario) session.getAttribute("usuario") == null ? null : (Usuario) session.getAttribute("usuario");
    boolean userValido = false;
    if (user != null)
        if (user.getEstado())
                userValido = true;
    
    if (!userValido) response.sendRedirect("index.jsp");
    else{
       String nombre = user.getIdcliente().getNombre();
       String ap = user.getIdcliente().getAppat() == null ? "" : user.getIdcliente().getAppat();
       
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagina Pricipal</title>
    </head>
    <body>
        <br>
        <br>
        <br>
        <div align="center"> <h3>Bienvenido <%=nombre + " " + ap%></h3></div>
        <%}%>
    </body>
</html>
