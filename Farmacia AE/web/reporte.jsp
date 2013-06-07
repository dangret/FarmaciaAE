<%-- 
    Document   : reporte
    Created on : 6/06/2013, 03:13:59 AM
    Author     : JESUS
--%>

<%@page import="ittepic.edu.mx.entidades.Usuario"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="ittepic.edu.mx.ejbs.EJBCarritoClienteLocal"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Usuario user = (Usuario) session.getAttribute("usuario") == null ? null : (Usuario) session.getAttribute("usuario");
    boolean userValido = false;
    if (user != null) {
        if (user.getEstado()) //if (user.getTipousuario().getIdtipousuario() == 1)
        {
            userValido = true;
        }
    }

    if (!userValido) {
        response.sendRedirect("index.jsp");
    } else {
        int idventa = request.getParameter("idventa") == null ? 0 : Integer.parseInt(request.getParameter("idventa"));
        try {
            Connection conexion;
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Farmacia", "postgres", "postgres");
            File reportFile = new File(application.getRealPath("reportes/reporteFSC.jasper"));
            Map parameters = new HashMap();
            parameters.put("idventa", idventa);
            byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conexion);

            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream ouputStream = response.getOutputStream();
            ouputStream.write(bytes, 0, bytes.length);
            ouputStream.flush();
            ouputStream.close();
        } catch (Exception e) {
            out.print(e.getCause());
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte</title>
    </head>
    <body>
    <center>

    </center>

</body>
</html>
