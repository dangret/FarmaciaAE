<%-- 
    Document   : altaTarjetas
    Created on : 30/05/2013, 01:10:37 AM
    Author     : sears
--%>

<%@page import="com.sun.org.apache.bcel.internal.generic.AALOAD"%>
<%@page import="ittepic.edu.mx.ejbs.EJBPersonasRemote"%>
<%@page import="ittepic.edu.mx.entidades.Persona"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ittepic.edu.mx.entidades.Numtarjeta"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBTarjetaLocal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%!    
    EJBTarjetaLocal ejb = null;
    EJBPersonasRemote ejb2 = null;

    public void jspInit() {
        try {
            InitialContext ic = new InitialContext();
            ejb = (EJBTarjetaLocal) ic.lookup(EJBTarjetaLocal.class.getName());
            
            InitialContext ic2 = new InitialContext();
            ejb2 = (EJBPersonasRemote) ic2.lookup(EJBPersonasRemote.class.getName());
            
            System.out.println("Bean cargado");
        } catch (Exception ex) {
            System.out.println("Error:"
                    + ex.getMessage());
        }
    }
%>
<%
    Usuario user = (Usuario) session.getAttribute("usuario") == null ? null : (Usuario) session.getAttribute("usuario");
    boolean userValido = false;
    if (user != null)
        if (user.getEstado())
                userValido = true;
    
    if (!userValido) response.sendRedirect("index.jsp");
    else{
%>

<%
       
        Numtarjeta cuenta=new Numtarjeta();
        String tarjeta = request.getParameter("tarjeta") == null ? "" : request.getParameter("tarjeta");
        int codigo = request.getParameter("codigo") == null ? 0 : Integer.parseInt(request.getParameter("codigo"));
        String fecha = request.getParameter("fechaV")==null?"":request.getParameter("fechaV");

        if((!tarjeta.equals("")) || (codigo!=0) || (!fecha.equals(""))){
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaV = format.parse(fecha);

            //CUANDO ESTE LISTA LA SESSION
            //Persona per=ejb2.consultaPorId(user.getIdcliente().getIdcliente());
            
            

            cuenta.setNotarjeta(tarjeta);
            cuenta.setIdcliente(user.getIdcliente());
            cuenta.setCodigoseguridad(codigo);
            cuenta.setFechacaducidad(fechaV);
            ejb.alta(cuenta);
            response.sendRedirect("modificaTarjetas.jsp");
        }
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta de Tarjetas</title>
        <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
        <script src="js/jquery.maskedinput.js" type="text/javascript"></script>
        <script src="js/jquery.maskMoney.js" type="text/javascript"></script>
        <script>
            jQuery(function($){
               
               $("#btn-submit").click(function(){
                
                var numTarjReg=/[[\d]{16}|[\d]{18}]/;
                var regPing = /[\d]{3,4}/;
                var tarjeta = $("#ntarjeta").val();
                var pin = $("#pin").val();
               
        
                $(".error").hide();
                var valido = true;   
                
                if (!pin == ""){
                    if (!regPing.test(pin)){
                        $("#pin").after("<span class='error'>deben ser 3 o 4 digitos</span>")
                        valido=false;
                    }
                }else{
                    $("#pin").after("<span class='error'>falta codigo</span>")
                    valido=false;
                }
                
                if (!tarjeta == ""){
                    if (!regPing.test(pin)){
                        $("#pin").after("<span class='error'>contener 16 digitos como minimo</span>")
                        valido=false;
                    }
                }else{
                    $("#pin").after("<span class='error'>Falta No de tarjeta</span>")
                    valido=false;
                }
                
                
                if (!valido) return false;
                else return true;
               });
               
            });
            
            function cancelar1() {
                window.location="index.jsp";
            }
        </script>
    </head>
    <body>
        <form action="altaTarjetas.jsp" method="POST">
            <div align="center">
            <table border="1"> 
            <tr>
                <td>* Numero de Tarjeta: </td>
                <td><input type="text" id="ntarjeta" name="tarjeta"></td>
            </tr>
            <tr>
                <td>* Codigo de Seguridad: </td>
                <td><input type="text" id="pin" name="codigo"></td>
            </tr>
            <tr>
                <td>* Fecha Caducidad: </td>
                <td><input type="date" name="fechaV"></td>
            </tr>
            </table>
            <table border="1">
                <br>
                <tr align="center">
                <input type="submit" id="btn-submit" name="guardar" value="Guardar">

                <input type="button" name="cancelar" value="Cancelar" onclick="cancelar1();">
                </tr>
            </table>
            </div>
        </form>
    </body>
</html>
