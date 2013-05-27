/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Pedido;
import java.util.List;
import javax.ejb.Remote;

/**
 *
 * @author dangret
 */
@Remote
public interface EJBPedidoRemote {
    public List<Pedido> obtenerPedidos();
    public Pedido obtenerPorID(int id);
    public int guardarPedido(Pedido p);
}
