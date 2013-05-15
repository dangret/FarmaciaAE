<%-- 
    Document   : wpAltaModificacionProducto
    Created on : 14-may-2013, 4:29:46
    Author     : Daniel
--%>

<%@page import="java.util.List"%>
<%@page import="ittepic.edu.mx.entidades.Producto"%>
<%@page import="ittepic.edu.mx.ejbs.EJBProductosRemote"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    EJBProductosRemote ejb = this.ejb;
    int i=0;
    public void jspInit() {
        try{
            InitialContext ic = new InitialContext ();
            ejb = (EJBProductosRemote) 
                    ic.lookup (EJBProductosRemote.class.getName());
            System.out.println("Bean cargado");
        }
        catch (Exception ex){
            System.out.println("Error:"+ ex.getMessage());
        }
   }
%>

<%
    List<Producto> productos = ejb.productoObtenerTodos();
%>
<html>
    <head>
        <script>
            function modificar (id){
                
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table>
            <tr>
                <th>Imagen</th>
                <th>Nombre</th>
                <th>Cantidad</th>
                <th>Precio</th>
                <th>Modificar</th>
                <th>Eliminar</th>
            </tr>
            <tr>
                <%for (int i = 0; i<productos.size(); i++ ){%>
                
                <td><%=productos.get(i).getRuta()%>
                <input type="hidden" name="hdId" value="<%=productos.get(i).getIdproducto()%>" ></td>
                <td><%=productos.get(i).getProducto()%></td>
                <td><%=productos.get(i).getCantidad() %></td>
                <td><%=productos.get(i).getPrecio() %></td>
                <td><input type="button" value="Borrar" name="btnBorrar"></td>
                <td><input type="button" value="Modificar" onclick="modificar(hdID)" name="btnModificar"></td>
                <%}%>
            </tr>
            
            
        </table>
    </body>
</html>
