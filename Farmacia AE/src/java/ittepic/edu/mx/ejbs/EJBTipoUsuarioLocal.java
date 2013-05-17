/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.CatTiposusuario;
import javax.ejb.Local;
import javax.ejb.Remote;

/**
 *
 * @author sears
 */
@Remote
public interface EJBTipoUsuarioLocal {
    public int altaTipo(CatTiposusuario tipo);
    public CatTiposusuario obtenerPorID(int id);
    public int eliminarTipo(int tipousuario);
}
