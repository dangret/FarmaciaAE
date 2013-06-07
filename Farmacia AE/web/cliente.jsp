<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Usuario user = (Usuario) session.getAttribute("usuario") == null ? null : (Usuario) session.getAttribute("usuario");
    boolean userValido = false;
    if (user != null)
        if (user.getEstado())
            if (user.getTipousuario().getIdtipousuario() == 2)
                userValido = true;
    
    if (!userValido) response.sendRedirect("index.jsp");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Farmacias!!!</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script>
    function cargarCarrito(cc)
    {
        document.getElementById('iframe1').src=cc;
    }
</script>
</head>
<body>
<div id="wrap">
  <div id="header">
      <iframe marginwidth="0" marginheight="0" width="200" height="40" scrolling="no" frameborder=0 id="iframe2" src="" align="right"></iframe>
    <div id="logo">
      <h1>Medicinas con Iva+</h1>      
    </div>
    <ul id="nav">
      <li><a href="#">Mi Cuenta</a>
            <ul>
                <li><a href="#" onclick="cargarCarrito('modificaUsuario.jsp')">Datos Personales</a></li>
                <li><a href="#" onclick="cargarCarrito('modificaTarjetas.jsp')">Administrar Tarjetas</a></li>
            </ul>
      </li>
      <li><a href="#" onclick="cargarCarrito('carritoCliente.jsp');">Productos</a></li>
      <li><a href="#" onclick="cargarCarrito('compraActual.jsp');">Mi Compra</a></li>
      <li><a href="#" onclick="cargarCarrito('historialCompras.jsp');">Historial Compras</a></li>
      <li><a href="salir.jsp">Cerrar Sesion</a></li>
    </ul>
  </div>
  <!-- /header -->
   <div id="content"> <img src="images/img.jpg" alt="" class="img" />
       <iframe marginwidth="0" marginheight="0" width="850" height="370" scrolling="yes" frameborder=0 id="iframe1" src=""></iframe>
    <!-- /content -->
  </div>
  <div class="clearfix"></div>
  <div id="footer">
    <div id="ftinner">
      <div class="ftlink fl"> <a href="#">Home</a> | <a href="#">About Us</a> | <a href="#">Production</a> | <a href="#">Submission</a> | <a href="#">Contact</a>
        <p id="copyright">© 2008. All Rights Reserved. <br/>
          Designed by <a href="http://www.free-css-templates.com/">Free CSS Templates</a>, Thanks to <a href="http://www.openwebdesign.org/">Web Design Dubai</a></p>
      </div>
      <div class="valid fr"><img src="images/xhtml.gif" alt="xhtml valid" /> <img src="images/css.gif" alt="css valid" /></div>
    </div>
  </div>
  <!-- /footer -->
</div>
</body>
</html>
