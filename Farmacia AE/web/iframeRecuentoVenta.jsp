<%-- 
    Document   : prueba
    Created on : 26/05/2013, 01:10:48 PM
    Author     : JESUS
--%>

<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ittepic.edu.mx.entidades.Producto"%>
<%@page import="java.util.List"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBCarritoClienteLocal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Usuario user = (Usuario) session.getAttribute("usuario") == null ? null : (Usuario) session.getAttribute("usuario");
    boolean userValido = false;
    if (user != null)
        if (user.getEstado())
            if (user.getTipousuario().getIdtipousuario() == 2)
                userValido = true;
    
    if (!userValido) response.sendRedirect("index.jsp");
    else{ 
    EJBCarritoClienteLocal  carritoCliente = (EJBCarritoClienteLocal)session.getAttribute("carritoCliente");
     List cantidades = new ArrayList();
     List <Producto> pedido= new ArrayList();
     List<Producto> medicamentos =new ArrayList();
     pedido = carritoCliente.getPedido();
     cantidades = carritoCliente.getCantidades();
     medicamentos= carritoCliente.getMedicamentos();
     int totalProductos = new Integer(0);
     double totalCosto = 0;
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
     
        <table>
            <tr>
                <%if(pedido.size()>0 && cantidades.size()>0){%>
                <td><h5>Cantidad:
                        <%
                          totalCosto = 0;
                          totalProductos = 0;
                          for(int i=0;i<pedido.size();i++)
                          {
                           totalCosto += pedido.get(i).getPrecio() * (Integer)(cantidades.get(i));
                           totalProductos += (Integer)(cantidades.get(i));
                          }
                        %>
                        <%=totalProductos%>
                        
                </h5></td>
                <td><h5>Total: $<%=totalCosto%></h5></td>
               <%}}%>
            </tr>
        </table>

    </body>
</html>
