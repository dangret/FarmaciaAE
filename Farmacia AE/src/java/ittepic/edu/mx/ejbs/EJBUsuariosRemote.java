/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Usuario;
import javax.ejb.Local;
import javax.ejb.Remote;

/**
 *
 * @author sears
 */
@Remote
public interface EJBUsuariosRemote {
    public Usuario obtenerUsuario (String usuario, String pwd); 
}
