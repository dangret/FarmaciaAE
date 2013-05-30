<%-- 
    Document   : modificaUsuario
    Created on : 20/05/2013, 11:12:22 PM
    Author     : sears
--%>

<%@page import="java.util.List"%>
<%@page import="ittepic.edu.mx.entidades.Numtarjeta"%>
<%@page import="ittepic.edu.mx.ejbs.EJBTarjetaLocal"%>
<%@page import="beans.usuario"%>
<%@page import="ittepic.edu.mx.clases.Codificador"%>
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
    EJBTarjetaLocal ejb3 = null;

    public void jspInit() {
        try {
            InitialContext ic = new InitialContext();
            ejb = (EJBPersonasRemote) ic.lookup(EJBPersonasRemote.class.getName());

            InitialContext ic2 = new InitialContext();
            ejb2 = (EJBUsuariosRemote) ic2.lookup(EJBUsuariosRemote.class.getName());

            InitialContext ic3 = new InitialContext();
            ejb3 = (EJBTarjetaLocal) ic3.lookup(EJBTarjetaLocal.class.getName());

            System.out.println("Bean cargado");
        } catch (Exception ex) {
            System.out.println("Error:"
                    + ex.getMessage());
        }
    }
%>
<%
    //obtenemos el usuario que inició sesion 
    Usuario sesionUser = (Usuario) session.getAttribute("usuario") == null ? null : (Usuario) session.getAttribute("usuario");
    //PARTE DE LOS VALUES
    int band = request.getParameter("band") == null ? 0 : 1;
    int idcliente = request.getParameter("idusuario") == null ? 0 : Integer.parseInt(request.getParameter("idusuario"));
    Usuario usr = ejb2.consultaPorId(idcliente);
    Persona per = usr.getIdcliente();
    //Numtarjeta x = tarj.get();

    //PARTE DE MODIFICACION
    //usuario u = new usuario();
    Calendar calendario = GregorianCalendar.getInstance();
    String nombre = request.getParameter("nombre") == null ? "" : request.getParameter("nombre").toUpperCase();
    String email = request.getParameter("email") == null ? "" : request.getParameter("email").toLowerCase();
    String user = request.getParameter("user") == null ? "" : request.getParameter("user");
    String password = request.getParameter("password") == null ? "" : request.getParameter("password");

    //MUESTRO DATOS  
    Date fecha = usr.getFechacreacion();
    SimpleDateFormat formato1 = new SimpleDateFormat("dd");
    SimpleDateFormat formato2 = new SimpleDateFormat("MM");
    SimpleDateFormat formato3 = new SimpleDateFormat("yyyy");
    String dia = formato1.format(fecha);
    String mes = formato2.format(fecha);
    String año = formato3.format(fecha);

    // GUARDO DATOS
    if (band == 1) {
        //TABLA PERSONA
        usr = ejb2.consultaPorId(idcliente);
        per = ejb.consultaPorId(idcliente);
        String apepat = request.getParameter("apepat") == null ? "" : request.getParameter("apepat").toUpperCase();
        String apemat = request.getParameter("apemat") == null ? "" : request.getParameter("apemat").toUpperCase();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date fecnac = format.parse(request.getParameter("fecnac") == null ? "" : request.getParameter("fecnac"));
        String telf = request.getParameter("telf") == null ? "" : request.getParameter("telf").toUpperCase();
        String celular = request.getParameter("celular") == null ? "" : request.getParameter("celular");
        String direccion = request.getParameter("direccion") == null ? "" : request.getParameter("direccion").toUpperCase();

        //codificar password
        Codificador codec = new Codificador();


        per.setNombre(nombre);
        per.setAppat(apepat);
        per.setApmat(apemat);
        per.setFechnac(fecnac);
        per.setTelefono(telf);
        per.setCelular(celular);
        per.setDireccion(direccion);

        //per.setEmail(email);
        //ejb.alta_modificacion(per);

        //TIPO DE USUARIO
        //int tipo = usr.getTipousuario().getIdtipousuario();

        // TABLA USUARIO
        //int tipoUsuario = tipo;
        //int idcliente = u.ultimo();
        //calendario = GregorianCalendar.getInstance();
        //fecha = calendario.getTime();
        //SimpleDateFormat formatox = new SimpleDateFormat("dd-MM-yyyy");
        //String fecCre1 = formatox.format(fecha);
        //Date fecCre2 = formatox.parse(fecCre1);

        //codificar contraseña
        //

        //Setear Usuario
        //usr.setIdusuario(idcliente);
        //usr.setTipousuario(ejb3.obtenerPorID(tipo));
        usr.setIdcliente(per);
        //usr.setLogin(user);
        if(!password.equals("")){
        password = codec.encriptar(password, "MD5");
        usr.setPassword(password);
        }
        //usr.setFechacreacion(fecCre2)
        ejb2.alta(usr);
        ejb.alta_modificacion(per);

        response.sendRedirect("/Farmacia_AE/index.jsp");
    }

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta de alumnos</title>
        <script>
            function cancelar1() {
                window.location="index.jsp";
            }
            function termino(){
                
                
            }
        </script>
    </head>
    <body>
        <div align="left">
            <H2>REGISTRO DE USUARIOS</H1>
        </div>

        <form name="formulario" action="modificaUsuario.jsp?idusuario=<%=idcliente%>&band=1" method="POST">
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
                        <td><input type="date" name="fecnac" id="fecnac" value="<%=año + "-" + mes + "-" + dia%>"></td>
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
                        <td><input type="text" name="email" id="email" value="<%=per.getEmail()%>" disabled="true"></td>
                    </tr>


                </table><br>
                <table border="1">
                    <tr>
                        <td width="147">USER:</td>
                        <td width="140"><input type="text" name="user"  value="<%=usr.getLogin()%>" disabled="true"></td>
                    </tr>
                    <tr>
                        <td>Password Nuevo:</td>
                        <td><input type="password" name="password"></td>
                    </tr>
                    <% if (sesionUser != null){
                        if (sesionUser.getTipousuario().getIdtipousuario() == 1){%>
                    <tr><td>TIPO: 
                        </td>
                        <td><SELECT NAME="combo" SIZE=1> 
                                <option value="#">:: Seleccione ::</option>
                                <OPTION VALUE="1">Administrador</OPTION>
                                <OPTION VALUE="2">Usuario</OPTION>
                                <OPTION VALUE="3">Distribuidor</OPTION>
                            </SELECT></td>
                    </tr>
                    <%}
                    }%>
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
