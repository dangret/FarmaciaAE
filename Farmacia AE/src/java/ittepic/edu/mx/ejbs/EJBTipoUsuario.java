/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.CatTiposusuario;
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
@Remote(EJBTipoUsuarioLocal.class)
public class EJBTipoUsuario implements EJBTipoUsuarioLocal {
    
    @PersistenceUnit
    private EntityManagerFactory emf;

    @PersistenceContext
    private EntityManager em;
    
    @Override
    public int altaTipo(CatTiposusuario tipo) {
        try {
            em = emf.createEntityManager();
            em.merge(tipo);
        } catch(Exception e) {
            e.printStackTrace();
            return -1;
        }
        return 0;
    }

    @Override
    public CatTiposusuario obtenerPorID(int id) {
        try{
            em = emf.createEntityManager();
            return (CatTiposusuario) em.createNamedQuery("CatTiposusuario.findByIdtipousuario")
                    .setParameter("idtipousuario", id)
                    .getSingleResult();
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }


    @Override
    public int eliminarTipo(int tipousuario) {
          try {
            em = emf.createEntityManager();
            em.createNamedQuery("CatTiposusuario.eliminarPorId").setParameter("idtipousuario", tipousuario).executeUpdate();
        } catch(Exception e) {
            return -1;
        }
        return 1;
    }

}
