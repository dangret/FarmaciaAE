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
@Stateful (name = "EJBUsuarios")
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
            return (Usuario)em.createQuery("select u from Usuario u where u.login like :login and u.password like :password")
                    .setParameter("login", usuario)
                    .setParameter("password", pwd)
                    .getSingleResult();
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")

}
