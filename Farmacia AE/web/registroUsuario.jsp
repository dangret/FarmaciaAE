<%@page import="ittepic.edu.mx.ejbs.EJBPersonasRemote"%>
<%@page import="ittepic.edu.mx.entidades.CatTiposusuario"%>
<%@page import="ittepic.edu.mx.ejbs.EJBTipoUsuarioLocal"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="ittepic.edu.mx.entidades.Persona"%>
<%@page import="beans.usuario"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
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
    usuario u = new usuario();
    String nombre = request.getParameter("nombre") == null ? "" : request.getParameter("nombre");
    int combo = request.getParameter("combo") == null ? 1 : Integer.parseInt(request.getParameter("combo"));
    Usuario usr;
    Persona per;
    CatTiposusuario tipoUsr;

    if (!nombre.equals("")) {
        //TABLA PERSONA
        String apepat = request.getParameter("apepat") == null ? "" : request.getParameter("apepat");
        String apemat = request.getParameter("apemat") == null ? "" : request.getParameter("apemat");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date fecnac = format.parse(request.getParameter("fecnac") == null ? "" : request.getParameter("fecnac"));
        String telf = request.getParameter("telf") == null ? "" : request.getParameter("telf");
        String celular = request.getParameter("celular") == null ? "" : request.getParameter("celular");
        String direccion = request.getParameter("direccion") == null ? "" : request.getParameter("direccion");
        String email = request.getParameter("email") == null ? "" : request.getParameter("email");
        per = new Persona();
        per.setNombre(nombre);
        per.setAppat(apepat);
        per.setApmat(apemat);
        per.setFechnac(fecnac);
        per.setTelefono(telf);
        per.setCelular(celular);
        per.setDireccion(direccion);
        per.setEmail(email);
        //ejb.alta_modificacion(per);
        
        //TIPO DE USUARIO
         int tipo=combo;
        
        // TABLA USUARIO
        usr = new Usuario();
        int tipoUsuario = combo;
        int idcliente = u.ultimo() + 1;
        String user = request.getParameter("user");
        String password = request.getParameter("password");
        Calendar calendario = GregorianCalendar.getInstance();
        Date fecha = calendario.getTime();
        SimpleDateFormat formato = new SimpleDateFormat("dd-MM-yyyy");
        String fecCre1 = formato.format(fecha);
        System.out.println(fecCre1);
        Date fecCre2 = formato.parse(fecCre1);
        
        //Setear Usuario
        usr.setTipousuario(ejb3.obtenerPorID(tipo));
        usr.setIdcliente(per);
        usr.setLogin(user);
        usr.setPassword(password);
        usr.setFechacreacion(fecCre2);
        
        ejb2.alta(usr);
    }

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
                        <td><input type="text" name="nombre" id="nombre"></td>
                    </tr> 
                    <tr>
                        <td>Apellido Paterno: </td>
                        <td><input type="text" name="apepat" id="apepat"></td>
                    </tr>
                    <tr>
                        <td>Apellido Materno: </td>
                        <td><input type="text" name="apemat" id="apemat"></td>
                    </tr>
                    <tr>
                        <td>Fecha de Nacimiento: </td>
                        <td><input type="date" name="fecnac" id="fecnac"></td>
                    </tr>
                    <tr>
                        <td>Teléfono Fijo: </td>
                        <td><input type="text" name="telf" id="telf"></td>
                    </tr>
                    <tr>
                        <td>Celular: </td>
                        <td><input type="text" name="celular" id="celular"></td>
                    </tr>
                    <tr>
                        <td>Direccion:<br>
                        <td>   <textarea name="direccion" cols="20" rows="2"></textarea></td>
                        </td>
                    </tr>
                    <tr>
                        <td>E-Mail: </td>
                        <td><input type="text" name="email" id="email"></td>
                    </tr>

                </table><br>
                <table border="1">
                    <tr>
                        <td width="147">USER:</td>
                        <td width="140"><input type="text" name="user"></td>
                    </tr>
                    <tr>
                        <td>PASSWORD:</td>
                        <td><input type="password" name="password"></td>
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
