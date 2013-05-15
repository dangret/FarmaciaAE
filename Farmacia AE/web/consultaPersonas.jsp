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
  String nombre = request.getParameter("nombre");
  String modificar = request.getParameter("modificar");
  String eliminar = request.getParameter("eliminar");
  SimpleDateFormat sdffecha = new SimpleDateFormat("dd-MM-yyyy");
  if(nombre!=null)
  {
   String appat = request.getParameter("appat");
   String apmat = request.getParameter("apmat");
   String fechnac = request.getParameter("fechnac");
   String telefono = request.getParameter("telefono");
   String direccion = request.getParameter("direccion");
   String celular = request.getParameter("celular");
   String email = request.getParameter("email");
   Persona p = new Persona();
   p.setNombre(nombre);
   p.setAppat(appat);
   p.setApmat(apmat);
   p.setFechnac(sdffecha.parse(fechnac));
   p.setTelefono(telefono);
   p.setDireccion(direccion);
   p.setCelular(celular);
   p.setEmail(email);
   if(modificar==null&&eliminar==null){
            ejb.alta_modificacion(p); 
        } else if(modificar!=null ){
            ejb.alta_modificacion(p);
        }
   } else if(eliminar!=null){
        ejb.eliminar(Integer.parseInt(eliminar));
    } else {
        String [] listaeliminar = request.getParameterValues("borrar");
        if(listaeliminar!=null) {
            List<Persona> listaactual = ejb.consultaPersonas(); //obtengo todos los elementos que hay actualmente en el EJB
            List<Persona> listaaeliminar = new ArrayList<Persona>(); //Creo una nueva lista en la que almacenaré los elementos a eliminar
            for(int i=0; i<listaeliminar.length; i++) { //Copio en la lista los objetos de tipo estudiante que deseo eliminar
                listaaeliminar.add(listaactual.get(Integer.parseInt(listaeliminar[i])));
            }
            listaactual.removeAll(listaaeliminar); //Elimino todos los elementos que deseo eliminar
             //Actualizo los datos en el EJB
        }
    }
    session.setAttribute("ejb", ejb);
    List<Persona> personas = ejb.consultaPersonas();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
    <form action="" method="POST" name="formulario">
       <table border="1">
               <tr>
                   <th>Nombre</th>
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
                   <a href="modificarPersona.jsp?i=<%=i+""%>">
                        <%out.print(personas.get(i).getNombre());%>
                   </a>
               </td>
               <td><%out.print(personas.get(i).getAppat());%></td>
               <td><%out.print(personas.get(i).getApmat());%></td>
               <td><%out.println(sdffecha.format(personas.get(i).getFechnac()));%></td>
               <td><%out.print(personas.get(i).getTelefono());%></td>
               <td><%out.print(personas.get(i).getDireccion());%></td>
               <td><%out.print(personas.get(i).getCelular());%></td>
               <td><%out.print(personas.get(i).getEmail());%></td>
               <td><input type="checkbox" value="<%=i%>" name="borrar"></td>
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
