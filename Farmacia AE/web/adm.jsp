<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>

﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user == null){
        response.sendRedirect("index.jsp");
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Farmacias Chichis para la Banda!!!</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
<div id="wrap">
  <div id="header">
    <div id="logo">
      <h1>Medicinas con Iva+</h1>
      <h1>Gracias EPN</h1>
      
    </div>
    <ul id="nav">
      <li><a href="#">Mi Perfil</a></li>
      <li><a href="#"> Productos</a></li>
      <li><a href="#">Pedidos</a></li>
      <li><a href="#">Clientes</a></li>
      <li><a href="#">Usuarios</a></li>
    </ul>
  </div>
  <!-- /header -->
  <div id="content"> <img src="images/img.jpg" alt="" class="img" />
    <div class="side fr">
      
      <div id="bm"> <img src="images/s.jpg" alt="" /> </div>
    </div>
    <div class="main fl">
      <div id="text">
        <h2>Datos del Cliente</h2>
        <p> Datos del cliente y sus medios de pago <br/>
          <br/>
        
      </div>
      
      
        
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
