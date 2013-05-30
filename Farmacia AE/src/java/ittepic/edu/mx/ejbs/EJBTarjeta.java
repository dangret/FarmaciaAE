/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Numtarjeta;
import ittepic.edu.mx.entidades.Usuario;
import java.util.List;
import javax.ejb.Remote;
import javax.ejb.Stateful;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceUnit;

/**
 *
 * @author sears
 */
@Stateful
@Remote (EJBTarjetaLocal.class)

public class EJBTarjeta implements EJBTarjetaLocal {
    @PersistenceContext
    private EntityManager em;
    @PersistenceUnit
    private EntityManagerFactory emf;
    
    @Override
    public Numtarjeta buscarPorId(int idcliente) {
        em = emf.createEntityManager();
        return (Numtarjeta)em.createNamedQuery("Numtarjeta.findByIdCliente").setParameter("idcliente",idcliente ).getSingleResult();
    }

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")

    @Override
    public int alta(Numtarjeta n) {
        try {
            em = emf.createEntityManager();
            em.persist(n);
        } catch(Exception e) {
            e.printStackTrace();
            return -1;
        }
        return 0;
    }

}
