﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Farmacias !!!</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script>
    function mandarLogin(variable)
    {
        document.getElementById('iframe1').src = variable;
    }
    function cargarPagina(cc)
    {
        document.getElementById('iframe1').src=cc;
    }
</script>
</head>
<body>
<div id="wrap">
  <div id="header">
    <div id="logo">
      <h1>Medicinas con Iva+</h1>
    </div>
    <ul id="nav">
      <li><a href="#" onclick="cargarPagina('miCuenta.jsp')">Mi Perfil</a></li>
      <li><a href="#" onclick="cargarPagina('wpProductoConsulta.jsp')"> Productos</a></li>
      <li><a href="#" onclick="cargarPagina('wpPedidos.jsp')">Pedidos</a></li>
      <li><a href="#" onclick="cargarPagina('consultaUsuarios.jsp')">Usuarios</a></li>
      <li><a href="salir.jsp">Cerrar Sesion</a></li>
    </ul>
  </div>
   <div id="content"> <img src="images/img.jpg" alt="" class="img" />
       <iframe marginwidth="0" marginheight="0" width="850" height="370" scrolling="yes" frameborder=0 id="iframe1" src="about:blank"></iframe>
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
