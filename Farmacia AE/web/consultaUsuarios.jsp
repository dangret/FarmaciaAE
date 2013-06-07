<%-- 
    Document   : consultaUsuarios
    Created on : 20/05/2013, 08:47:51 PM
    Author     : sears
--%>

<%@page import="ittepic.edu.mx.ejbs.EJBTarjetaLocal"%>
<%@page import="ittepic.edu.mx.ejbs.EJBPersonasRemote"%>
<%@page import="ittepic.edu.mx.entidades.Numtarjeta"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="ittepic.edu.mx.entidades.Persona"%>
<%@page import="ittepic.edu.mx.entidades.CatTiposusuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!    
    EJBUsuariosRemote ejb2 = null;
    EJBPersonasRemote ejb = null;
    EJBTarjetaLocal ejbTarjeta = null;

    public void jspInit() {
        try {

            InitialContext ic2 = new InitialContext();
            ejb2 = (EJBUsuariosRemote) ic2.lookup(EJBUsuariosRemote.class.getName());
            
            InitialContext ic3 = new InitialContext();
            ejbTarjeta = (EJBTarjetaLocal) ic3.lookup(EJBTarjetaLocal.class.getName());
            
            InitialContext ic = new InitialContext();
            ejb = (EJBPersonasRemote) ic.lookup(EJBPersonasRemote.class.getName());

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
    Usuario usr;
    Persona per;
    CatTiposusuario tipoUsr;
    String elimina[]=request.getParameterValues("borrar");
    int bandera = request.getParameter("group2")== null ? 0 : Integer.parseInt(request.getParameter("group2"));
    List<Usuario> users = new ArrayList<Usuario>();
    List<CatTiposusuario> tipousers = new ArrayList<CatTiposusuario>();
    users = ejb2.consultaGeneral();
    int tam=users.size();
    
    DateFormat df =  DateFormat.getDateInstance();
    
    if(elimina!=null){
        for(int i=0; i<elimina.length;i++) {
            usr = new Usuario();
            usr = ejb2.consultaPorId(Integer.parseInt(elimina[i]));
            per = usr.getIdcliente();
            ejbTarjeta.borrarTarjetas(per.getNumtarjetaList());
            ejb2.eliminarEntidad(usr);
            
            per.setUsuarioList(new ArrayList<Usuario>());
            per.setNumtarjetaList(new ArrayList<Numtarjeta>());
            ejb.eliminar(per);
            
       }
    }
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consulta General Personas</title>
        <script>
            function validar(){
             {
             var conf = confirm("¿Esta eguro que desea eliminar Usuarios?");
             if(conf)
             {
                 formulario = document.getElementsByName("formulario");
                 document.formulario.submit();
             }
            }
                
            }
        </script>
</head>
<body>
    <div align="center">
        <form action="consultaUsuarios.jsp" method="POST">
            OPCIONES DE FILTRO:
            <input type="submit" id="buscar" name="btnBuscar" value="BUSCAR"><BR>
            <input type="radio" name="group2" id="group2" value="1"> BUSQUEDA ADMINISTRADOR
            <input type="radio" name="group2" id="group2" value="2">BUSQUEDA CLIENTES 
            <input type="radio" name="group2" id="group2" value="3">BUSQUEDA PROVEEDORES <br><br>
        </form>
    
    <form action="consultaUsuarios.jsp" method="POST" name="formulario">
    
    <table border="1">
        <tr>
            <th style="background-color: darkred; color: white">ID USUARIO</th>
            <th style="background-color: darkred; color: white">TIPO USUARIO</th>
            <th style="background-color: darkred; color: white">NICK NAME</th>
            <th style="background-color: darkred; color: white">FECHA CREACION</th>
            <th style="background-color: darkred; color: white">ELIMINAR</th>
        </tr>
        
    
            <%for (int i = 0; i < users.size(); i++) {%>
            <%if (bandera == 1) {%>
        <tr>
            <%if (users.get(i).getTipousuario().getIdtipousuario()==1){%>
            <td><a href="modificaUsuario.jsp?idusuario=<%=users.get(i).getIdusuario()+""%>"><%=users.get(i).getIdusuario() + ""%></td>
            <td><%out.print("ADMINISTRADOR");%></td>
            <td><%out.print(users.get(i).getLogin());%></td>
            <td><%out.print(df.format(users.get(i).getFechacreacion()));%></td>
            <td><input type="checkbox" name="borrar" value="<%=users.get(i).getIdusuario() + ""%>"</td>
        </tr>
            <%}%>    
            <%}%>
            <%}%>
            
           
            <%for (int i = 0; i < users.size(); i++) {%>
            <%if (bandera == 2) {%>
        <tr>
            <%if (users.get(i).getTipousuario().getIdtipousuario()==2){%>
            <td><a href="modificaUsuario.jsp?idusuario=<%=users.get(i).getIdusuario() + ""%>"><%=users.get(i).getIdusuario() + ""%></td>
            <td><%out.print("CLIENTE");%></td>
            <td><%out.print(users.get(i).getLogin());%></td>
            <td><%out.print(df.format(users.get(i).getFechacreacion()));%></td>
            <td><input type="checkbox" name="borrar" value="<%=users.get(i).getIdusuario() + ""%>"</td>
        </tr>
            <%}%>    
            <%}%>
            <%}%>
            
            
            <%for (int i = 0; i < users.size(); i++) {%>
            <%if (bandera == 3) {%>
        <tr>
            <%if (users.get(i).getTipousuario().getIdtipousuario()==3){%>
            <td><a href="modificaProvedor.jsp?idusuario=<%=users.get(i).getIdusuario() + ""%>"><%=users.get(i).getIdusuario() + ""%></td>
            <td><%out.print("PROVEEDOR");%></td>
            <td><%out.print(users.get(i).getLogin());%></td>
            <td><%out.print(df.format(users.get(i).getFechacreacion()));%></td>
            <td><input type="checkbox" name="borrar" value="<%=users.get(i).getIdusuario() + ""%>"</td>
        </tr>
            <%}%>    
            <%}%>
            <%}}%>
    </table>
    <table>
        <tr>
            <td><input type="submit" value="Eliminar" name="btEliminar" ></td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
