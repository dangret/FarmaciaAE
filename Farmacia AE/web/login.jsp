<%-- 
    Document   : login
    Created on : 15/05/2013, 12:30:30 AM
    Author     : JESUS
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page import="javax.script.ScriptEngine"%>
<%@page import="javax.script.ScriptEngineManager"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="ittepic.edu.mx.clases.Codificador"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    EJBUsuariosRemote ejb = null;

    public void jspInit() {
        try {
            InitialContext ic = new InitialContext();
            ejb = (EJBUsuariosRemote) ic.lookup(EJBUsuariosRemote.class.getName());
            System.out.println("Bean cargado");
        } catch (Exception ex) {
            System.out.println("Error:"
                    + ex.getMessage());
        }
    }
%>
<%
    Usuario user = (Usuario) session.getAttribute("usuario") == null ? null : (Usuario) session.getAttribute("usuario");
    if (user == null){
        
        String usuario = request.getParameter("txtNombre") == null ? "" : request.getParameter("txtNombre");
        String password = request.getParameter("txtPasswd") == null ? "" : request.getParameter("txtPasswd");

        if ( !usuario.equals("") && !password.equals("") ){
            Codificador codec = new Codificador ();
            password = codec.encriptar(password, "MD5");
            user = ejb.obtenerUsuario(usuario, password);
            int tipoUsr= user.getTipousuario().getIdtipousuario();

            if (user != null){
                session.setAttribute("usuario", user);
                 if(tipoUsr==1){
                    response.sendRedirect("adm.jsp");
                }else{
                    if(tipoUsr==2){
                    response.sendRedirect("cliente.jsp");
                }
                }
            }

        }
    }else{
        response.sendRedirect("index.jsp");
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css" />
        <title>Login</title>
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
      <div  class="main fl " align="center">
          <br></br>
                <br></br>
            <div class="text">
        <h2>Iniciar Sesion:</h2>
        <br>
        <form action="login.jsp" method="POST">
            <table>
                <tr>
                    <td>Usuario:</td><td><input type="text" name="txtNombre"></td>
                </tr>
                <tr>
                    <td>Password:</td><td><input type="password" name="txtPasswd"></td>
                </tr>
                <tr><td><input type="submit" name="btnEnviar" ></td></tr>
            </table>
             
        </form>
            </div>
     </div><div class="text" align="left"><object data="registroUsuario.jsp" width="350" height="550"></object></div>
            
              <div class="clearfix"></div>
  <div id="footer">
    <div id="ftinner">
      <div class="valid fr"><img src="images/xhtml.gif" alt="xhtml valid" /> <img src="images/css.gif" alt="css valid" /></div>
    </div>
  </div>
  <!-- /footer -->
</div>
      
    </body>
</html>
