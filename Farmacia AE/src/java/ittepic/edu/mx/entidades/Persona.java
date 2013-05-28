/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.entidades;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author sears
 */
@Entity
@Table(name = "persona")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Persona.findAll", query = "SELECT p FROM Persona p order by p.idcliente"),
    @NamedQuery(name = "Persona.findByIdcliente", query = "SELECT p FROM Persona p WHERE p.idcliente = :idcliente"),
    @NamedQuery(name = "Persona.findByNombre", query = "SELECT p FROM Persona p WHERE p.nombre = :nombre"),
    @NamedQuery(name = "Persona.findByAppat", query = "SELECT p FROM Persona p WHERE p.appat = :appat"),
    @NamedQuery(name = "Persona.findByApmat", query = "SELECT p FROM Persona p WHERE p.apmat = :apmat"),
    @NamedQuery(name = "Persona.findByFechnac", query = "SELECT p FROM Persona p WHERE p.fechnac = :fechnac"),
    @NamedQuery(name = "Persona.findByTelefono", query = "SELECT p FROM Persona p WHERE p.telefono = :telefono"),
    @NamedQuery(name = "Persona.findByDireccion", query = "SELECT p FROM Persona p WHERE p.direccion = :direccion"),
    @NamedQuery(name = "Persona.findByCelular", query = "SELECT p FROM Persona p WHERE p.celular = :celular"),
    @NamedQuery(name = "Persona.findByEmail", query = "SELECT p FROM Persona p WHERE p.email = :email"),
    @NamedQuery(name = "Persona.eliminar", query = "DELETE FROM Persona p WHERE p.idcliente = :idcliente")})
public class Persona implements Serializable {
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idcliente", fetch = FetchType.LAZY)
    private List<Numtarjeta> numtarjetaList;
    @OneToMany(mappedBy = "idcliente", fetch = FetchType.LAZY)
    private List<Usuario> usuarioList;
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "persona_idcliente_seq")
    @SequenceGenerator(name = "persona_idcliente_seq", allocationSize = 1)
    @Basic(optional = false)
    @Column(name = "idcliente")
    private Integer idcliente;
    @Size(max = 2147483647)
    @Column(name = "nombre")
    private String nombre;
    @Size(max = 2147483647)
    @Column(name = "rfc")
    private String rfc;
    @Size(max = 2147483647)
    @Column(name = "appat")
    private String appat;
    @Size(max = 2147483647)
    @Column(name = "apmat")
    private String apmat;
    @Column(name = "fechnac")
    @Temporal(TemporalType.DATE)
    private Date fechnac;
    @Size(max = 2147483647)
    @Column(name = "telefono")
    private String telefono;
    @Size(max = 2147483647)
    @Column(name = "direccion")
    private String direccion;
    @Size(max = 2147483647)
    @Column(name = "celular")
    private String celular;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "email")
    private String email;

    public Persona() {
    }

    public Persona(Integer idcliente) {
        this.idcliente = idcliente;
    }

    public Persona(Integer idcliente, String email) {
        this.idcliente = idcliente;
        this.email = email;
    }

    public Integer getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(Integer idcliente) {
        this.idcliente = idcliente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getAppat() {
        return appat;
    }

    public void setAppat(String appat) {
        this.appat = appat;
    }

    public String getApmat() {
        return apmat;
    }

    public void setApmat(String apmat) {
        this.apmat = apmat;
    }

    public Date getFechnac() {
        return fechnac;
    }

    public void setFechnac(Date fechnac) {
        this.fechnac = fechnac;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idcliente != null ? idcliente.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Persona)) {
            return false;
        }
        Persona other = (Persona) object;
        if ((this.idcliente == null && other.idcliente != null) || (this.idcliente != null && !this.idcliente.equals(other.idcliente))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ittepic.edu.mx.entidades.Persona[ idcliente=" + idcliente + " ]";
    }

    @XmlTransient
    public List<Numtarjeta> getNumtarjetaList() {
        return numtarjetaList;
    }

    public void setNumtarjetaList(List<Numtarjeta> numtarjetaList) {
        this.numtarjetaList = numtarjetaList;
    }

    @XmlTransient
    public List<Usuario> getUsuarioList() {
        return usuarioList;
    }

    public void setUsuarioList(List<Usuario> usuarioList) {
        this.usuarioList = usuarioList;
    }
    
}
