<%-- 
    Document   : modificaUsuario
    Created on : 20/05/2013, 11:12:22 PM
    Author     : sears
--%>

<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ittepic.edu.mx.ejbs.EJBTipoUsuarioLocal"%>
<%@page import="ittepic.edu.mx.entidades.CatTiposusuario"%>
<%@page import="ittepic.edu.mx.entidades.Persona"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="ittepic.edu.mx.ejbs.EJBTipoUsuarioLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBTipoUsuarioLocal"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
<%@page import="ittepic.edu.mx.ejbs.EJBPersonasRemote"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%! EJBPersonasRemote ejb = null;
    EJBUsuariosRemote ejb2 = null;
    EJBTipoUsuarioLocal ejb3 = null;

    public void jspInit() {
        try {
            InitialContext ic = new InitialContext();
            ejb = (EJBPersonasRemote) ic.lookup(EJBPersonasRemote.class.getName());

            InitialContext ic2 = new InitialContext();
            ejb2 = (EJBUsuariosRemote) ic2.lookup(EJBUsuariosRemote.class.getName());

            InitialContext ic3 = new InitialContext();
            ejb3 = (EJBTipoUsuarioLocal) ic3.lookup(EJBTipoUsuarioLocal.class.getName());

            System.out.println("Bean cargado");
        } catch (Exception ex) {
            System.out.println("Error:"
                    + ex.getMessage());
        }
    }
%>
<%
    int idusuario = request.getParameter("idpersona") == null ? 0 : Integer.parseInt(request.getParameter("idpersona"));
    Usuario usr = ejb2.consultaPorId(idusuario);
    Persona per = ejb.consultaPorId(idusuario);
    Calendar calendario = GregorianCalendar.getInstance();
    
    Date fecha = usr.getFechacreacion();
    SimpleDateFormat formato = new SimpleDateFormat("dd");
        SimpleDateFormat formato2 = new SimpleDateFormat("MM");
            SimpleDateFormat formato3 = new SimpleDateFormat("yyyy");
    String dia = formato.format(fecha);
        String mes = formato2.format(fecha);
            String año = formato3.format(fecha);

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta de alumnos</title>
        <script>
            function cancelar1() {
                window.location="opLogin.jsp";
            }
        </script>
    </head>
    <body>
        <div align="left">
            <H2>REGISTRO DE USUARIOS</H1>
        </div>

        <form name="formulario" action="registroUsuario.jsp" method="POST">
            <div align="left">
                <table border="1">
                    <tr>
                        <th colspan="2">Datos Usuarios</th>
                    </tr>
                    <tr>
                        <td>Nombre: </td>
                        <td><input type="text" name="nombre" id="nombre" value="<%=per.getNombre()%>"></td>
                    </tr> 
                    <tr>
                        <td>Apellido Paterno: </td>
                        <td><input type="text" name="apepat" id="apepat" value="<%=per.getAppat()%>"></td>
                    </tr>
                    <tr>
                        <td>Apellido Materno: </td>
                        <td><input type="text" name="apemat" id="apemat" value="<%=per.getApmat()%>"></td>
                    </tr>
                    <tr>
                        <td>Fecha de Nacimiento: </td>
                        <td><input type="date" name="fecnac" id="fecnac" value="<%=año+"-"+mes+"-"+dia%>"></td>
                    </tr>
                    <tr>
                        <td>Teléfono Fijo: </td>
                        <td><input type="text" name="telf" id="telf" value="<%=per.getTelefono()%>"></td>
                    </tr>
                    <tr>
                        <td>Celular: </td>
                        <td><input type="text" name="celular" id="celular" value="<%=per.getCelular()%>"></td>
                    </tr>
                    <tr>
                        <td>Direccion:<br>
                        <td>   <textarea name="direccion" cols="20" rows="2"><%=per.getDireccion()%></textarea></td>
                        </td>
                    </tr>
                    <tr>
                        <td>E-Mail: </td>
                        <td><input type="text" name="email" id="email" value="<%=per.getEmail()%>"></td>
                    </tr>

                </table><br>
                <table border="1">
                    <tr>
                        <td width="147">USER:</td>
                        <td width="140"><input type="text" name="user"  value="<%=usr.getLogin()%>"></td>
                    </tr>
                    <tr>
                        <td>PASSWORD:</td>
                        <td><input type="password" name="password" value="<%=usr.getPassword()%>"></td>
                    </tr>
                    <tr><td>TIPO: 
                        </td>
                        <td><SELECT NAME="combo" SIZE=1> 
                                <option value="#">:: Seleccione ::</option>
                                <OPTION VALUE="1">Administrador</OPTION>
                                <OPTION VALUE="2">Usuario</OPTION>
                            </SELECT></td>
                    </tr>

                </table>

                <table border="1">
                    <br>
                    <tr align="center">
                    <input type="submit" name="guardar" value="Guardar">

                    <input type="button" name="cancelar" value="Cancelar" onclick="cancelar1();">
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>
