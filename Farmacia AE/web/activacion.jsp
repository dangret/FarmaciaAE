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
    Mail m=new Mail();
    Usuario usr=null;
    if(!login.equals("")){
    String des=m.desencriptar(login);
    System.out.println(des);
    usr = ejb.consultaPorNombre(des);//==null?null:ejb.consultaPorNombre(login);
        if(usr!=null){
            usr.setEstado(true);
            ejb.alta(usr);
        }
    }
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CUENTA ACTIVADA</title>
    </head>
    <body>
        <% if ((!login.equals("")) && (usr!=null)){%>
        <table border="1">
            Tu Cuenta ha sido Creada Exitosamente:<b><%=usr.getLogin()%></b><br>
            Fecha Creacion:<b><%=usr.getFechacreacion()%></b><br>
            <a href="index.jsp">Regresar al Menu Principal</a>
        </table>
        <%}else{%>
        <table border="1">
            <h3>Usuario No existente</h3>
            <a href="index.jsp">Regresar al Menu Principal</a>
        </table>
        <%}%>
    </body>
</html>
