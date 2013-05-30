/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Persona;
import java.util.List;
import javax.ejb.Local;
import javax.ejb.Remote;

/**
 *
 * @author JESUS
 */
@Remote
public interface EJBPersonasLocal {
    public List<Persona> consultaPersonas();
    public int alta_modificacion (Persona p);
    public Persona consultaPorId(int idcliente );
    public int eliminar(int idcliente);
    public boolean buscarPorEMail(String email);
}
