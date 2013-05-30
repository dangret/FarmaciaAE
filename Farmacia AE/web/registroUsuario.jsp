<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="ittepic.edu.mx.entidades.Numtarjeta"%>
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
    usuario u = new usuario();
    String nombre = request.getParameter("nombre") == null ? "" : request.getParameter("nombre").toUpperCase();
    String email = request.getParameter("email") == null ? "" : request.getParameter("email").toLowerCase();
    String nickname = request.getParameter("user") == null ? "" : request.getParameter("user");
    String pass = request.getParameter("password") == null ? "" : request.getParameter("password");
    int combo = request.getParameter("combo") == null ? 1 : Integer.parseInt(request.getParameter("combo"));
    String tarjeta=request.getParameter("tarjeta")==null?"":request.getParameter("tarjeta");
    int codigo=request.getParameter("codigo")==null?0:Integer.parseInt(request.getParameter("codigo"));
    String fechaV=request.getParameter("fechaV")==null?"":request.getParameter("fechaV");
    
            
    Usuario usr;
    Persona per;
    CatTiposusuario tipoUsr;

    if ((!email.equals("")) || (!nickname.equals("")) || (!pass.equals("")) || (!nombre.equals("")) || (!tarjeta.equals("")) || (codigo!=0) || (!fechaV.equals(""))) {
        //TABLA PERSONA
        String apepat = request.getParameter("apepat") == null ? null : request.getParameter("apepat").toUpperCase();
        String apemat = request.getParameter("apemat") == null ? null : request.getParameter("apemat").toUpperCase();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date fecnac = null;
        if (request.getParameter("fecnac") != null){
            if (request.getParameter("fecnac") != ""){
                fecnac = format.parse(request.getParameter("fecnac") == null ? null : request.getParameter("fecnac"));
            }
        }
        String telf = request.getParameter("telf") == null ? null : request.getParameter("telf").toUpperCase();
        String celular = request.getParameter("celular") == null ? null : request.getParameter("celular");
        String direccion = request.getParameter("direccion") == null ? null : request.getParameter("direccion").toUpperCase();

        
        //codificar password
        Codificador codec=new Codificador();
        pass = codec.encriptar(pass, "MD5");
        
        per = new Persona();
        per.setNombre(nombre);
        if (apepat != "")     per.setAppat(apepat);
        if (apemat != "")     per.setApmat(apemat);
        if (fecnac != null)     per.setFechnac(fecnac);
        if (telf != "")       per.setTelefono(telf);
        if (celular != "")    per.setCelular(celular);
        if (direccion != "")  per.setDireccion(direccion);
        per.setEmail(email); 
       //ejb.alta_modificacion(per);

        //TIPO DE USUARIO
        int tipo = 2;

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
        
        //codificar contraseña
        password = codec.encriptar(password, "MD5");
        

        

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
        <script src="js/jquery-2.0.1.js" type="text/javascript"></script>
        <script src="js/jquery.maskedinput.js" type="text/javascript"></script>
        <script src="js/jquery.maskMoney.js" type="text/javascript"></script>
        <link href="style.css" type="text/css">
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
        
                    $.post('ServletUser',{mail: email},function(responseText) { 
                        //var error = responseText.valido;
                        alert(responseText);
                        //errorValidacion = true;
                    });
                    
                    
                    
                    if (errorValidacion == true) {return false;}
                    
                });
                
                $("#celular").mask("(999) 999-9999",{placeholder: " "});
                $("#telf").mask("999-99-99",{placeholder: " "});
                
            });
        
            function cancelar1() {
                window.location="index.jsp";
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
                        <td>* Nombre: </td>
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
                        <td>* E-Mail: </td>
                        <td><input type="text" id="jmail" name="email" id="email"></td>
                    </tr>
                    <tr>
                        <td>* Numero de Tarjeta: </td>
                        <td><input type="text" name="tarjeta"></td>
                    </tr>
                    <tr>
                        <td>* Codigo de Seguridad: </td>
                        <td><input type="text" name="codigo"></td>
                    </tr>
                                        <tr>
                        <td>* Fecha Caducidad: </td>
                        <td><input type="date" name="fechaV"></td>
                    </tr>

                </table><br>
                <table border="1">
                    <tr>
                        <td width="147">* USER:</td>
                        <td width="140"><input type="text" id="user" name="user"></td>
                    </tr>
                    <tr>
                        <td>* PASSWORD:</td>
                        <td><input type="password" id="pass" name="password"></td>
                    </tr>
                    <!--
                    <tr><td>TIPO: 
                        </td>
                        <td><SELECT NAME="combo" SIZE=1> 
                                <option value="#">:: Seleccione ::</option>
                                <OPTION VALUE="1">Administrador</OPTION>
                                <OPTION VALUE="2">Usuario</OPTION>
                            </SELECT></td>
                    </tr>
                    -->

                </table>

                <table border="1">
                    <br>
                    <tr align="center">
                    <input type="submit" id="btn-submit" name="guardar" value="Guardar">

                    <input type="button" name="cancelar" value="Cancelar" onclick="cancelar1();">
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>
