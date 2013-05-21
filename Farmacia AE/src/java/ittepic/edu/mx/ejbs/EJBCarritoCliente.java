/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.ejbs;

import ittepic.edu.mx.entidades.Detalleventa;
import ittepic.edu.mx.entidades.Pedido;
import ittepic.edu.mx.entidades.Producto;
import ittepic.edu.mx.entidades.Usuario;
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
    private List<Producto> medicamentos = null;// lista todas las medicinas.
    private List<Usuario> usuarios = null; //Lista todos los usuarios
    private List<Producto> pedido = null;//
    private List cantidades = null;// almacenar cuantas medicinas pide de cada una lista sin tipo de objetos.
    
    @PostConstruct
    @Override
    public void inicializar() {
         //throw new UnsupportedOperationException("Not supported yet.");
        pedido = new ArrayList();// Lista que tambien esta vacia.
        cantidades = new ArrayList();// lista vacia.
        medicamentos = em.createNamedQuery("Producto.findAll").getResultList();// lista de todas las medicinas 
        usuarios = em.createNamedQuery("Usuario.findAll").getResultList();
    }

    @Override
    public List<Producto> getMedicamentos() {
        return medicamentos;
    }

    @Override
    public List<Producto> removerMedicamento(int index) {
        pedido.remove(index);
        cantidades.remove(index);
        return pedido;
    }

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

    @Override
    public Producto getMedicamentoById(int idproducto) {
        return (Producto) em.createNamedQuery("Producto.findByIdproducto").setParameter("idproducto", idproducto).getSingleResult();
    }

    @Override
    public List<Producto> getPedido() {
        return pedido;
    }

    @Override
    public List getCantidades() {
        return cantidades;
    }

    @Remove
    @Override
    public void terminarPedido() {
        
       
        for(int i=0; i<pedido.size(); i++) {
            
            int index = medicamentos.indexOf(medicamentos.get(i));
            Producto p = medicamentos.get(index);
            p.setCantidad((Short.valueOf(String.valueOf(p.getCantidad()-Short.parseShort(cantidades.get(i).toString())))));
            //p.setCantidad(Short.valueOf(String.valueOf(p.getCantidad()-Short.parseShort(cantidades.get(i).toString()))));
            em.merge(p); //Actualiza la cantidad en productos
            
            Detalleventa dv = new Detalleventa();
            dv.setIdproducto(p);
            dv.setIdusuario(usuarios.get(0));
            dv.setCantidad(Short.parseShort(String.valueOf(Integer.parseInt(cantidades.get(i).toString()))));
            dv.setHora(new Date());
            dv.setFechadetalleventa(new Date());
            em.persist(dv); //Guarda en la tabla detalleventa                           
         }
    }

    @Override
    public void liberarObjetos() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")

}
