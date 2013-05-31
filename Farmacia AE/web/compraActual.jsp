<%-- 
    Document   : compraActual
    Created on : 31/05/2013, 12:45:04 AM
    Author     : JESUS
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.entidades.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="ittepic.edu.mx.ejbs.EJBCarritoClienteLocal"%>
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
    if (session.getAttribute("carritoCliente") != null) carritoCliente = (EJBCarritoClienteLocal) (session.getAttribute("carritoCliente"))  ;
    int idproducto=request.getParameter("idproducto")==null?0:Integer.parseInt(request.getParameter("idproducto"));
    int remover= request.getParameter("remover")==null?0:Integer.parseInt(request.getParameter("remover"));
    int terminar=request.getParameter("terminar")==null?0:Integer.parseInt(request.getParameter("terminar"));
    
    List cantidades =new ArrayList();
    List <Producto> pedido= new ArrayList();    
    List<Producto> medicamentos =new ArrayList();
    if(remover>0)
    {
     int index=Integer.parseInt(request.getParameter("index"));
     carritoCliente.removerMedicamento(index);
    }else{ 
        if(terminar==1){
            carritoCliente.terminarPedido();
            jspInit();
            session.setAttribute("carritoCliente", carritoCliente);
            response.sendRedirect("carritoCliente.jsp");
            
            
         }
    }
    cantidades=carritoCliente.getCantidades();
    pedido = carritoCliente.getPedido();
    medicamentos=carritoCliente.getMedicamentos();

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function removerMedicina (idproducto, index){
                if(confirm("¿Seguro que deseas eliminar esta medicina de tu lista de pedido?")){
                   location.href="compraActual.jsp?remover="+idproducto+"&index="+index;
                   top.frames['iframe2'].location.href = 'iframeRecuentoVenta.jsp';     
                }
            }
            function terminarPedido(){
                if(confirm("¿Seguro que quieres dar por finalizado tu pedido?")){
                    location.href="compraActual.jsp?terminar=1";
                }
            }
        </script>
    </head>
    <body>
    <center>
        <%if(pedido.size()>0){%>
                    <h3>Su pedido</h3>
                    <table align="center" border="5">
                        <tr>
                            <th><center><b>Nombre Medicamento</b></center></th>
                            <th><center><b>Precio</b></center></th>
                            <th><center><b>Cantidad</b></center></th>
                            <th><center><b>Eliminar</b></center></th>
                        </tr>
                        <%for (int i=0; i<pedido.size(); i++) {%>
                            <tr>
                                <td><center><i><%=pedido.get(i).getProducto()%></i></center></td>
                                <td><center><i><%=pedido.get(i).getPrecio()%></i></center></td>
                                <td><center><i>
                                        <%
                                          int index=0;
                                          for (int j=0; j<pedido.size(); j++){
                                               if (pedido.get(j).getProducto().equals(medicamentos.get(i))) 
                                                   index = j;
                                          }
                                        %>
                                        <%=cantidades.get(i)%>
                                </i></center></td>
                                <td><center><input type="image" src="images/delete.jpg" onclick="removerMedicina(<%=pedido.get(i).getIdproducto()%>,<%=i%>);"/>
                                  </center></td>
                            </tr>
                        <%}%>
                        </table>
                        <br>
                        <br>
                        <br>
                        
                        <table border="0">
                            <tr>
                                <td><center><img src="images/terminarpedido.png" width="100" height="100"></center></td>
                            </tr>
                            <tr>
                                <td><center><input type="button" value="Terminar Pedido" onclick="terminarPedido(); "></center></td>
                            </tr>
                            </table>
                        
        <%} else {%>
            <h1><center>No Hay Productos Disponibles</center></h1>
            <%} %>
           
    </center>
    </body>
</html>
