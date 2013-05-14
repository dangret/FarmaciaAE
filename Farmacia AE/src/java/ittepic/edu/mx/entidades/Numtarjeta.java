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
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author sears
 */
@Entity
@Table(name = "numtarjeta")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Numtarjeta.findAll", query = "SELECT n FROM Numtarjeta n"),
    @NamedQuery(name = "Numtarjeta.findByNotarjeta", query = "SELECT n FROM Numtarjeta n WHERE n.notarjeta = :notarjeta"),
    @NamedQuery(name = "Numtarjeta.findByCodigoseguridad", query = "SELECT n FROM Numtarjeta n WHERE n.codigoseguridad = :codigoseguridad"),
    @NamedQuery(name = "Numtarjeta.findByFechacaducidad", query = "SELECT n FROM Numtarjeta n WHERE n.fechacaducidad = :fechacaducidad")})
public class Numtarjeta implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 18)
    @Column(name = "notarjeta")
    private String notarjeta;
    @Column(name = "codigoseguridad")
    private Integer codigoseguridad;
    @Column(name = "fechacaducidad")
    @Temporal(TemporalType.DATE)
    private Date fechacaducidad;
    @JoinColumn(name = "idcliente", referencedColumnName = "idcliente")
    @ManyToOne(optional = false)
    private Persona idcliente;

    public Numtarjeta() {
    }

    public Numtarjeta(String notarjeta) {
        this.notarjeta = notarjeta;
    }

    public String getNotarjeta() {
        return notarjeta;
    }

    public void setNotarjeta(String notarjeta) {
        this.notarjeta = notarjeta;
    }

    public Integer getCodigoseguridad() {
        return codigoseguridad;
    }

    public void setCodigoseguridad(Integer codigoseguridad) {
        this.codigoseguridad = codigoseguridad;
    }

    public Date getFechacaducidad() {
        return fechacaducidad;
    }

    public void setFechacaducidad(Date fechacaducidad) {
        this.fechacaducidad = fechacaducidad;
    }

    public Persona getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(Persona idcliente) {
        this.idcliente = idcliente;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (notarjeta != null ? notarjeta.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Numtarjeta)) {
            return false;
        }
        Numtarjeta other = (Numtarjeta) object;
        if ((this.notarjeta == null && other.notarjeta != null) || (this.notarjeta != null && !this.notarjeta.equals(other.notarjeta))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ittepic.edu.mx.ejbs.Numtarjeta[ notarjeta=" + notarjeta + " ]";
    }
    
}
