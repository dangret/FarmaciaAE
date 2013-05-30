<%-- 
    Document   : infoInicio
    Created on : 26-may-2013, 23:54:37
    Author     : MartinNTT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="style.css" />
        <script>
            function abrirVent(){
                window.open("login.jsp",_self)
            }
            
        </script>
    </head>
    <body>
        <div class="side fr">
      <div id="bm"> <img src="images/s.jpg"  width="200" height="250" /> </div>
    </div>
    
    <div class="main fl">
      <div id="text">
        <h2>Compra Tu Medicinas Al Mejor Precio</h2>
        <h3> Similares a tu alcance!!! parecen lo mismo pero solo parecen jajja <a href="http://www.farmaciasdesimilares.com.mx/">Somos Mejor que Esto!!!!!</a></h3> <br/>
          <br/>
              <ul>
              <li><a href="carritoCliente.jsp">Mi Compra</a></li>  
              <li> <a href="login.jsp">Login</a></li>  
              <li> <a href="registroUsuario.jsp">Registrar un Usuario</a></li>
              <li> <a onclick="miFuncion();"> Eliminar un Usuario</a></li>  
              <li> <a href="wpProductoAlta.jsp">Alta Producto</a></li>  
              <li><button onclick="abrirVent();">venga</button></li>  
              </ul>
    </div>
    <!-- /content -->
  </div>
    </body>
</html>
