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
   /**
     * Metodo obtener todas las personas del sistema
     * @return List<Persona> Retorna las Personas creadas
     */
    public List<Persona> consultaPersonas() {
        em= emf.createEntityManager();
        return em.createNamedQuery("Persona.findAll").getResultList();
    }

    @Override
   /**
     * Metodo Para dar de alta y Modificar personas
     * @param p Objeto tipo persona seteado
     * @return int Retorna 0 si se dio de alta exitosamente,-1 si fallo 
     */
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
       /**
     * Metodo obtener una persona mediante su id
     * @param idcliente id del cliente para consultar
     * @return int Retorna 0 si se dio de alta exitosamente,-1 si fallo 
     */
    public Persona consultaPorId(int idcliente) {
        em=emf.createEntityManager();
        return (Persona) em.createNamedQuery("Persona.findByIdcliente").setParameter("idcliente", idcliente).getSingleResult();
    }

    @Override
    
           /**
     * Metodo eliminar Personas
     * @param persona Persona obtenida del jsp
     * @return int Retorna 1 si se dio de alta exitosamente,-1 si fallo 
     */
    public int eliminar(Persona persona) {
        try{
            em = emf.createEntityManager();
            em.remove(em.merge(persona));
            return 1;
        }catch(Exception e){
            return -1;
        }
        
    }

   /**
     * Metodo reemplazar 
     * @param list_p Persona obtenidas (Arreglo)
     * @return int Retorna 1 si se dio de alta exitosamente,-1 si fallo 
     */
    @Override
    public void reemplazar(List<Persona> list_p) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    
       /**
     * Metodo para buscar personas mediante su email
     * @param email email de la persona consultada
     * @return Boolean Retorna 1 si se dio de alta exitosamente,-1 si fallo 
     */
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
