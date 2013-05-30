<%-- 
    Document   : altaPersonas
    Created on : 14/05/2013, 05:14:58 AM
    Author     : JESUS
--%>

<%@page import="java.util.Date"%>
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
    int idcliente = request.getParameter("modificar")==null?0:Integer.parseInt(request.getParameter("modificar"));
    Persona p = null;
    String nombre="", rfc="", appat="", apmat="", fechnac="", telefono="", direccion="", email="", celular="";
    SimpleDateFormat sdffecha = new SimpleDateFormat("yyyy-MM-dd");
    if(idcliente!=0) {
        p = ejb.consultaPorId(idcliente);
        nombre=p.getNombre()==null?"":p.getNombre();
        rfc=p.getRfc()==null?"":p.getRfc();
        appat=p.getAppat()==null?"":p.getAppat();
        apmat=p.getApmat()==null?"":p.getApmat();
        fechnac=sdffecha.format(p.getFechnac())==null?"":sdffecha.format(p.getFechnac());
        telefono=p.getTelefono()==null?"":p.getTelefono();
        direccion=p.getDireccion()==null?"":p.getDireccion();
        email=p.getEmail()==null?"":p.getEmail();
        celular=p.getCelular()==null?"":p.getCelular();
    }
%>
<html>
    <head>
        <script src="js/jquery-2.0.1.js" type="text/javascript"></script>
        <script src="js/jquery.maskedinput.js" type="text/javascript"></script>
        <script>
             jQuery(function($){
                $("#jnombre").mask("aaaaaa",{placeholder:" "});
                //$("#jrfc").mask("AAAAAAAAAAAAAAA",{placeholder:" "});
                //$("#jappat").mask("AAA?AAAAAAAAA",{placeholder: " "});
                //$("#japmat").mask("AAA?AAAAAAAAA",{placeholder: " "});
                //$("#jfechnac").mask("99/99/9999",{placeholder: " "});
                //$("#jtel").mask("(999) 999-9999",{placeholder: " "});
                //$("#jappat").mask("AAA?AAAAAAAAA",{placeholder: " "});
                //$("#jappat").mask("AAA?AAAAAAAAA",{placeholder: " "});
                
            });
            
            function cancelar() {
                window.location="portal.jsp";
            }
         </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FARMACIA SAN CAZOLA - EDITAR</title>
        
    </head>
    <body>
        <h1>Alta/Modificacion de Personas</h1>
        <form method="POST" id="jform" action="consultaPersonas.jsp?idcliente=<%=idcliente%>">
            <table>
                <tr>
                    <td>Nombre</td>
                    <td><input type="text" id="jnombre" name="nombre" value="<%=nombre%>"></td>
                </tr>
                <tr>
                    <td>RFC (si no tiene deje el campo en blanco)</td>
                    <td><input type="text" id="jrfc" name="rfc" value="<%=rfc%>"></td>
                </tr>
                <tr>
                    <td>Apellido Paterno</td>
                    <td><input type="text" id="jappat" name="appat" value="<%=appat%>"></td>
                </tr>
                <tr>
                    <td>Apellido Materno</td>
                    <td><input type="text" id="japmat" name="apmat" value="<%=apmat%>"></td>
                </tr>
                <td>Fecha de Nacimiento: </td>
                <td><input type="date" name="fechnac" id="jfechnac" id="fechnac" value="<%=fechnac%>"></td>
                <tr>
                    <td>Telefono</td>
                    <td><input type="text" id="jtel" name="telefono" value="<%=telefono%>"></td>
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
                    <td><input type="submit" value="Guardar" id="btn-submit" name="btnGuardar"></td>
                    <td><input type="button" value="Cancelar" name="btnCancelar" onclick="cancelar();"</td>
                </tr>
            </table>
        </form>
        
    </body>
</html>
