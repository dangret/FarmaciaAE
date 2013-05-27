<%-- 
    Document   : consultaPersonas
    Created on : 14/05/2013, 03:51:03 AM
    Author     : JESUS
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="ittepic.edu.mx.entidades.Persona"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBPersonasLocal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%! 
    EJBPersonasLocal ejb=null;
    public void jspInit(){
        try{
            InitialContext ic= new InitialContext();
            ejb =(EJBPersonasLocal) ic.lookup(EJBPersonasLocal.class.getName());
            System.out.println("Bean cargado");
        }catch (Exception ex) {
            System.out.println("Error:"+ ex.getMessage());
        }
        
    }
%>

<%
  jspInit();
  List<Persona> personas = null;
  SimpleDateFormat sdffechaguardar = new SimpleDateFormat("yyyy-MM-dd");
  SimpleDateFormat sdffechamostrar = new SimpleDateFormat("dd-MM-yyyy");
  String nombre = request.getParameter("nombre");
  String[] borrar = request.getParameterValues("cbBorrar");
  if (borrar!=null)
  {
   for(int i=0; i<borrar.length; i++)
   {
    System.out.println("Borrar["+i+"]="+borrar[i]);
    ejb.eliminar(Integer.parseInt(borrar[i]));
   }
  }
  if(nombre!=null)
  {
   String rfc = request.getParameter("rfc");
   String appat = request.getParameter("appat");
   String apmat = request.getParameter("apmat");
   String fechnac = request.getParameter("fechnac");
   String telefono = request.getParameter("telefono");
   String direccion = request.getParameter("direccion");
   String celular = request.getParameter("celular");
   String email = request.getParameter("email");
   //Funcionamiento del merge
   int idcliente = Integer.parseInt(request.getParameter("idcliente"));
   Persona p = new Persona();
   p.setNombre(nombre);
   p.setRfc(rfc);
   p.setAppat(appat);
   p.setApmat(apmat);
   p.setFechnac(sdffechaguardar.parse(fechnac));
   p.setTelefono(telefono);
   p.setDireccion(direccion);
   p.setCelular(celular);
   p.setEmail(email);
   if(idcliente!=0)
    p.setIdcliente(idcliente);
   ejb.alta_modificacion(p);
  }
  //session.setAttribute("ejb", ejb);
  personas = ejb.consultaPersonas();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FARMACIA SAN CAZOLA - PERSONAS</title>
    <script>
            function validar()
            {
             var conf = confirm("¿Seguro?");
             if(conf)
             {
                 formulario = document.getElementsByName("formulario");
                 document.formulario.submit();
             }
            }
        </script>
    </head>
    <body>
        <h1>Catalogo de Personas</h1>
    <form action="" method="POST" name="formulario">
       <table border="1">
               <tr>
                   <th>Nombre</th>
                   <th>RFC</th>
                   <th>Apellido Paterno</th>
                   <th>Apellido Materno</th>
                   <th>Fecha de Nacimiento</th>
                   <th>Telefono</th>
                   <th>Direccion</th>
                   <th>Celular</th>
                   <th>E-mail</th>
                   <th>Eliminar</th>
               </tr>
               <tr>
               <% for(int i=0; i<personas.size(); i++){ %>
               <td>
                   <a href="altaPersonas.jsp?modificar=<%=personas.get(i).getIdcliente()+""%>">
                        <%out.print(personas.get(i).getNombre());%>
                   </a>
               </td>
               <td><%out.print(personas.get(i).getRfc());%></td>
               <td><%out.print(personas.get(i).getAppat());%></td>
               <td><%out.print(personas.get(i).getApmat());%></td>
               <td><%out.print(sdffechamostrar.format(personas.get(i).getFechnac()));%></td>
               <td><%out.print(personas.get(i).getTelefono());%></td>
               <td><%out.print(personas.get(i).getDireccion());%></td>
               <td><%out.print(personas.get(i).getCelular());%></td>
               <td><%out.print(personas.get(i).getEmail());%></td>
               <td><input type="checkbox" name="cbBorrar" value="<%=personas.get(i).getIdcliente()+""%>"></td>
               </tr>
           <%}%>
           </table>
           <table>
               <%if(personas.size()<1) {
                   out.println("SU CONSULTA NO ARROJÓ NINGÚN RESULTADO");
               }else{%>
                    <table>
                    <tr>
                        <td>
                            <input type="button" value="Eliminar Seleccion" name="btEliminar" id="btEliminar" onclick="validar();">
                        </td>
                    </tr>
                    </table>
               <%}%>
           </table>          
     </form>
 </body>
</html>
