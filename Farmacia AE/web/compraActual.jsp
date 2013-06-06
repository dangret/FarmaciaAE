<%-- 
    Document   : compraActual
    Created on : 31/05/2013, 12:45:04 AM
    Author     : JESUS
--%>

<%@page import="ittepic.edu.mx.ejbs.EJBPersonasRemote"%>
<%@page import="ittepic.edu.mx.entidades.Pedido"%>
<%@page import="ittepic.edu.mx.entidades.Detalleventa"%>
<%@page import="java.util.Date"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
<%@page import="ittepic.edu.mx.entidades.Venta"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.entidades.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="ittepic.edu.mx.ejbs.EJBCarritoClienteLocal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    EJBCarritoClienteLocal carritoCliente = null;
    EJBPersonasRemote ejb = null;
    EJBUsuariosRemote ejb2 = null;
    
    public void jspInit() {
        try {
            InitialContext ic = new InitialContext();
            carritoCliente = (EJBCarritoClienteLocal) ic.lookup(EJBCarritoClienteLocal.class.getName());
            
            InitialContext ic1 = new InitialContext();
            ejb = (EJBPersonasRemote) ic.lookup(EJBPersonasRemote.class.getName());
            
            InitialContext ic2 = new InitialContext();
            ejb2 = (EJBUsuariosRemote) ic.lookup(EJBUsuariosRemote.class.getName());
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
                userValido = true;
    
    if (!userValido) response.sendRedirect("index.jsp");
    else{
    if (session.getAttribute("carritoCliente") != null) carritoCliente = (EJBCarritoClienteLocal) (session.getAttribute("carritoCliente"))  ;
    int idproducto=request.getParameter("idproducto")==null?0:Integer.parseInt(request.getParameter("idproducto"));
    int remover= request.getParameter("remover")==null?0:Integer.parseInt(request.getParameter("remover"));
    int terminar=request.getParameter("terminar")==null?0:Integer.parseInt(request.getParameter("terminar"));
    
    List cantidades =new ArrayList();
    List <Producto> pedido= new ArrayList();    
    List<Producto> medicamentos =new ArrayList();
    List<Usuario> usuarios = new ArrayList();
    List<Venta> ventas = new ArrayList();
    
    cantidades=carritoCliente.getCantidades();
    pedido = carritoCliente.getPedido();
    medicamentos=carritoCliente.getMedicamentos();
    usuarios = carritoCliente.getUsuarios();
    ventas = carritoCliente.getVentas();
    
    
    if(idproducto>0){
        int cant=Integer.parseInt(request.getParameter("cantidad"));
        carritoCliente.agregar(idproducto, cant);
       
    }
       else if(remover>0){
           int index=Integer.parseInt(request.getParameter("index"));
           carritoCliente.removerMedicamento(index);
           
       }else if(terminar==1){
         Venta v = new Venta();
         v.setIdusuario(sesionUser);
         v.setHora(new Date());
         v.setFechadetalleventa(new Date());
         v = carritoCliente.registrarVenta(v);//Se registra una nueva venta
         
         for(int i=0; i<pedido.size(); i++)
         {
          int index = pedido.get(i).getIdproducto();
          for(int j=0;j<medicamentos.size();j++)
          {
              if(index==medicamentos.get(j).getIdproducto())
              {
               System.out.println(index);
               System.out.println(medicamentos.get(j).getIdproducto());
               System.out.println(medicamentos.get(j).getProducto());
               Producto p = medicamentos.get(j);
               Detalleventa dv = new Detalleventa();
               dv.setIdproducto(p);
               dv.setIdventa(v);
               dv.setCantidad(Short.parseShort(cantidades.get(i).toString()));
               dv = carritoCliente.registrarDetalleVenta(dv);//Se registra el detalle de la venta con la lista de los productos
               if(p.getCantidad()<Short.parseShort(cantidades.get(i).toString()))
               {
                p.setCantidad(Short.parseShort("0"));
                Pedido pe = new Pedido();
                pe.setIdproducto(p);
                pe.setIdventa(v);
                pe.setCantidad(Integer.parseInt(String.valueOf(cantidades.get(i).toString()))-Integer.parseInt(String.valueOf(pedido.get(i).getCantidad())));
                //Se hace la diferencia de cuanto producto falta y se anexa a la tabla pedido con la funcion dee arriba
                pe.setEstado(1);//estado del pedido
                pe.setFechapedido(new Date());
                carritoCliente.registrarPedido(pe);//Se registra el pedido
               }
               else
               {
                p.setCantidad((Short.valueOf(String.valueOf(p.getCantidad()-Short.parseShort(cantidades.get(i).toString())))));//En caso contrario que no rebase el pedido la cantidad del stock disponible
               
               }
               carritoCliente.actualizarStock(p); //Actualiza la cantidad en productos despues de la venta realizada
               j=medicamentos.size();
              } 
          } 
         }
         terminar = 0;
         jspInit();
         response.sendRedirect("carritoCliente.jsp");
       }
    cantidades=carritoCliente.getCantidades();
    pedido = carritoCliente.getPedido();
    medicamentos=carritoCliente.getMedicamentos();
    usuarios = carritoCliente.getUsuarios();
    ventas = carritoCliente.getVentas();
    session.setAttribute("carritoCliente", carritoCliente);
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
            <%} }%>
           
    </center>
    </body>
</html>
