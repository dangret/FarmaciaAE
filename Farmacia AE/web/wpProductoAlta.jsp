<%-- 
    Document   : wpProductoAlta
    Created on : 14-may-2013, 5:05:13
    Author     : Daniel
--%>

<%@page import="ittepic.edu.mx.ejbs.EJBProductosRemote"%>
<%@page import="ittepic.edu.mx.entidades.Producto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        
<!DOCTYPE html>
<%!
   boolean llenar; 
   Producto producto;
%>
<%
    EJBProductosRemote ejb = (EJBProductosRemote) session.getAttribute("ejb");
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        session.setAttribute("idproducto", id);
        producto = ejb.productoObtenerPorID(id);
    }catch(Exception e){
        llenar = false;
        out.println("<h3>Nuevo Producto</h3>");
    }
    if (producto != null) llenar = true;
%>
<html>
    <head>
        <script src="js/jquery-2.0.1.js" type="text/javascript"></script>
        <script src="js/jquery.maskedinput.js" type="text/javascript"></script>
        <script src="js/jquery.maskMoney.js" type="text/javascript"></script>
        <script>
            
            jQuery(function($){
                $("#txtproducto").mask("aaa?*************",{placeholder:" "});
                $("#txtcantidad").mask("9?9999",{placeholder:" "});
                $("#txtprecio").maskMoney({showSymbol:false,decimal:'.',precision:2});
            });
            
            function jsReset(){
                document.getElementById("txtproducto").value = "";
                document.getElementById("txtcantidad").value = "";
                document.getElementById("txtprecio").value = "";
                document.getElementById("bitimagen").value = null;
            }
            
            function validar(){
                if (document.getElementById("txtproducto").value != ""){
                    if (document.getElementById("txtcantidad").value != ""){
                        if (document.getElementById("txtprecio").value != ""){
                            if (document.getElementById("bitimagen").value != null){
                                return 1;
                            }else return -1;
                        }else return -1;
                    }else return -1
                }else return -1;
                
            }
            
            function jsCancel(){
                window.location = "wpProductoConsulta.jsp";
            }
            
            function jsSubmit(){
                if (validar() == 1){
                    document.formularito.submit();
                }else{
                    alert ("Hay campos vacios, por favor compruebe");
                } 
                    
            }
            
            function jsImagen(){
                alert("entro");
                var file = document.getElementById("bitimagen").value;
                
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="ServletProducto" name="formularito" method="POST" enctype="multipart/form-data">
            <table>
                <tr>
                    <td><b>Nombre del Producto:</b></td>
                    <%if (llenar){%>
                    <td> <input type="text" id="txtproducto" name="txtProducto" value="<%out.print(producto.getProducto());%>"></td>
                    <%}else{%>  
                        <td> <input type="text" id="txtproducto" name="txtProducto"></td><%}%>
                </tr>
                <tr>
                    <td><b>Cantidad:</b></td>
                    <%if (llenar){%>
                    <td><input type="text" id="txtcantidad"  name="txtCantidad" value="<%out.print(producto.getCantidad());%>"></td>
                    <%}else{%>
                    <td><input type="text" id="txtcantidad" name="txtCantidad"></td><%}%>
                </tr>
                <tr>
                    <td><b>Precio:</b></td>
                    <%if (llenar){%>
                    <td><input type="text" id="txtprecio" name="txtPrecio" value="<%out.print(producto.getPrecio());%>"></td>
                    <%}else{%>
                    <td><input type="text" id="txtprecio" name="txtPrecio"></td><%}%>
                </tr>
                <tr>
                    <td><b>Imagen:</b></td>
                    <td><input type="file" id="bitimagen" name="byteImagen" onchange="jsImagen()"></td>
                </tr>
            </table>
            <table>
                <tr>
                    <td><input type="button" name="btnAceptar" value="Registrar" onclick="jsSubmit()"></td>
                    <td><input type="button" name="btnReset" value="Resetear Campos" onclick="jsReset()"></td>
                    <td><input type="button" name="btnCancelar" value="Cancelar" onclick="jsCancel()"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
