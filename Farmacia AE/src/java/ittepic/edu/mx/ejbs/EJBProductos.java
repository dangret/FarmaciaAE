/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Producto;
import java.util.List;
import javax.ejb.Remote;
import javax.ejb.Stateful;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceUnit;

/**
 *
 * @author Daniel
 */
@Stateful
@Remote(EJBProductosRemote.class)
public class EJBProductos implements EJBProductosRemote {
    
    @PersistenceContext
    private EntityManager em;
    @PersistenceUnit
    private EntityManagerFactory emf;
    
    
    @Override
    public List<Producto> productoObtenerTodos() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int productoAlta(Producto p) {
        try{
            em = emf.createEntityManager();
            em.getTransaction().begin();
            em.persist(p);
            em.getTransaction().commit();
            em.close();
            return 1;
        }catch(Exception e){
            return -1;
        }
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

    @Override
    public Producto productoObtenerPorID(long id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
