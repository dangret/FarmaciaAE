<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Farmacias!!!</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script>

    function mandarLogin(variable)
    {
        document.getElementById('iframe1').src = variable;
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
      <li><a href="index.jsp">Inicio</a></li>
      <li><a onclick="mandarLogin('productoConsulta.jsp');">Productos</a></li>
      <li><a href="login.jsp">Login</a></li>
      <li><a onclick="mandarLogin('contacto.jsp');">Contacto</a></li>
    </ul>
      <br></br>
          <br></br>
           <img src="images/img.jpg" alt="" class="img" />
           <br></br>
           <br></br>
  </div>
    <div id="content">
        <br><p>    
                <br></br>
            
            </p></br>
        <center>
        <iframe width="800" align="middle" height="370" scrolling="yes" frameborder=0 id="iframe1" src="infoInicio.jsp" >    
  </iframe></center>
  </div>
   <div class="clearfix"></div>
  <div id="footer">
    <div id="ftinner">
      <div class="valid fr"><img src="images/xhtml.gif" alt="xhtml valid" /> <img src="images/css.gif" alt="css valid" /></div>
    </div>
  </div>
  <!-- /footer -->
</div>
</div>  >
  <!-- /footer -->
</div
</body>
</html>
