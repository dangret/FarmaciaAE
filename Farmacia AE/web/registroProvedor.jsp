<%@page import="ittepic.edu.mx.clases.Mail"%>
<%@page import="ittepic.edu.mx.clases.Codificador"%>
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
    Usuario usera = (Usuario) session.getAttribute("usuario") == null ? null : (Usuario) session.getAttribute("usuario");
    boolean userValido = false;
    String nickname = request.getParameter("user") == null ? "" : request.getParameter("user");
    String pass = request.getParameter("password") == null ? "" : request.getParameter("password");
    String rfc = request.getParameter("rfc") == null ? "" : request.getParameter("rfc").toUpperCase();
    String nombre = request.getParameter("nombre") == null ? "" : request.getParameter("nombre").toUpperCase();
    String email = request.getParameter("email") == null ? "" : request.getParameter("email");
    Usuario usr;
    Persona per;

    if ((!rfc.equals("")) || (!nickname.equals("")) || (!pass.equals("") || (!email.equals("")) || (!nombre.equals("")))) {
        //TABLA PERSONA
        String telf = request.getParameter("telf") == null ? "" : request.getParameter("telf");
        String celular = request.getParameter("celular") == null ? "" : request.getParameter("celular");
        String direccion = request.getParameter("direccion") == null ? "" : request.getParameter("direccion").toUpperCase();

        per = new Persona();
        per.setRfc(rfc);
        per.setNombre(nombre);
        per.setTelefono(telf);
        per.setCelular(celular);
        per.setDireccion(direccion);
        per.setEmail(email);
        //ejb.alta_modificacion(per);

        //TIPO DE USUARIO
        int tipo = 3;

        // TABLA USUARIO
        usr = new Usuario();
        String user = request.getParameter("user");
        String password = request.getParameter("password");
        Calendar calendario = GregorianCalendar.getInstance();
        Date fecha = calendario.getTime();
        SimpleDateFormat formato = new SimpleDateFormat("dd-MM-yyyy");
        String fecCre1 = formato.format(fecha);
        Date fecCre2 = formato.parse(fecCre1);

        //Codifico Password
        Codificador codec = new Codificador();
        password = codec.encriptar(password, "MD5");

        //Setear Usuario
        usr.setTipousuario(ejb3.obtenerPorID(tipo));
        usr.setIdcliente(per);
        usr.setLogin(user);
        usr.setPassword(password);
        usr.setFechacreacion(fecCre2);
        usr.setEstado(false);
        ejb2.alta(usr);
        
        Mail m=new Mail();
        String clave=m.encriptar(user);
        int i=m.enviarMail(clave,email);
        if(i==1){
        System.out.println(i);
        }else{
        System.out.println("NO SE CREO CORRECTAMENTE EL CORREO - ERROR");        
        }
    }
  
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta de alumnos</title>
        <script>
            function cancelar1() {
                window.location="login.jsp";
            }
        </script>
    </head>
    <body>
        <div align="left">
            <H2>REGISTRO DE PROOVEDORES</H1>
        </div>

        <form name="formulario" action="registroProvedor.jsp" method="POST">
            <div align="left">
                <table border="1">
                    <tr>
                        <th colspan="2" style="background-color: darkred; color: white">Datos Proveedor</th>
                    </tr>
                    <tr>
                        <td>* Nombre Empresa: </td>
                        <td><input type="text" name="nombre" id="nombre"></td>
                    </tr> 
                    <tr>
                        <td>* RFC: </td>
                        <td><input type="text" name="rfc" id="rfc"></td>
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
                    </tr>
                    <tr>
                        <td>* E-Mail: </td>
                        <td><input type="text" name="email" id="email"></td>
                    </tr>

                </table><br>
                <table border="1">
                    <tr>
                        <td width="147">* USER:</td>
                        <td width="140"><input type="text" name="user"></td>
                    </tr>
                    <tr>
                        <td>* PASSWORD:</td>
                        <td><input type="password" name="password"></td>
                    </tr>

                </table>

                <table border="1">
                    <br>
                    <tr align="center">
                    <input type="submit" name="guardar" value="GUARDAR">

                    <input type="button" name="cancelar" value="CANCELAR" onclick="cancelar1();">
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>
