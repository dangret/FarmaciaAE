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
    @PersistenceContext
    private EntityManager em;
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Override
    public int altaTipo(CatTiposusuario tipo) {
        try {
            em.merge(tipo);
        } catch(Exception e) {
            e.printStackTrace();
            return -1;
        }
        return 0;
    }

}
