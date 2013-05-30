<%-- 
    Document   : altaTarjetas
    Created on : 30/05/2013, 01:10:37 AM
    Author     : sears
--%>

<%@page import="java.util.List"%>
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
<%!    EJBTarjetaLocal ejb = null;
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
    int combo = request.getParameter("combo") == null ? -1 : Integer.parseInt(request.getParameter("combo"));
    String tarjeta = request.getParameter("tarjeta") == null ? "" : request.getParameter("tarjeta");
    int codigo = request.getParameter("codigo") == null ? 0 : Integer.parseInt(request.getParameter("codigo"));
    String fechav = request.getParameter("fechaV") == null ? "" : request.getParameter("fechaV");    
    Numtarjeta cuenta=null;
    if(!tarjeta.equals("")){
    cuenta = ejb.consultaPorTarjeta(tarjeta);
    }
    
    List<Numtarjeta> tarjetas = ejb.consultaId(2);
    String dia = "", mes = "", año = "";

    if (combo != -1) {
        Date fechaV = tarjetas.get(combo).getFechacaducidad();
        SimpleDateFormat formato1 = new SimpleDateFormat("dd");
        SimpleDateFormat formato2 = new SimpleDateFormat("MM");
        SimpleDateFormat formato3 = new SimpleDateFormat("yyyy");
        dia = formato1.format(fechaV);
        mes = formato2.format(fechaV);
        año = formato3.format(fechaV);
    }

    if ((!tarjeta.equals("")) || (codigo != 0) || (!fechav.equals(""))) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaM = format.parse(fechav);

        //CUANDO ESTE LISTA LA SESSION
        //Persona per=ejb2.consultaPorId(user.getIdcliente().getIdcliente());

        Persona per = new Persona();
        per.setIdcliente(2);
        //cuenta.setNotarjeta(tarjeta);
        cuenta.setIdcliente(per);
        cuenta.setCodigoseguridad(codigo);
        cuenta.setFechacaducidad(fechaM);
        ejb.modificar(cuenta);
    }


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta de Tarjetas</title>
        <script>
            function cancelar1() {
                window.location="index.jsp";
            }
        </script>
    </head>
    <body>
        <form action="modificaTarjetas.jsp" method="POST">
            <table border="1">
                <%if (combo < 0){%>
                <tr><td>TARJETAS: 
                    </td>
                    <td><SELECT NAME="combo" SIZE=1> 
                            <option value="#">:: Seleccione ::</option>
                            <%for (int i = 0; i < tarjetas.size(); i++) {%>
                            <OPTION VALUE="<%=i%>"><%=tarjetas.get(i).getNotarjeta()%></OPTION>
                            <%}%>
                        </SELECT>
                    </td>
                </tr>
                <%}%>
                <%if(combo>=0){%>
                <tr>
                    <td>* Tarjeta: </td>
                    <td><input type="text" name="tarjetax" value="<%=tarjetas.get(combo).getNotarjeta()%>" disabled="true"></td>
                    <td><input type="hidden" name="tarjeta" value="<%=tarjetas.get(combo).getNotarjeta()%>"></td>
                </tr>
                <tr>
                    <td>* Codigo de Seguridad: </td>
                    <td><input type="text" name="codigo" value="<%=tarjetas.get(combo).getCodigoseguridad()%>"></td>
                </tr>
                <tr>
                    <td>* Fecha Caducidad: </td>
                    <td><input type="date" name="fechaV" value="<%=año + "-" + mes + "-" + dia%>"></td>
                </tr>
            </table>

            <%}%>
            <table border="1">
                <br>
                <tr align="center">
                <input type="submit" id="btn-submit" name="modificar">

                <input type="button" name="cancelar" value="Cancelar" onclick="cancelar1();">
                </tr>
            </table>
        </form>
    </body>
</html>