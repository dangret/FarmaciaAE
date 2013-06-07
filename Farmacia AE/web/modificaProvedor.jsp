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
    Usuario user = (Usuario) session.getAttribute("usuario") == null ? null : (Usuario) session.getAttribute("usuario");
    boolean userValido = false;
    if (user != null) 
        if (user.getEstado()) 
                userValido = true;
    
    if (!userValido)
        response.sendRedirect("index.jsp");
    else {
        int idusuario = request.getParameter("idusuario") == null ? user.getIdusuario() : Integer.parseInt(request.getParameter("idusuario"));
        String rfc = request.getParameter("rfc") == null ? "" : request.getParameter("rfc").toUpperCase();
        String nombre = request.getParameter("nombre") == null ? "" : request.getParameter("nombre").toUpperCase();
        String email = request.getParameter("email") == null ? "" : request.getParameter("email");
        String telf = request.getParameter("telf") == null ? "" : request.getParameter("telf");
        String celular = request.getParameter("celular") == null ? "" : request.getParameter("celular");
        String direccion = request.getParameter("direccion") == null ? "" : request.getParameter("direccion").toUpperCase();

        Usuario usr = ejb2.consultaPorId(idusuario);
        Persona per = usr.getIdcliente();

        if ((!rfc.equals("")) || (!email.equals("")) || (!nombre.equals(""))) {
            usr = ejb2.consultaPorId(idusuario);
            per = usr.getIdcliente();
            //TABLA PERSONA
            per.setRfc(rfc);
            per.setNombre(nombre);
            per.setTelefono(telf);
            per.setCelular(celular);
            per.setDireccion(direccion);
            //per.setEmail(email);
            //ejb.alta_modificacion(per);

            // TABLA USUARIO
            String password = request.getParameter("password");
            //Codifico Password
            if (!password.equals("")) {
                Codificador codec = new Codificador();
                password = codec.encriptar(password, "MD5");
                usr.setPassword(password);
            }
            //Setear Usuario
            //usr.setTipousuario(ejb3.obtenerPorID(tipo));
            usr.setIdcliente(per);
            //usr.setLogin(user);
            //usr.setFechacreacion(fecCre2);
            ejb2.alta(usr);
            ejb.alta_modificacion(per);
            if (user.getTipousuario().getIdtipousuario() == 1)
                response.sendRedirect("consultaUsuarios.jsp");
            else
                response.sendRedirect("principal.jsp");
        }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta de alumnos</title>
        <script>
            function cancelar1() {
                window.location="principal.jsp";
            }
            
             function termina(){
             var conf = confirm("¿Esta seguro que desea guardar los Cambios?");
             if(!conf)
             {
                  location.href="consultaUsuarios.jsp";
             }
                
            }
        </script>
    </head>
    <body>
        <div align="center">
            <H2>REGISTRO DE PROOVEDORES</H2>
            <br>
        </div>
        <form name="formulario" action='modificaProvedor.jsp?idusuario=<%=idusuario%>' method="POST">
            <div align="center">
                <table border="1">
                    <tr>
                        <th colspan="2" style="background-color: darkred; color: white">Datos Proveedor</th>
                    </tr>
                    <tr>
                        <td>* Nombre Empresa: </td>
                        <td><input type="text" name="nombre" id="nombre" value="<%=per.getNombre()%>"></td>
                    </tr> 
                    <tr>
                        <td>* RFC: </td>
                        <td><input type="text" name="rfc" id="rfc" value="<%=per.getRfc()%>"></td>
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
                        <td>Direccion:</td>
                        <td>   <textarea name="direccion" cols="20" rows="2"><%=per.getDireccion()%></textarea></td>
                    </tr>
                    <tr>
                        <td>* E-Mail: </td>
                        <td><input type="text" name="email" id="email" disabled="true" value="<%=per.getEmail()%>"></td>
                    </tr>

                </table><br>
                <table border="1">
                    <tr>
                        <td width="147">* USER:</td>
                        <td width="140"><input type="text" name="user" value="<%=usr.getLogin()%>" disabled="true"></td>
                    </tr>
                    <tr>
                        <td>* PASSWORD:</td>
                        <td><input type="password" name="password"></td>
                    </tr>

                </table>

                <table border="1">
                    <br>
                    <tr align="center">
                    <input type="submit" name="guardar" value="GUARDAR" onclick="termina();">

                    <input type="button" name="cancelar" value="CANCELAR" onclick="cancelar1();">
                    </tr>
                </table>
            </div>
        </form>
        <%}%>
    </body>
</html>
