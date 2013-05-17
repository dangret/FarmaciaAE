/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Producto;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.ejb.Local;
import javax.ejb.Remote;
import javax.ejb.Remove;

/**
 *
 * @author JESUS
 */
@Remote
public interface EJBCarritoClienteLocal {
    @PostConstruct
    public void inicializar();
    List<Producto> getMedicamentos();
    List<Producto> removerMedicamento(int index) ;
    List<Producto> agregar(int idproducto, int cantidad);
    Producto getMedicamentoById(int idproducto);
    List<Producto> getPedido();
    List getCantidades();
    @Remove
    public void terminarPedido();
    @PreDestroy
    public void liberarObjetos();
}
