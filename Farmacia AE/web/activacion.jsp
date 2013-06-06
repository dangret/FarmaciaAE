<%-- 
    Document   : activacion
    Created on : 5/06/2013, 11:55:11 PM
    Author     : sears
--%>

<%@page import="ittepic.edu.mx.clases.Mail"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!    EJBUsuariosRemote ejb = null;

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
    String login = request.getParameter("r") == null ? "" : request.getParameter("r");
    login=login.replaceAll(" ", "+");
    boolean band=false;
    Mail m=new Mail();
    Usuario usr=null;
    if(!login.equals("")){
    try{
    String des=m.desencriptar(login);
    usr = ejb.consultaPorNombre(des);
    if(usr.getEstado()==true){
        band=true;
        //response.sendRedirect("index.jsp");
    }else{
        if(usr!=null){
            usr.setEstado(true);
            ejb.alta(usr);
        }
    }
    }catch(Exception e){
     band=false;   
    }
    }
       
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CUENTA ACTIVADA</title>
    </head>
    <body>
        <%if (!band){%>
        <% if ((!login.equals("")) && (usr!=null)){%>
        <table border="1">
            Tu Cuenta ha sido Creada Exitosamente:<b><%=usr.getLogin()%></b><br>
            Fecha Creacion:<b><%=usr.getFechacreacion()%></b><br>
            <a href="index.jsp">Regresar al Menu Principal</a>
        </table>
        <%}else{%>
        <table border="1">
            <h3>La Pagina que usted solicito, No existe...</h3>
            <a href="index.jsp">Regresar al Menu Principal</a>
        </table>
        <%}%>
        <%}else{%>
        <table border="1">
            <h3>El Usuario ya se encuentra Registrado...</h3>
            <a href="index.jsp">Regresar al Menu Principal</a>
        </table>
        <%}%>
    </body>
</html>
