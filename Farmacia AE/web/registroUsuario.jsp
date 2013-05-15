<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="ittepic.edu.mx.entidades.Persona"%>
<%@page import="beans.usuario"%>
<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBUsuariosRemote"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!    EJBUsuariosRemote ejb = null;

    public void jspInit() {
        try {
            InitialContext ic = new InitialContext();
            ejb = (EJBUsuariosRemote) ic.lookup(EJBUsuariosRemote.class.getName());
            System.out.println("Bean cargado");
        } catch (Exception ex) {
            System.out.println("Error:"
                    + ex.getMessage());
        }
    }
%>
<%
    String nombre = request.getParameter("nombre") == null ? "" : request.getParameter("nombre");
    Usuario usr;
    Persona per;

    if (!nombre.equals("")) {
        System.out.println("entro3");
        String apepat = request.getParameter("apepat");
        String apemat = request.getParameter("apemat");
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        Date fecnac = format.parse(request.getParameter("fecnac"));
        String telf = request.getParameter("telf");
        String celular = request.getParameter("celular");
        String direccion = request.getParameter("direccion");
        String email = request.getParameter("email");
        String user = request.getParameter("user");
        String password = request.getParameter("password");

        per = new Persona();
        per.setNombre(nombre);
        per.setAppat(apepat);
        per.setApmat(apemat);
        per.setFechnac(fecnac);
        per.setTelefono(telf);
        per.setCelular(celular);
        per.setDireccion(direccion);
        per.setEmail(email);

        usr = new Usuario();

    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta de alumnos</title>
    </head>
    <body>
        <div align="center">
            <H2>REGISTRO DE USUARIOS</H1>
        </div>

        <form name="formulario" action="consultaGeneral.jsp" method="POST">
            <script>
                function cancelar1() {
                    window.location="index.jsp";
                }
                
        function validar(){
            valor=document.formu.combo.value;
            if(valor=='#') 
                alert('valor invalido') 
            else if(valor==1)
                <%System.out.println("Selecciono 1");%>
                else if(valor==2)
                <%System.out.println("Selecciono 2");%>
                                            }
            </script>
            <div align="center">
                <table border="1">
                    <tr>
                        <th colspan="2">INFORMACION GENERAL DEL USUARIO</th>
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
                        <td>   <textarea name="direccion" cols="50" rows="2"></textarea></td>
                        </td>
                    </tr>
                    <tr>
                        <td>E-Mail: </td>
                        <td><input type="text" name="email" id="email"></td>
                    </tr>

                </table><br>
                <table border="1">
                    <tr>
                        <td>USER:</td>
                        <td><input type="text" name="user"></td>
                    </tr>
                    <tr>
                        <td>PASSWORD:</td>
                        <td><input type="password" name="password"></td>
                        <td><form method="POST" name="formu" ">
                            TIPO: <SELECT NAME="combo" SIZE=1 onclick="validar();"> 
                                <option value="#">:: Seleccione ::</option> 
                                <OPTION VALUE="1">Administrador</OPTION>
                                <OPTION VALUE="2">Usuario</OPTION>
                            </SELECT> 
                            </form>
                        </td>
                    </tr>

                </table>

                <table border="1">
                    <br>
                    <tr>
                    <input type="submit" name="guardar" value="Guardar">
                    </tr>
                    <tr>
                    <input type="button" name="cancelar" value="Cancelar" onclick="cancelar1();">
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>
