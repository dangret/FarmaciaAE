<%-- 
    Document   : wpPedidos
    Created on : 26-may-2013, 16:08:07
    Author     : dangret
--%>

<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="ittepic.edu.mx.ejbs.EJBProductosRemote"%>
<%@page import="ittepic.edu.mx.ejbs.EJBPedidoRemote"%>
<%@page import="ittepic.edu.mx.entidades.Producto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ittepic.edu.mx.entidades.Pedido"%>
<%@page import="java.util.List"%>
<%@page import="ittepic.edu.mx.ejbs.EJBPedido"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    EJBPedidoRemote ejbPedido = null;
    EJBProductosRemote ejbProducto = null; 
    public void jspInit() {
        try {
            InitialContext ic1 = new InitialContext();
            ejbPedido = (EJBPedidoRemote) ic1.lookup(EJBPedidoRemote.class.getName());
            
            InitialContext ic2 = new InitialContext();
            ejbProducto = (EJBProductosRemote) ic2.lookup(EJBProductosRemote.class.getName());
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
            if (user.getTipousuario().getIdtipousuario() == 1)
                userValido = true;
    
    if (!userValido) response.sendRedirect("index.jsp");
    else{
   
    String [] itemsBorrar = 
            request.getParameterValues("chkBorrar") == null ? null : 
            request.getParameterValues("chkBorrar");
    
    if (itemsBorrar != null){
        Pedido pedido;
        Producto producto;
        for (int i=0; i<itemsBorrar.length; i++){
            pedido = ejbPedido.obtenerPorID(Integer.parseInt(itemsBorrar[0]));
            
            pedido.setEstado(0);
            producto = pedido.getIdproducto();
            //producto.setCantidad((short) pedido.getCantidad());
            ejbProducto.ProductoGuardar(producto);
            ejbPedido.guardarPedido(pedido);
        }
    }
    List<Pedido> pedidos = ejbPedido.obtenerPedidos();
    
%>
<html>
    <head>
        <script>
            function lala(){
                window.location = "index.jsp";
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="wpPedidos.jsp" method="POST">
            <div align="center">
            <table>
                <tr>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Fecha de pedido:</th>
                    <th>Registrar pedido:</th>
                </tr>
                <% if (pedidos.size() > 0) {for (int i=0; i<pedidos.size(); i++){%>
                <tr>
                    <td><%=pedidos.get(i).getIdproducto().getProducto()%></td>
                    <td><%=pedidos.get(i).getCantidad()%></td>
                    <%
                        SimpleDateFormat formato = new SimpleDateFormat ("dd/MM/yyy");
                        String fecha = formato.format(pedidos.get(i).getFechapedido());
                    %>
                    <td><%=fecha%></td>
                    <td><input type="checkbox" value="<%=pedidos.get(i).getIdpedido()%>" name="chkBorrar"></td>
                </tr>
                <%}
                }}%>
            </table>
            <table>
                <tr>
                    <td><input type="submit" value="Saldar Pedidos"></td>
                    
                </tr>
            </table>
            </div>
        </form>
    </body>
</html>
