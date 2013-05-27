/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ittepic.edu.mx.entidades;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author dangret
 */
@Entity
@Table(name = "cat_tiposusuario")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CatTiposusuario.findAll", query = "SELECT c FROM CatTiposusuario c"),
    @NamedQuery(name = "CatTiposusuario.findByIdtipousuario", query = "SELECT c FROM CatTiposusuario c WHERE c.idtipousuario = :idtipousuario"),
    @NamedQuery(name = "CatTiposusuario.findByDescripcion", query = "SELECT c FROM CatTiposusuario c WHERE c.descripcion = :descripcion")})
public class CatTiposusuario implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idtipousuario")
    private Integer idtipousuario;
    @Size(max = 2147483647)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(mappedBy = "tipousuario", fetch = FetchType.LAZY)
    private List<Usuario> usuarioList;

    public CatTiposusuario() {
    }

    public CatTiposusuario(Integer idtipousuario) {
        this.idtipousuario = idtipousuario;
    }

    public Integer getIdtipousuario() {
        return idtipousuario;
    }

    public void setIdtipousuario(Integer idtipousuario) {
        this.idtipousuario = idtipousuario;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @XmlTransient
    public List<Usuario> getUsuarioList() {
        return usuarioList;
    }

    public void setUsuarioList(List<Usuario> usuarioList) {
        this.usuarioList = usuarioList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idtipousuario != null ? idtipousuario.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CatTiposusuario)) {
            return false;
        }
        CatTiposusuario other = (CatTiposusuario) object;
        if ((this.idtipousuario == null && other.idtipousuario != null) || (this.idtipousuario != null && !this.idtipousuario.equals(other.idtipousuario))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ittepic.edu.mx.entidades.CatTiposusuario[ idtipousuario=" + idtipousuario + " ]";
    }
    
}
