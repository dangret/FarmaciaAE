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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Farmacias San Cazola</title>
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/lightbox.js"></script>
        <link href="lightbox.css" rel="stylesheet" />


    </head>
    <body>
        <form name="formulario" action="" method="POST" >
            <center>
            <table align="center">           
                

                    <%
                    int filasRenglones;
                    int filaColumnas=6;
                    int filaF=6;
                    filasRenglones=(Math.round(productos.size()/10));
                   if(productos.size()>(filasRenglones*10)){
                      filaF=productos.size()-(filasRenglones*10);
                      filasRenglones++;                          
                   }else{
                        filaF=productos.size();
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
                        <td><a href="<%=productos.get(pos).getRuta() %>" rel="lightbox" ><img  src="<%=productos.get(pos).getRuta() %>"  width="75" height="75"></a></td>
                            <% pos++;
                        }pos=pos1; %>
                        
                     </tr>
                     <tr align="center" valign="middle" > 
                            
                            <%
                            pos1=pos;
                            for (int j=0; j<filaColumnas;j++){%>
                            <td><%=productos.get(pos).getProducto() %></td>
                            <% pos++;}
                            pos=pos1;%>
                     </tr>
                        
                     <tr align="center" valign="middle">       
                             <%
                             pos1=pos;
                             for (int j=0; j<filaColumnas;j++){%>
                            <td><%=productos.get(pos).getCantidad() %></td>
                            <% pos++; }
                              pos=pos1; %>
                            
                     </tr>
                     <tr align="center" valign="middle">   
                            <%
                            pos1=pos;
                            for (int j=0; j<filaColumnas;j++){%>                         
                            <td><%=productos.get(pos).getPrecio() %></td>
                            <% pos++; 
                            }
                            %>
                        </tr>
                     <%}%>
                
                    </table>
            </center>
        </form>
    </body>
</html>
