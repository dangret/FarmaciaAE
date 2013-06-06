<%-- 
    Document   : miCuenta
    Created on : 31-may-2013, 1:17:55
    Author     : dangret
--%>

<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    
%>
<html>
    <head>
        <script src="ui-farmacia/js/jquery-1.9.1.js" type="text/javascript"></script>
        <script src="ui-farmacia/js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
        <link rel="stylesheet" href="ui-farmacia/css/farmacia-theme/jquery-ui-1.10.3.custom.css" />
        <script>
            window.load = function (){
                var user = <%=user%>
                if (user == null){
                     top.location.href = 'index.jsp';
                }
            }
            jQuery(function($){
                $("#tabs").tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
                $( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
            });
        </script>
        <style>
        .ui-tabs-vertical { width: 55em; }
        .ui-tabs-vertical .ui-tabs-nav { padding: .2em .1em .2em .2em; float: left; width: 12em; }
        .ui-tabs-vertical .ui-tabs-nav li { clear: left; width: 100%; border-bottom-width: 1px !important; border-right-width: 0 !important; margin: 0 -1px .2em 0; }
        .ui-tabs-vertical .ui-tabs-nav li a { display:block; }
        .ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active { padding-bottom: 0; padding-right: .1em; border-right-width: 1px; border-right-width: 1px; }
        .ui-tabs-vertical .ui-tabs-panel { padding: 1em; float: right; width: 40em;}
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mi Cuenta</title>
    </head>
    <body>
        <div>
            <div><h1>Mi Cuenta</h1></div>
            <div id="tabs" px="100px">
                <ul>
                    <li><a href="#tab-datoscuenta" >Datos de la Cuenta</a></li>
                    <li><a href="#tab-tarjetas">Administrar tarjetas</a></li>
                </ul>
                <div id="tab-datoscuenta">
                    <iframe width="auto" height="300" src="modificaUsuario.jsp?idusuario"  />
                </div>
                <div id="tab-tarjetas">
                    <div>
                        <iframe src="modificaUsuario.jsp"/>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
