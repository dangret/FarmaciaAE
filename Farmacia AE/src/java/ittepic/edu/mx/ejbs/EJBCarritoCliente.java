/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Detalleventa;
import ittepic.edu.mx.entidades.Pedido;
import ittepic.edu.mx.entidades.Producto;
import ittepic.edu.mx.entidades.Usuario;
import ittepic.edu.mx.entidades.Venta;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.Remote;
import javax.ejb.Remove;
import javax.ejb.Stateful;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceUnit;

/**
 *
 * @author JESUS
 */
@Stateful
@Remote (EJBCarritoClienteLocal.class)
public class EJBCarritoCliente implements EJBCarritoClienteLocal {

    @PersistenceUnit
    public  EntityManagerFactory emf;
    @PersistenceContext
    EntityManager em;
    private List<Usuario> usuarios = null;
    private List<Producto> medicamentos = null;// lista todas las medicinas.
    private List<Producto> pedido = null;//
    private List cantidades = null;// almacenar cuantas medicinas pide de cada una lista sin tipo de objetos.
    private List<Venta> ventas = null;
    private List<Detalleventa> detalleventa = null;
    
    /**
     * Establece los valores iniciales de los ArrayList que se utilizaran posteriormente
     */
    @PostConstruct
    @Override
    public void inicializar() {
        pedido = new ArrayList();// Lista que tambien esta vacia.
        cantidades = new ArrayList();// lista vacia.
        medicamentos = em.createNamedQuery("Producto.findAll").getResultList();// lista de todas las medicinas
        ventas = em.createNamedQuery("Venta.findAll").getResultList();
        detalleventa = em.createNamedQuery("Detalleventa.findAll").getResultList();
        usuarios = em.createNamedQuery("Usuario.findAll").getResultList();
    }
    
    /**
     * Obtiene la lista de medicamentos existentes.
     * @return 
     */
    @Override
    public List<Producto> getMedicamentos() {
        return medicamentos;
    }
    
    /**
     * Recibe un parametro de tipo entero (la clave del medicamento) mediante el cual elimina un medicamento de la lista de 
     * pedido del cliente. Retorna la lista de pedido actualizada sin dicho medicamento.
     * @param index
     * @return 
     */
    @Override
    public List<Producto> removerMedicamento(int index) {
        pedido.remove(index);
        cantidades.remove(index);
        return pedido;
    }

    /**
     * Agrega un medicamento a la lista de pedido del cliente. Recibe 2 parametros de tipo enteros; el primero se encarga de
     * recibir la clave del medicamento a agregar y el segundo la cantidad de dicho medicamento que pidio el cliente.
     * Retorna la lista de pedido del cliente con el medicamento agregado y su respectiva cantidad.
     * NOTA: En caso de que el medicamento ya exista en la lista del pedido, solamente agrega y actualiza la cantidad que se 
     *       esta pidiendo de dicho medicamento.
     * @param idproducto
     * @param cantidad
     * @return 
     */
    @Override
    public List<Producto> agregar(int idproducto, int cantidad) {
        try {
            Producto p = getMedicamentoById(idproducto);
            int iobjeto = pedido.indexOf(p);// iobjeto regresa la pocision del valor del infice y sino lo encuentra regresara un -1.
            if(iobjeto!=-1) {
                int cantant = Integer.parseInt(cantidades.get(iobjeto).toString()); //                   
                cantidades.set(iobjeto, cantant+cantidad);
            } else {
                cantidades.add(cantidad);// agrega la cantidad. 
                pedido.add(p);
            }
            
        } catch (Exception e) {
        }
        return pedido;
    }

    /**
     * Recibe un parametro que es la clave del medicamento, y en base a ella realiza una busqueda entre los productos existentes.
     * Retorna un objeto de tipo Producto con los atributos de dicho medicamento.
     * @param idproducto
     * @return 
     */
    @Override
    public Producto getMedicamentoById(int idproducto) {
        return (Producto) em.createNamedQuery("Producto.findByIdproducto").setParameter("idproducto", idproducto).getSingleResult();
    }

    /**
     * Obtiene la lista del pedido actual del cliente
     * @return 
     */
    @Override
    public List<Producto> getPedido() {
        return pedido;
    }

    /**
     * Obtiene la lista de cantidades de los medicamentos en existencia.
     * @return 
     */
    @Override
    public List getCantidades() {
        return cantidades;
    }

    /**
     * Obtiene la lista de todas las ventas realizadas por la farmacia
     * @return 
     */
    
    @Override
    public List<Venta> getVentas() {
        return ventas; 
    }

    /**
     * Obtiene la lista de todos los detalles de todas las ventas realizadas.
     * @return 
     */
    @Override
    public List<Detalleventa> getDetalleventa() {
        return detalleventa;
    }

    /**
     * Obtiene la lista de todos los usuarios existentes.
     * @return 
     */
    @Override
    public List<Usuario> getUsuarios() {
        return usuarios;
    }

    /**
     * Recibe de parametro un objeto de tipo Venta y registra una nueva venta; retorna dicha venta para procesos poteriores.
     * @param v
     * @return 
     */
    @Override
    public Venta registrarVenta(Venta v) {
        em.persist(v);
        return v;
    }

    /**
     * Recibe de parametro un objeto de tipo Detalleventa y registra los medicamentos y sus respectivas cantidades de la venta realizada.
     * Retorna dicho detalle para procesos posteriores
     * @param dv
     * @return 
     */
    @Override
    public Detalleventa registrarDetalleVenta(Detalleventa dv) {
        em.persist(dv);
        return dv;
    }

    /**
     * Recibe un parametro de un objeto de tipo Pedido. Solamente se utiliza esta funcion en caso de que se pida una cantidad
     * mayor de medicamento que la que se tiene en existencia. Se pone a 0 la existencia de productos y se agrega la diferencia
     * a pedidos para posteriormente mandar pedir mas producto a los proveedores.
     * @param pe 
     */
    @Override
    public void registrarPedido(Pedido pe) {
        em.merge(pe);
    }

    /**
     * Recibe un parametro de tipo Producto en el cual disminuye y actualiza la cantidad de medicamento en base a los medicamentos
     * que se hayan realizado en la lista de pedido del cliente.
     * @param p 
     */
    @Override
    public void actualizarStock(Producto p) {
        em.merge(p);
    }

}
