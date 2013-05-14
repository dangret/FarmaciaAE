/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.entidades;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author sears
 */
@Entity
@Table(name = "detalleventa")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Detalleventa.findAll", query = "SELECT d FROM Detalleventa d"),
    @NamedQuery(name = "Detalleventa.findByIddetalleventa", query = "SELECT d FROM Detalleventa d WHERE d.iddetalleventa = :iddetalleventa"),
    @NamedQuery(name = "Detalleventa.findByCantidad", query = "SELECT d FROM Detalleventa d WHERE d.cantidad = :cantidad"),
    @NamedQuery(name = "Detalleventa.findByHora", query = "SELECT d FROM Detalleventa d WHERE d.hora = :hora"),
    @NamedQuery(name = "Detalleventa.findByFechadetalleventa", query = "SELECT d FROM Detalleventa d WHERE d.fechadetalleventa = :fechadetalleventa")})
public class Detalleventa implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator="detalleventa_iddetalleventa_seq")
    @SequenceGenerator(name="detalleventa_iddetalleventa_seq", allocationSize=1)
    @Basic(optional = false)
    @Column(name = "iddetalleventa")
    private Integer iddetalleventa;
    @Column(name = "cantidad")
    private Short cantidad;
    @Column(name = "hora")
    @Temporal(TemporalType.TIME)
    private Date hora;
    @Column(name = "fechadetalleventa")
    @Temporal(TemporalType.DATE)
    private Date fechadetalleventa;
    @JoinColumn(name = "idusuario", referencedColumnName = "idusuario")
    @ManyToOne(optional = false)
    private Usuario idusuario;
    @JoinColumn(name = "idproducto", referencedColumnName = "idproducto")
    @ManyToOne(optional = false)
    private Producto idproducto;

    public Detalleventa() {
    }

    public Detalleventa(Integer iddetalleventa) {
        this.iddetalleventa = iddetalleventa;
    }

    public Integer getIddetalleventa() {
        return iddetalleventa;
    }

    public void setIddetalleventa(Integer iddetalleventa) {
        this.iddetalleventa = iddetalleventa;
    }

    public Short getCantidad() {
        return cantidad;
    }

    public void setCantidad(Short cantidad) {
        this.cantidad = cantidad;
    }

    public Date getHora() {
        return hora;
    }

    public void setHora(Date hora) {
        this.hora = hora;
    }

    public Date getFechadetalleventa() {
        return fechadetalleventa;
    }

    public void setFechadetalleventa(Date fechadetalleventa) {
        this.fechadetalleventa = fechadetalleventa;
    }

    public Usuario getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(Usuario idusuario) {
        this.idusuario = idusuario;
    }

    public Producto getIdproducto() {
        return idproducto;
    }

    public void setIdproducto(Producto idproducto) {
        this.idproducto = idproducto;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iddetalleventa != null ? iddetalleventa.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Detalleventa)) {
            return false;
        }
        Detalleventa other = (Detalleventa) object;
        if ((this.iddetalleventa == null && other.iddetalleventa != null) || (this.iddetalleventa != null && !this.iddetalleventa.equals(other.iddetalleventa))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ittepic.edu.mx.ejbs.Detalleventa[ iddetalleventa=" + iddetalleventa + " ]";
    }
    
}
