/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Numtarjeta;
import ittepic.edu.mx.entidades.Usuario;
import java.util.List;
import javax.ejb.Local;
import javax.ejb.Remote;

/**
 *
 * @author sears
 */
@Remote
public interface EJBTarjetaLocal {
    public Numtarjeta buscarPorId(int idcliente);
        public int alta(Numtarjeta n);
}
