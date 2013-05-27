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
    carritoCliente = (EJBCarritoClienteLocal)session.getAttribute("carritoCliente");
    List cantidades =new ArrayList();
    List <Producto> pedido= new ArrayList();
    pedido = carritoCliente.getPedido();
    cantidades = carritoCliente.getCantidades();
    int totalProductos = new Integer(0);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function miFuncion()
            {
             windows.location = ("prueba.jsp");
            }
        </script>
    </head>
    <body>
        <table>
            <tr>
                <td><h5>Cantidad: 
                        <%
                          for(int i=0;i<pedido.size();i++)
                          {
                            totalProductos += Integer.parseInt(cantidades.get(i).toString());
                          }
                          System.out.println(totalProductos);
                          
                          
                        %>
                        <%=totalProductos%>
                        
                </h5></td>
                <td><h5>Total: $</h5></td>
            </tr>
        </table>
    </body>
</html>
