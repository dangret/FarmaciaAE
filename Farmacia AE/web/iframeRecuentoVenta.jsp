<%-- 
    Document   : prueba
    Created on : 26/05/2013, 01:10:48 PM
    Author     : JESUS
--%>

<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ittepic.edu.mx.entidades.Producto"%>
<%@page import="java.util.List"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBCarritoClienteLocal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    public EJBCarritoClienteLocal carritoCliente = null;
%>

<%
    String quitar = request.getParameter("quitar")==null?"0":request.getParameter("quitar");
    carritoCliente = (EJBCarritoClienteLocal)session.getAttribute("carritoCliente");
    List cantidades =new ArrayList();
    List <Producto> pedido= new ArrayList();
    List<Producto> medicamentos =new ArrayList();
    pedido = carritoCliente.getPedido();
    cantidades = carritoCliente.getCantidades();
    medicamentos= carritoCliente.getMedicamentos();
    int totalProductos = new Integer(0);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%if(carritoCliente.getMedicamentos().size()>0){%>
        <table>
            <tr>
                <%if(carritoCliente.getPedido().size()>0){%>
                <td><h5>Cantidad: 
                        <%
                          for(int i=0;i<pedido.size();i++)
                          {
                           int index=0;
                           for(int j=0;j<pedido.size();j++)
                           {
                            if(pedido.get(j).getProducto().equals(medicamentos.get(i)))
                            {
                             index = j;
                            }
                           }
                           if(Integer.parseInt(quitar)==1)
                           {
                            totalProductos = totalProductos-Integer.parseInt(cantidades.get(i).toString());
                           }
                           else
                           {
                            totalProductos += Integer.parseInt(cantidades.get(i).toString());
                           }
                          }
                          
                        %>
                        <%=totalProductos%>
                        
                </h5></td>
                <td><h5>Total: $</h5></td>
                <%}else{%>
            <h3><center>  </center></h3>
            <%}%>
            </tr>
        </table>
        <%} else {%>
            <h3><center>    </center></h3>
            <%} %>
    </body>
</html>
