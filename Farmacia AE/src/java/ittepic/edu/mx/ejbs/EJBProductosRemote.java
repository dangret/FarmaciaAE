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
    public int productoAlta(Producto p);
    public int productoBaja(Producto p);
    public int ProductoModificar(Producto p);
    public Producto productoObtenerPorID(long id);
    
}
