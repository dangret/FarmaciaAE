/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Usuario;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Local;
import javax.ejb.Remote;

/**
 *
 * @author sears
 */
@Remote
public interface EJBUsuariosRemote {

    public Usuario obtenerUsuario(String usuario, String pwd);

    public List<Usuario> consultaGeneral();

    public int alta(Usuario u);

    public int modificar(Usuario p);

    public Usuario consultaPorNombre(String login);

    public int eliminarPorId(int idpersona);

    public int eliminarEntidad(Usuario usr);

    public Usuario consultaPorId(int idusuario);
}
