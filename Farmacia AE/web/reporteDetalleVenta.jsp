<%-- 
    Document   : reporteDetalleVenta
    Created on : 5/06/2013, 04:41:00 PM
    Author     : JESUS
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="ittepic.edu.mx.entidades.Producto"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="ittepic.edu.mx.entidades.Venta"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBCarritoClienteLocal"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ittepic.edu.mx.entidades.Detalleventa"%>
<%@page import="ittepic.edu.mx.entidades.Detalleventa"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    public EJBCarritoClienteLocal carritoCliente = null;
            
    public void jspInit() {
        try {
            InitialContext ic = new InitialContext();
            carritoCliente = (EJBCarritoClienteLocal) ic.lookup(EJBCarritoClienteLocal.class.getName());
        } catch (Exception e){
            e.printStackTrace();
        }
    }
%>
<%
    Usuario sesionUser = (Usuario) session.getAttribute("usuario") == null ? null : (Usuario) session.getAttribute("usuario");
    if (session.getAttribute("carritoCliente") != null) carritoCliente = (EJBCarritoClienteLocal) (session.getAttribute("carritoCliente"));
    int idventa=request.getParameter("idventa")==null?0:Integer.parseInt(request.getParameter("idventa"));
    int bandera = 0;
    List<Producto> medicamentos = new ArrayList();
    List<Detalleventa> detallesventas = new ArrayList();
   
    List<Double> montoTotalVenta = new ArrayList();
    detallesventas = carritoCliente.getDetalleventa();
    medicamentos = carritoCliente.getMedicamentos();
    double costoProductos = 0;
    DecimalFormat df = new DecimalFormat("#.##");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <center>
        <%
            
        %>
        <%for(int j=0; j<detallesventas.size();j++){
          if(detallesventas.get(j).getIdventa().getIdventa()==idventa){
             bandera = 1;
          }
        }
        if(bandera==1){%>
        <table align="center" border="3">
                        <tr>
                            <th style="background-color: darkred; color: white"><center><b>&nbsp;&nbsp;Medicamento&nbsp;&nbsp;</b></center></th>
                            <th style="background-color: darkred; color: white"><center><b>&nbsp;&nbsp;Cantidad&nbsp;&nbsp;</b></center></th>
                            <th style="background-color: darkred; color: white"><center><b>&nbsp;&nbsp;Costo&nbsp;&nbsp;</b></center></th>
                        </tr>
                        <%for (int i=0; i<detallesventas.size(); i++) {
                            if(detallesventas.get(i).getIdventa().getIdventa()==idventa){%>
                            <tr>
                                <td><center><%out.println(detallesventas.get(i).getIdproducto().getProducto());%></center></td>
                                <td><center><%out.println(detallesventas.get(i).getCantidad());%></center></td>
                                <%
                                    for(int k=0;k<medicamentos.size();k++)
                                    {
                                        int var1 = medicamentos.get(k).getIdproducto();
                                        int var2 = detallesventas.get(i).getIdproducto().getIdproducto();
                                        if(var1 == var2)
                                        {
                                         costoProductos = medicamentos.get(k).getPrecio()*detallesventas.get(i).getCantidad();                                      
                                        }
                                    }
                                %>
                                <td><center>$<%out.print(df.format(costoProductos));%></center></td>
                                <%costoProductos = 0;%>
                            </tr>
                                  
                            <%}%>
                         <%}%>
       </table>
       <%}else{%>
            <h1><center>No existen productos en esta venta</center></h1>
       <%}%>
       <a href = "reporte.jsp">Generar Reporte</a>
    </center>
    </body>
</html>
