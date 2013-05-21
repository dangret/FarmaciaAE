/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Persona;
import ittepic.edu.mx.entidades.Usuario;
import java.util.ArrayList;
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
@Stateful (name = "EJBUsuarios")
@Remote (EJBUsuariosRemote.class)
public class EJBUsuarios implements EJBUsuariosRemote {
    @PersistenceContext
    private EntityManager em;
    @PersistenceUnit
    private EntityManagerFactory emf;
    
    private List<Usuario> personas = new ArrayList<Usuario>();
    
    
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

    @Override
    public List<Usuario> consultaGeneral() {
        em = emf.createEntityManager();
        return em.createNamedQuery("Usuario.findAll").getResultList();
    }

    @Override
    public int alta(Usuario u) {
        try {
            em = emf.createEntityManager();
            em.merge(u);
        } catch(Exception e) {
            e.printStackTrace();
            return -1;
        }
        return 0;
    }

    @Override
    public int modificar(Usuario u) {
         try {
            em.merge(u);
        } catch(Exception e) {
            e.printStackTrace();
            return -1;
        }
        return 0;
    }

    @Override
    public Usuario consultaPorNombre(String login) {
    em = emf.createEntityManager();
        return (Usuario)em.createNamedQuery("Usuario.findByNombre").setParameter("login",login ).getSingleResult();
    }

    
    @Override
    public int eliminarPorId(int idpersona) {
         try {
            em = emf.createEntityManager();
            em.createNamedQuery("Usuario.eliminar").setParameter("idpersona", idpersona).executeUpdate();
        } catch(Exception e) {
            return -1;
        }
        return 1;
    }

    /**
     *
     * @param usr
     * @return
     */
    @Override
    public int eliminarEntidad(Usuario usr) {
         try {
            em = emf.createEntityManager();
            Persona per=usr.getIdcliente();
            em.remove(em.merge(usr));
            em.remove(em.merge(per));
            return 1;
            //em.createNamedQuery("Usuario.eliminar").setParameter("idpersona", idpersona).executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
            return -1;

        }
      
    }
    

}
