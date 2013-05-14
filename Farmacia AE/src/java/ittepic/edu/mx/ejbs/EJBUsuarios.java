/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Usuario;
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
@Remote (EJBUsuariosRemote.class)
public class EJBUsuarios implements EJBUsuariosRemote {
    
    @PersistenceContext
    private EntityManager em;
    
    @PersistenceUnit
    private EntityManagerFactory emf;
    
    
    @Override
    public Usuario obtenerUsuario(String usuario, String pwd) {
        Usuario user = null;
       em=emf.createEntityManager();
        try{
            return (Usuario)em.createQuery("select u from Usuario u where u.login=:login and u.password:=password")
                    .setParameter("login", usuario).setParameter("password", pwd)
                    .getResultList();
        }catch (Exception e){
            return null;
        }
    }

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")

}
