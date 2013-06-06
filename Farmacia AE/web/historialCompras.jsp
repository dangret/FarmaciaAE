<%-- 
    Document   : underConstruction
    Created on : 30-may-2013, 23:16:49
    Author     : dangret
--%>

<%@page import="java.util.Date"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="ittepic.edu.mx.entidades.Detalleventa"%>
<%@page import="ittepic.edu.mx.entidades.Producto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBCarritoClienteLocal"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="ittepic.edu.mx.entidades.Venta"%>
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
    Usuario user = sesionUser;
    boolean userValido = false;
    if (user != null)
        if (user.getEstado())
            if (user.getTipousuario().getIdtipousuario() == 2)
                userValido = true;
    
    if (!userValido) response.sendRedirect("index.jsp");
    else{
    
    List<Detalleventa> detallesventas = new ArrayList();
    List<Venta> ventasTotales = new ArrayList();
    List<Producto> medicamentos = new ArrayList();
    List<Date> fechaVentaUsuario = new ArrayList();
    List<Double> montoTotalVenta = new ArrayList();
    List<Integer> ventasIDs = new ArrayList(); 
    ventasTotales = carritoCliente.getVentas();
    detallesventas = carritoCliente.getDetalleventa();
    medicamentos = carritoCliente.getMedicamentos();
    int cantidadventa = 0;
    double montoparcial = 0, montototal = 0;
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    DecimalFormat df = new DecimalFormat("#.##");
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function verDetalleVentaUsuario(idventa)
            {
                location.href = "reporteDetalleVenta.jsp?idventa="+idventa;
            }
        </script>
    </head>
    <body>
        <center>
        <%if(ventasTotales.size()>0){%>
                    <h3>HISTORIAL</h3>
                    <table align="center" border="3">
                        <tr>
                            <th style="background-color: darkred; color: white"><center><b>&nbsp;&nbsp;Fecha Venta&nbsp;&nbsp;</b></center></th>
                            <th style="background-color: darkred; color: white"><center><b>&nbsp;&nbsp;Costo&nbsp;&nbsp;</b></center></th>
                            <th style="background-color: darkred; color: white"><center><b>&nbsp;&nbsp;Ver Detalle de Venta&nbsp;&nbsp;</b></center></th>
                        </tr>
                        <%for (int i=0; i<ventasTotales.size(); i++) {
                            if(ventasTotales.get(i).getIdusuario().equals(sesionUser)){
                                        for(int j=0;j<detallesventas.size();j++){
                                            int var1 = ventasTotales.get(i).getIdventa();
                                            int var2 = detallesventas.get(j).getIdventa().getIdventa();
                                            if(var1==var2)
                                            {
                                             for(int k=0;k<medicamentos.size();k++){
                                              int var3 = detallesventas.get(j).getIdproducto().getIdproducto();
                                              int var4 = medicamentos.get(k).getIdproducto();
                                              if(var3==var4)
                                              {
                                               montoparcial = detallesventas.get(j).getCantidad()*medicamentos.get(k).getPrecio();
                                               montototal += montoparcial;
                                               montoparcial = 0;
                                              }
                                             }
                                            }
                                        }
                                        fechaVentaUsuario.add(ventasTotales.get(i).getFechadetalleventa());
                                        montoTotalVenta.add(montototal);
                                        ventasIDs.add(ventasTotales.get(i).getIdventa());
                                        montototal = 0;
                            }%>
                         <%}%>
                         <%for(int j=0;j<fechaVentaUsuario.size();j++){%>
                         <tr>
                             <td><center><i><%out.println(sdf.format(fechaVentaUsuario.get(j)));%></i></center></td>
                             <td><center>$<%out.print(df.format(montoTotalVenta.get(j)));%></center></td>
                             <td><center><input type="image" src="images/detalles.png" name="btnDetalles" onclick="verDetalleVentaUsuario(<%=ventasIDs.get(j)%>)"></center></td>
                         </tr>
                        
                      <%}%>
                    </table>
                        <br>
                        <br>
                        <br>
           
                        
        <%} else {%>
            <h1><center>Sin Historial</center></h1>
            <%}} %>
           
    </center>
    </body>
</html>
