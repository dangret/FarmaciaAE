<%-- 
    Document   : altaPersonas
    Created on : 14/05/2013, 05:14:58 AM
    Author     : JESUS
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ittepic.edu.mx.entidades.Persona"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBPersonasLocal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%! 
    EJBPersonasLocal ejb=null;
    public void jspInit(){
        try{
            InitialContext ic= new InitialContext();
            ejb =(EJBPersonasLocal) ic.lookup(EJBPersonasLocal.class.getName());
            System.out.println("Bean cargado");
        }catch (Exception ex) {
            System.out.println("Error:"+ ex.getMessage());
        }
        
    }
    
%>

<%    
    int idcliente = request.getParameter("idcliente")==null?0:Integer.parseInt(request.getParameter("idcliente"));
    Persona p = null;
    String nombre="", appat="", apmat="", fechnac="", telefono="", direccion="", email="", celular="";
    
    if(idcliente!=0) {
        p = ejb.consultaPorId(idcliente);
        nombre=p.getNombre()==null?"":p.getNombre();
        appat=p.getAppat()==null?"":p.getAppat();
        apmat=p.getApmat()==null?"":p.getApmat();
        fechnac=p.getFechnac().toString()==null?"":p.getFechnac().toString();
        telefono=p.getTelefono()==null?"":p.getTelefono();
        direccion=p.getDireccion()==null?"":p.getDireccion();
        email=p.getEmail()==null?"":p.getEmail();
        celular=p.getCelular()==null?"":p.getCelular();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
              function cancelar() {
                  window.location="portal.jsp";
              }
        </script>
    </head>
    <body>
        <h1>Alta Personas</h1>
        <form method="POST" action="consultaPersonas.jsp?idcliente=<%=idcliente%>">
            <table>
                 <tr>
                    <td>Nombre</td>
                    <td><input type="text" name="nombre" value="<%=nombre%>"></td>
                </tr>
                <tr>
                    <td>Apellido Paterno</td>
                    <td><input type="text" name="appat" value="<%=appat%>"></td>
                </tr>
                <tr>
                    <td>Apellido Materno</td>
                    <td><input type="text" name="apmat" value="<%=apmat%>"></td>
                </tr>
                <td>Fecha de Nacimiento: </td>
                    <td><input type="date" name="fechnac" id="fechnac"></td>
                <tr>
                    <td>Telefono</td>
                    <td><input type="text" name="telefono" value="<%=telefono%>"></td>
                </tr>
                <tr>
                    <td>Direccion</td>
                    <td><input type="text" name="direccion" value="<%=direccion%>"></td>
                </tr>
                <tr>
                    <td>Celular</td>
                    <td><input type="text" name="celular" value="<%=celular%>"></td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td><input type="text" name="email" value="<%=email%>"></td>
                </tr>
            </table>
            <table>
                <tr>
                    <td><input type="submit" value="Guardar" name="btnGuardar"></td>
                    <td><input type="button" value="Cancelar" name="btnCancelar" onclick="cancelar();"</td>
                </tr>
            </table>
        </form>
        
    </body>
</html>
