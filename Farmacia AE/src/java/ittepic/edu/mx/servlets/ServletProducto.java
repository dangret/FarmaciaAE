/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.servlets;

import ittepic.edu.mx.ejbs.EJBProductosRemote;
import ittepic.edu.mx.entidades.Producto;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.jstl.core.Config;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author dangret
 */
public class ServletProducto extends HttpServlet {
    
    @EJB
    EJBProductosRemote ejb;
    
    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
         /*FileItemFactory es una interfaz para crear FileItem*/
        FileItemFactory file_factory = new DiskFileItemFactory();

        /*ServletFileUpload esta clase convierte los input file a FileItem*/
        ServletFileUpload servlet_up = new ServletFileUpload(file_factory);
        /*sacando los FileItem del ServletFileUpload en una lista */
        List<FileItem> items = new ArrayList<FileItem>();
        try {
            items = servlet_up.parseRequest(request);
        } catch (FileUploadException ex) {
            Logger.getLogger(ServletProducto.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        String [] listBorrar = request.getParameterValues("chkBorrar");
        
        Producto p = new Producto ();
        
        if (listBorrar != null){
            //Aqui borrar
            int idproducto;
            p = new Producto ();
            for (int i=0; i<listBorrar.length; i++){
                idproducto = Integer.parseInt(listBorrar[i]);
                p = ejb.productoObtenerPorID(idproducto);
                if ( ejb.productoBaja(p) == 1 ){}     //bien
                else{}                  
            }
            
        }else{
            String producto = "";
            short cantidad = 0;
            double precio = 0;
            Integer id = null;
            String imagen = null;

            try{
                id = (Integer) request.getSession().getAttribute("idproducto");
            }catch (Exception e){
                e.printStackTrace();
            }


            String archivo_path = "";
            for(FileItem item : items){
                /*FileItem representa un archivo en memoria que puede ser pasado al disco duro*/
                /*item.isFormField() false=input file; true=text field*/

                if (!item.isFormField()){
                    /*cual sera la ruta al archivo en el servidor*/
                    archivo_path = "imagenesProductos/" + item.getName();
                    File archivo_server = new File(getServletContext().getRealPath("/") + archivo_path );
                    try {
                        /*y lo escribimos en el servido*/
                        item.write(archivo_server);
                    } catch (Exception ex) {
                        Logger.getLogger(ServletProducto.class.getName()).log(Level.SEVERE, null, ex);
                    }

                }else{
                    if (item.getFieldName().equals("txtProducto")){
                        producto = item.getString().toUpperCase();
                    }
                    if (item.getFieldName().equals("txtCantidad")){
                        cantidad = Short.parseShort(item.getString());
                    }
                    if (item.getFieldName().equals("txtPrecio")){
                        precio = Double.parseDouble(item.getString());
                    }
                }
            }

            p.setProducto(producto);
            if (id != null) p.setIdproducto(id);
            p.setCantidad(cantidad);
            p.setPrecio(precio);
            p.setRuta(archivo_path);


            if ( ejb.ProductoGuardar(p) == 1 ){}     //bien
            else{}                         




        }
        
        response.sendRedirect("wpProductoConsulta.jsp");
        
        //Borar todos los parametros y atributos
        
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
