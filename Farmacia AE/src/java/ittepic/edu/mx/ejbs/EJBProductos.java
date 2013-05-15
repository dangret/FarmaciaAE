/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Producto;
import java.util.List;
import javax.ejb.Remote;
import javax.ejb.Stateful;

/**
 *
 * @author Daniel
 */
@Stateful
@Remote(EJBProductosRemote.class)
public class EJBProductos implements EJBProductosRemote {

    @Override
    public List<Producto> productoObtenerTodos() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int productoAlta(Producto p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int productoBaja(Producto p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int ProductoModificar(Producto p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")

}
