<%-- 
    Document   : underConstruction
    Created on : 30-may-2013, 23:16:49
    Author     : dangret
--%>

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
    List<Detalleventa> detallesventas = new ArrayList();
    List<Venta> ventasTotales = new ArrayList();
    List<Producto> medicamentos = new ArrayList();
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
    </head>
    <body>
        <center>
        <%if(ventasTotales.size()>0){%>
                    <h3>HISTORIAL</h3>
                    <table align="center" border="5">
;                        <tr>
                            <th><center><b>Fecha Venta</b></center></th>
                            <th><center><b>Costo</b></center></th>
                        </tr>
                        <%for (int i=0; i<ventasTotales.size(); i++) {%>
                            <tr>
                                <%if(ventasTotales.get(i).getIdusuario().getIdusuario()==1){%>
                                <td><center><i><%out.println(sdf.format(ventasTotales.get(i).getFechadetalleventa()));%></i></center></td>
                                <td><center>
                                    <%
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
                                        }%>
                                        $<%out.print(df.format(montototal));%>
                                        <%montototal = 0;%>
                                <%}%>
                                </center></td>
                         <%}%>
                            </tr>
                        </table>
                        <br>
                        <br>
                        <br>
                        
                        
                        
        <%} else {%>
            <h1><center>Sin Historial</center></h1>
            <%} %>
           
    </center>
    </body>
</html>
