<%-- 
    Document   : consultaUsuarios
    Created on : 20/05/2013, 08:47:51 PM
    Author     : sears
--%>

<%@page import="ittepic.edu.mx.entidades.CatTiposusuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!    EJBUsuariosRemote ejb2 = null;

    public void jspInit() {
        try {

            InitialContext ic2 = new InitialContext();
            ejb2 = (EJBUsuariosRemote) ic2.lookup(EJBUsuariosRemote.class.getName());

            System.out.println("Bean cargado");
        } catch (Exception ex) {
            System.out.println("Error:"
                    + ex.getMessage());
        }
    }
%>
<%
    List<Usuario> users = new ArrayList<Usuario>();
    List<CatTiposusuario> tipousers=new ArrayList<CatTiposusuario>();
    users = ejb2.consultaGeneral();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consulta General Usuarios</title>
    </head>
    <body>
        <table border="1">
            <tr>
                <th>ID USUARIO</th>
                <th>TIPO USUARIO</th>
                <th>NICK NAME</th>
                <th>FECHA CREACION</th>
                <th>ELIMINAR</th>
            </tr>

            <tr>
                <%for (int i = 0; i < users.size(); i++) {%>
                <td><a href="modificaUsuario.jsp?idpersona=<%=users.get(i).getIdcliente().getIdcliente()+""%>"><%=users.get(i).getIdcliente().getIdcliente()+""%></td>
                <td><%out.print(users.get(i).getTipousuario().getIdtipousuario()==1?"ADMINISTRADOR":"USUARIO");%></td>
                <td><%out.print(users.get(i).getLogin());%></td>
                <td><%out.print(users.get(i).getFechacreacion());%></td>
                <td><input type="checkbox" name="cbBorrar" value="<%=users.get(i).getIdusuario()+""%>"</td>
            </tr>
            <%}%>
        </table>
        <table>
            <tr>
                <td><input type="button" value="Eliminar" name="btEliminar" onclick="validar();"></td>
            </tr>
        </table>
    </body>
</html>
