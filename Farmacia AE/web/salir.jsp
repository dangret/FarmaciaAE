<%-- 
    Document   : salir
    Created on : 30-may-2013, 21:21:28
    Author     : dangret
--%>

<%@page import="java.util.Timer"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    Usuario user = (Usuario)session.getAttribute("usuario") == null ? null : (Usuario)session.getAttribute("usuario");
    if (user != null){
        session.invalidate();;
    }else{
        response.sendRedirect("index.jsp");
    } 
%>
<html>
    <head>
        <script>
            window.onload = function () {
                window.setInterval('bajarcontador()',1000);
            }
            var segundos = 4;
            function bajarcontador(){
                segundos = segundos - 1 ;
                if (segundos >0){
                    document.getElementById("timeout").innerHTML = "se <a href='index.jsp'>redireccionará</a> en "+segundos+" segundos automaticamente";
                }else{
                    window.location = "index.jsp";
                }
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        
    </head>
    <body>
        <h1>Se ha Cerrado la Session</h1>
        <div id="timeout" ></div>
        
    </body>
</html>
