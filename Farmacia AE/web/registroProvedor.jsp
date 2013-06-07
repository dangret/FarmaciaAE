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

        Mail m = new Mail();
        String clave = m.encriptar(user);
        int i = m.enviarMail(clave, email);
        if (i == 1) {
            System.out.println(i);
        } else {
            System.out.println("NO SE CREO CORRECTAMENTE EL CORREO - ERROR");
        }
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Distribuidores</title>
        <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
        <script src="js/jquery.maskedinput.js" type="text/javascript"></script>
        <script src="js/jquery.maskMoney.js" type="text/javascript"></script>
        <link href="style.css" type="text/css">
        <script>
            jQuery(function($){
            $("#btn-submit").click(function(){
                $(".error").hide();
                var errorValidacion = false;
                
                var nombre=$("#nombre").val();
                var rfc=$("#rfc").val();
                var telf=$("#telf").val();   
                var celular=$("#celular").val();  
                var email=$("#email").val();
                var user=$("#user").val();
                var pass=$("#password").val();
                var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
                var nombreReg = /[a-zA-Z]*/;
                var passReg = /[\w\W]{6}[\w\W]*/;
                var userReg = /[a-z][\w]*/;
                var rfcReg=/^(([A-Z]|[a-z]|\s){1})(([A-Z]|[a-z]){3})([0-9]{6})((([A-Z]|[a-z]|[0-9]){3}))/;
                
                     if (pass == ""){
                        errorValidacion = true;
                        $("#password").after("<span class='error'>Introduce Password</span>");
                        $("#password").focus();
                    }else{
                        if (!passReg.test(pass)){
                            errorValidacion = true;
                            $("#password").after("<span class='error'>Usuario no Valido</span>");
                            $("#password").focus();
                        }
                    }
                    
                     if (user == ""){
                        errorValidacion = true;
                        $("#user").after("<span class='error'>Introduce Usuario</span>");
                        $("#user").focus();
                    }else{
                        if (!userReg.test(user)){
                            errorValidacion = true;
                            $("#user").after("<span class='error'>Usuario inicia con Letra</span>");
                            $("#user").focus();
                        }
                    }
                    
                    if (email == ""){
                        errorValidacion = true;
                        $("#email").after("<span class='error'>introduzca e-mail</span>");
                        $("#email").focus();
                    }else{
                        if(!emailReg.test(email)){
                            errorValidacion = true;
                            $("#email").after("<span class='error'>Email no valido</span>");
                            $("#email").focus();
                        } 
                    }
                    
                    if (nombre == ""){
                        errorValidacion = true;
                        $("#nombre").after("<span class='error'>Introduce Nombre</span>");
                        $("#nombre").focus();
                    }else{
                        if (!nombreReg.test(nombre)){
                            errorValidacion = true;
                            $("#nombre").after("<span class='error'>Nombre con Letras</span>");
                            $("#nombre").focus();
                        }
                    }
                   
                   if (rfc == ""){
                        errorValidacion = true;
                        $("#rfc").after("<span class='error'>Introduce RFC, Ej:AASS810823FGD</span>");
                        $("#rfc").focus();
                    }else{
                        if (!rfcReg.test(rfc)){
                            errorValidacion = true;
                            $("#rfc").after("<span class='error'>Error, Ej: AASS810823FGD</span>");
                            $("#rfc").focus();
                        }
                    }
                 $("#celular").mask("(999) 999-9999",{placeholder: " "});
                $("#telf").mask("999-99-99",{placeholder: " "});
                    
                    if (errorValidacion == true) {return false;}
                });
                                });
                
                        
            function cancelar1() {
                window.location="principal.jsp";
            }
        </script>
    </head>
    <body>
        <div align="left">
            <H2>DISTRIBUIDORES</H1>
        </div>

        <form name="formulario" action="registroProvedor.jsp" method="POST">
            <div align="left">
                <table border="1">
                    <tr>
                        <th colspan="2" style="background-color: darkred; color: white">Datos Distribuidor</th>
                    </tr>
                    <tr>
                        <td>* Nombre Empresa: </td>
                        <td><input type="text" name="nombre" id="nombre"></td>
                    </tr> 
                    <tr>
                        <td>* RFC: </td>
                        <td><input type="text" name="rfc" id="rfc" maxlength="13"></td>
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
                        <td width="140"><input type="text" name="user" id="user"></td>
                    </tr>
                    <tr>
                        <td>* PASSWORD:</td>
                        <td><input type="password" name="password" id="password"></td>
                    </tr>

                </table>

                <table border="1">
                    <br>
                    <tr align="center">
                    <input type="submit" name="guardar" value="Guardar" id="btn-submit">

                    <input type="button" name="cancelar" value="Cancelar" onclick="cancelar1();">
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>
