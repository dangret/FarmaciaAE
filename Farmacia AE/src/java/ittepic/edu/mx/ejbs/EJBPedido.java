/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Pedido;
import java.util.List;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceUnit;

/**
 *
 * @author dangret
 */
@Stateless
@Remote(EJBPedidoRemote.class)
public class EJBPedido implements EJBPedidoRemote {
    
    @PersistenceUnit
    public  EntityManagerFactory emf;
    @PersistenceContext
    EntityManager em;
    
    @Override
    public List<Pedido> obtenerPedidos(){
        try{
            em = emf.createEntityManager();
            return em.createQuery("Select p From Pedido p Where p.estado = 1")
                    .getResultList();
        }catch(Exception e){ 
            e.printStackTrace();
            return null;
        }
    }
    
    @Override
    public Pedido obtenerPorID(int id){
        try{
            em = emf.createEntityManager();
            return (Pedido) em.createNamedQuery("Pedido.findByIdpedido")
                    .setParameter("idpedido", id)
                    .getSingleResult();
                    
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
        
    }

    @Override
    public int guardarPedido(Pedido p) {
        try{
            em = emf.createEntityManager();
            em.merge(p);
            return 1; 
        }catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }

}
