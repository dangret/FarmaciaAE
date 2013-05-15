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
        try{
           em = emf.createEntityManager();
           return em.createNamedQuery("Producto.findAll")
                   .getResultList();
        }catch (Exception e){
            return null;
        }
    }

    
    @Override
    public int productoBaja(Producto p) {
        try{
            em = emf.createEntityManager();
            em.remove(em.merge(p));
            return 1;
        }catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }

    @Override
    public int ProductoGuardar(Producto p) {
        try{
            em = emf.createEntityManager();
            em.merge(p);
            return 1;
        }catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")

    @Override
    public Producto productoObtenerPorID(int id) {
         try{
            em = emf.createEntityManager();
            
            return (Producto) em.createNamedQuery("Producto.findByIdproducto")
                    .setParameter("idproducto", id)
                    .getSingleResult();
        }catch(Exception e){
            return null;
        }
    }

}
