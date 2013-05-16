/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.servlets;

import ittepic.edu.mx.ejbs.EJBProductosRemote;
import ittepic.edu.mx.entidades.Producto;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        response.setContentType("text/html;charset=UTF-8");
        
        
        String producto = request.getParameter("txtProducto");
        String [] listBorrar = request.getParameterValues("chkBorrar");
        
        if (producto != null){ 
           if (!producto.equals("")){
                
            short cantidad = 0;
            double precio = 0;
            Integer id = null;
            String imagen = null;
            
            try{
                cantidad = Short.parseShort(request.getParameter("txtCantidad"));
                precio = Double.parseDouble(request.getParameter("txtPrecio"));
                id = (Integer) request.getSession().getAttribute("idproducto");
                imagen = request.getParameter("txtImagen");
            }catch (Exception e){
                e.printStackTrace();
            }
            
            //Aqui guardar
            Producto p = new Producto ();
            
            p.setProducto(producto);
            if (id != null) p.setIdproducto(id);
            p.setCantidad(cantidad);
            p.setPrecio(precio);
            
            if ( ejb.ProductoGuardar(p) == 1 ){}     //bien
            else{}                         
           }//mal
        }
        
        
        if (listBorrar != null){
            //Aqui borrar
            int idproducto;
            Producto p = new Producto ();
            for (int i=0; i<listBorrar.length; i++){
                idproducto = Integer.parseInt(listBorrar[i]);
                p = ejb.productoObtenerPorID(idproducto);
                if ( ejb.productoBaja(p) == 1 ){}     //bien
                else{}                  
            }
            
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
