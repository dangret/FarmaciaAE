/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Producto;
import java.util.List;
import javax.ejb.Remote;

/**
 *
 * @author Daniel
 */
@Remote
public interface EJBProductosRemote {
    public List<Producto> productoObtenerTodos();
    public int productoBaja(Producto p);
    public int ProductoGuardar(Producto p);
    public Producto productoObtenerPorID(int id);
    
}
