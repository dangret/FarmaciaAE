/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Persona;
import java.util.List;
import javax.ejb.Remote;
import javax.ejb.Stateful;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceUnit;

/**
 *
 * @author JESUS
 */
@Stateful
@Remote (EJBPersonasRemote.class)
public class EJBPersonas implements EJBPersonasRemote {

    @PersistenceContext
    private EntityManager em;
    @PersistenceUnit
    private EntityManagerFactory emf;
    
    
    @Override
    public List<Persona> consultaPersonas() {
        em= emf.createEntityManager();
        return em.createNamedQuery("Persona.findAll").getResultList();
    }

    @Override
    public int alta_modificacion(Persona p) {
        em = emf.createEntityManager();
        try{
            em.merge(p);
        }catch (Exception e){
            return -1;
        }
        return 0;
    }

    @Override
    public Persona consultaPorId(int idcliente) {
        em=emf.createEntityManager();
        return (Persona) em.createNamedQuery("Persona.findByIdcliente").setParameter("idcliente", idcliente).getSingleResult();
    }

    @Override
    public int eliminar(int idcliente) {
        try
        {
         em = emf.createEntityManager();
         
         em.createNamedQuery("Persona.eliminar").setParameter("idcliente", idcliente).executeUpdate();
        }catch(Exception e)
        {
         return -1;
        }
        return 1;
    }

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")

    @Override
    public void reemplazar(List<Persona> list_p) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    
    public Boolean buscarPorEMail(String email){
        Persona persona = null;
        try{
            em = emf.createEntityManager();
            
            persona = (Persona) em.createQuery("Select p FROM Persona p where p.email = :email")
                    .setParameter("email", email)
                    .getSingleResult();
        }catch (Exception e){
            e.printStackTrace();;
            if (persona != null) return true;
            else return false;
        }
        return true;
    }

    

}
