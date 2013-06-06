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
    EJBTipoUsuarioLocal ejb4=null;

    public void jspInit() {
        try {
            InitialContext ic = new InitialContext();
            ejb = (EJBPersonasRemote) ic.lookup(EJBPersonasRemote.class.getName());

            InitialContext ic2 = new InitialContext();
            ejb2 = (EJBUsuariosRemote) ic2.lookup(EJBUsuariosRemote.class.getName());
            
            InitialContext ic4 = new InitialContext();
            ejb4 = (EJBTipoUsuarioLocal) ic4.lookup(EJBTipoUsuarioLocal.class.getName());

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
    Usuario user = sesionUser;
    boolean userValido = false;
    if (user != null)
        if (user.getEstado())
            //if (user.getTipousuario().getIdtipousuario() == 1)
                userValido = true;
    
    if (!userValido) response.sendRedirect("index.jsp");
    else{
    //PARTE DE LOS VALUES
    int band = request.getParameter("band") == null ? 0 : 1;
    
    int idcliente = 0;
    if (request.getParameter("idusuario") != null ){
        if (!request.getParameter("idusuario").equals("")){
            idcliente = Integer.parseInt(request.getParameter("idusuario"));
        }else{
            idcliente = sesionUser.getIdusuario();
        }
    }else{
       idcliente = sesionUser.getIdusuario(); 
    }
    
    Usuario usr = ejb2.consultaPorId(idcliente);
    Persona per = usr.getIdcliente();
    //Numtarjeta x = tarj.get();

    //PARTE DE MODIFICACION
    //usuario u = new usuario();
    Calendar calendario = GregorianCalendar.getInstance();
    String nombre = request.getParameter("nombre") == null ? "" : request.getParameter("nombre").toUpperCase();
    String email = request.getParameter("email") == null ? "" : request.getParameter("email").toLowerCase();
    String password = request.getParameter("password") == null ? "" : request.getParameter("password");
    int combo = request.getParameter("combo") == null ? sesionUser.getTipousuario().getIdtipousuario() : Integer.parseInt(request.getParameter("combo"));

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
        per = usr.getIdcliente();
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
        int tipo = combo;

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
        usr.setTipousuario(ejb4.obtenerPorID(tipo));
        usr.setIdcliente(per);
        //usr.setLogin(user);
        if (!password.equals("")) {
            password = codec.encriptar(password, "MD5");
            usr.setPassword(password);
        }
        //usr.setFechacreacion(fecCre2)
        ejb2.alta(usr);
        ejb.alta_modificacion(per);

        response.sendRedirect("modificaUsuario.jsp");
    }

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta de alumnos</title>
        <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
        <script src="js/jquery.maskedinput.js" type="text/javascript"></script>
        <script src="js/jquery.maskMoney.js" type="text/javascript"></script>
        <script>
            
            jQuery(function($){
                $("#btn-submit").click(function(){
                    $(".error").hide();
                    var errorValidacion = false;
                    
                    var email = $("#jmail").val();
                    var nombre = $("#nombre").val();
                    var apepat = $("#apepat").val();
                    var apemat = $("#apemat").val();
                    var user = $("#user").val();
                    var pass = $("#pass").val();
                    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
                    var nombreReg = /[a-zA-Z]*/;
                    var passReg = /[\w\W]{6}[\w\W]*/;
                    var userReg = /[a-z][\w]*/;
                    
                    
                    
                    if (pass == ""){
                        errorValidacion = true;
                        $("#pass").after("<span class='error'>debe introducir password</span>");
                        $("#pass").focus();
                    }else{
                        if (!passReg.test(pass)){
                            errorValidacion = true;
                            $("#pass").after("<span class='error'>debe de medir contener minimo 6 caracteres</span>");
                            $("#pass").focus();
                        }
                    }
                    
                    if (user == ""){
                        errorValidacion = true;
                        $("#user").after("<span class='error'>debe introducir un nombre de usuario</span>");
                        $("#user").focus();
                    }else{
                        if (!userReg.test(user)){
                            errorValidacion = true;
                            $("#user").after("<span class='error'>debe empeazar con una letra</span>");
                            $("#user").focus();
                        }
                    }
                    
                    if (email == ""){
                        errorValidacion = true;
                        $("#jmail").after("<span class='error'>introduzca un e-mail</span>");
                        $("#jmail").focus();
                    }else{
                        if(!emailReg.test(email)){
                            errorValidacion = true;
                            $("#jmail").after("<span class='error'>email no valido</span>");
                            $("#jmail").focus();
                        } 
                    }
                    
                    if (!nombreReg.test(apemat)){
                        errorValidacion = true;
                        $("#apepat").after("<span class='error'>el apellido solo debe de llevar letras</span>");
                        $("#apepat").focus();
                    }
                    
                    if (!nombreReg.test(apepat)){
                        errorValidacion = true;
                        $("#apepat").after("<span class='error'>el apellido solo debe de llevar letras</span>");
                        $("#apepat").focus();
                    }
                    
                    
                    
                    if (nombre == ""){
                        errorValidacion = true;
                        $("#nombre").after("<span class='error'>debe introducir un nombre</span>");
                        $("#nombre").focus();
                    }else{
                        if (!nombreReg.test(nombre)){
                            errorValidacion = true;
                            $("#nombre").after("<span class='error'>el nombre solo debe llevar letras</span>");
                            $("#nombre").focus();
                        }
                    }
                    
                    /*if ($("#apepat").val() == ""){
                        errorValidacion = true;
                        $("#apepat").after("<span class='error'>debe introducir un apellido</span>");
                        $("#apepat").focus();
                    }else{
                        if (nombreReg.test($("#apepat").val())){
                            errorValidacion = true;
                        $("#apepat").after("<span class='error'>el apellido solo debe de llevar letras</span>");
                        $("#apepat").focus();
                        }
                        
                    }*/
                    
                    
                    
                    
                    
                    if (errorValidacion == true) {return false;}
                    
                });
                
                $("#celular").mask("(999) 999-9999",{placeholder: " "});
                $("#telf").mask("999-99-99",{placeholder: " "});
                
                $("#btn-servlet").click(function(){
                    $(".error").hide();
                    var email = $("#jmail").val();
                    
                    $.post("ServletUser",{mail: email},function(data) { 
                        alert(data.valido);
                        var valido = data.valido;
                        alert(valido);
                        if (!valido){
                            $("#jmail").after("<div class='error'>ese email ya fue usado</div>");
                        }
                    });
                });
                
            });
            
            function cancelar1() {
                window.location="consultaUsuarios.jsp";
            }
            function termino(){
                
                
            }
        </script>
    </head>
    <body>
        <div align="center">
            <H2>REGISTRO DE USUARIOS</H1>
        </div>

        <form name="formulario" action="modificaUsuario.jsp?idusuario=<%=idcliente%>&band=1" method="POST">
            <div align="center">
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
                        <td><input type="text" name="email" id="jemail" value="<%=per.getEmail()%>" disabled="true"></td>
                    </tr>


                </table><br>
                <table border="1">
                    <tr>
                        <td width="147">USER:</td>
                        <td width="140"><input type="text" name="user" id="user"  value="<%=usr.getLogin()%>" disabled="true"></td>
                    </tr>
                    <tr>
                        <td>Password Nuevo:</td>
                        <td><input type="password" id="pass" name="password"></td>
                    </tr>
                    <% if (sesionUser != null) {
                            if (sesionUser.getTipousuario().getIdtipousuario() == 1) {%>
                    <tr><td>TIPO: 
                        </td>
                        <td><SELECT NAME="combo" SIZE=1> 
                                <OPTION value="#">:: Seleccione ::</option>
                                <OPTION VALUE="1"<% if(usr.getTipousuario().getIdtipousuario() == 1){ %>selected<%}%>>Administrador</OPTION>
                                <OPTION VALUE="2"<% if(usr.getTipousuario().getIdtipousuario() == 2){ %>selected<%}%>>Usuario</OPTION>
                                <OPTION VALUE="3"<% if(usr.getTipousuario().getIdtipousuario() == 3){ %>selected<%}%>>Distribuidor</OPTION>
                            </SELECT></td>
                    </tr>
                    <%}
                        }}%>
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
