<%-- 
    Document   : wpAltaModificacionProducto
    Created on : 14-may-2013, 4:29:46
    Author     : Daniel
--%>

<%@page import="org.apache.taglibs.standard.tag.common.core.RedirectSupport"%>
<%@page import="javax.ws.rs.core.Response"%>
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
<%!
    public void borrar(int id){
        Producto producto = new Producto();
        producto.setIdproducto(id);
        ejb.productoBaja(producto);
    }
%>
<%
    try{
        request.removeAttribute("productoObject");
    }catch(Exception e){
        out.println("no existe el objeto");
    }
    
    List<Producto> productos = ejb.productoObtenerTodos();
    
    session.setAttribute("ejb", ejb);
%>
<html>
    <head>
        <script>
            function jBorrar(id){
                formulario = document.getElementsByName("formulario");
                document.formulario.submit();
            }
            
            function jNuevo(){
                window.location = "wpProductoAlta.jsp";
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form name="formulario" action="ServletProducto" method="POST" >
            <div align="center">
            <table>
                <tr>
                    <th>Imagen</th>
                    <th>Nombre</th>
                    <th>Cantidad</th>
                    <th>Precio</th>
                    <th>Eliminar</th>
                </tr>
                
                    <%for (int i = 0; i<productos.size(); i++ ){%>
                        <tr>
                            <td><input type="image" src="<%=productos.get(i).getRuta() %>" style="width:75px;" ></td>
                            <td><a href="wpProductoAlta.jsp?id=<%=productos.get(i).getIdproducto()%>"><%=productos.get(i).getProducto() %></a></td>
                            <td><%=productos.get(i).getCantidad() %></td>
                            <td><%=productos.get(i).getPrecio() %></td>
                            <td><input type="checkbox" value="<%=productos.get(i).getIdproducto()%>" name="chkBorrar"></td>
                        </tr>
                    <%}%>
                
            </table>
            <table>
                <tr>
                    <td><input type="button" onclick="jNuevo()" name="btnNuevo" value="Crear Nuevo Producto"></td>
                    <td><input type="button" onclick="jBorrar()" name="btnBorrar" value="Borrar Seleccionados"></td>
                </tr>
            </table>
            </div>
        </form>
    </body>
</html>
