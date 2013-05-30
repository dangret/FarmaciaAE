<%-- 
    Document   : carritoCliente
    Created on : 15/05/2013, 11:49:43 PM
    Author     : JESUS
--%>

<%@page import="ittepic.edu.mx.entidades.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="javax.naming.InitialContext"%>
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
    
    if(idproducto>0){
        int cant=Integer.parseInt(request.getParameter("cantidad"));
        carritoCliente.agregar(idproducto, cant);
       
    }
       else if(remover>0){
           int index=Integer.parseInt(request.getParameter("index"));
           carritoCliente.removerMedicamento(index);
           
       }else if(terminar==1){
         carritoCliente.terminarPedido();
         jspInit();
         response.sendRedirect("carritoCliente.jsp");
       }
    cantidades=carritoCliente.getCantidades();
    pedido = carritoCliente.getPedido();
    medicamentos=carritoCliente.getMedicamentos();
    session.setAttribute("carritoCliente", carritoCliente);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Catalogo de Medicinas</title>
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/lightbox.js"></script>
        <link href="lightbox.css" rel="stylesheet" />
        
        <script>
            function agregarMedicina(idproducto, disponibles, index) {
                var cantidad = prompt("Introduzca la cantidad de productos",0);
                if(cantidad==null)
                {
                    location.href = "carritoCliente.jsp";
                }
                else
                {
                    anterior = eval("document.getElementById('txtAnterior"+index+"').value");
                    location.href = "carritoCliente.jsp?idproducto="+idproducto+"&cantidad="+cantidad;
                    top.frames['iframe2'].location.href = 'iframeRecuentoVenta.jsp';
                    
                }
            }
            function removerMedicina (idproducto, index){
                if(confirm("¿Seguro que deseas eliminar esta medicina de tu lista de pedido?")){
                   location.href="carritoCliente.jsp?remover="+idproducto+"&index="+index;
                   top.frames['iframe2'].location.href = 'iframeRecuentoVenta.jsp';     
                }
            }
        function terminarPedido(){
            if(confirm("¿Seguro que quieres dar por finalizado tu pedido?")){
                location.href="carritoCliente.jsp?terminar=1";
            }
        }
        </script>    
    </head>
    <body background="imgs/fondo.jpg">
    <center>
        <%if(carritoCliente.getMedicamentos().size()>0) {%>
            <h2>Lista de Medicinas Disponibles</h2>
            <table align="center">
                <%
                    int filasRenglones;
                    int filaColumnas=10;
                    int filaF=10;
                    filasRenglones=(Math.round(medicamentos.size()/10));
                   if(medicamentos.size()>(filasRenglones*10)){
                      filaF=medicamentos.size()-(filasRenglones*10);
                      filasRenglones++;                          
                   }else{
                        filaF=medicamentos.size();
                        }
                    int pos=0;
                    int pos1=0;
                    for (int i = 0; i<filasRenglones; i++ ){
                    %>
                    
                    <tr align="center" valign="middle">    
                        <%
                        if(i==(filasRenglones-1)){
                        filaColumnas=filaF;
                        }
                        pos1=pos;
                        for (int j=0; j<filaColumnas;j++){%>
                        <td><a href="<%=medicamentos.get(pos).getRuta() %>" rel="lightbox" ><img  src="<%=medicamentos.get(pos).getRuta() %>"  width="75" height="75"></a></td>
                            <% pos++;
                        }pos=pos1; %>
                    </tr>
                    
                    <tr align="center" valign="middle" > 
                            
                            <%
                            pos1=pos;
                            for (int j=0; j<filaColumnas;j++){%>
                            <td><%=medicamentos.get(pos).getProducto() %></td>
                            <% pos++;}
                            pos=pos1;%>
                    </tr>
                    
                    <tr align="center" valign="middle">   
                            <%
                            pos1=pos;
                            for (int j=0; j<filaColumnas;j++){%>                         
                            <td>$<%=medicamentos.get(pos).getPrecio() %></td>
                            <% pos++;}
                            pos=pos1;%>
                     </tr>
                    
                     <tr align="center" valign="middle">
                            <%
                            pos1=pos;
                            for(int j=0; j<filaColumnas;j++){%>
                            <td>
                                <input type="image" src="imgs/add.jpg" name="btnAgregar" onclick="agregarMedicina(<%=medicamentos.get(pos).getIdproducto()%>,
                                       <%=medicamentos.get(pos).getCantidad()%>,<%=pos%>)">
                            <%
                               
                                int index=pedido.indexOf(medicamentos.get(pos));
                                if(index==-1){
                            %>        
                            <input type="hidden" disabled="true"  name="txtAnterior<%=pos%>" id="txtAnterior<%=pos%>" value="0">
                                <%}else{%>
                                <input type="hidden" disabled="true"  name="txtAnterior<%=pos%>" id="txtAnterior<%=pos%>" value="<%=cantidades.get(index)%>">
                                
                                <%}%>
                            
                            </td>
                            <%pos++;%>
                            <%}%>
                     </tr>
                <% }%>
            </table>
            
            <br>
            <br>
            <br>
        
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
                                <td><center><input type="image" src="imgs/delete.jpg" onclick="removerMedicina(<%=pedido.get(i).getIdproducto()%>,<%=i%>);"/>
                                  </center></td>
                             <%--   <td>
                                    <input type="image" src="imgs/delete.jpg" onclick="removerProducto(<%=pedido.get(i).getIdproducto()%>,<%=i%>);"/>
                                    
                                </td>
                                --%>
                            </tr>
                        <%}%>
                        </table>
                        <br>
                        <br>
                        <br>
                        <table border="0">
                            <tr>
                                <td><img src="imgs/terminarpedido.png" width="100" height="100"></td>
                            </tr>
                            <tr>
                                <td><center><input type="button" value="Terminar Pedido" onclick="terminarPedido(); "></center></td>
                            </tr>
                        </table>
            <%}%>
        <%} else {%>
            <h1><center>No Hay Productos Disponibles</center></h1>
            <%} %>
    </center>
    </body>
</html>
