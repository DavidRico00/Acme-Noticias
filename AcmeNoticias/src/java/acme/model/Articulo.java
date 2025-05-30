package acme.model;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "Articulos")
@NamedQueries({
    @NamedQuery(name="Articulo.findAll", query="SELECT a FROM Articulo a"),
    @NamedQuery(name="Articulo.findByRedactorID", query="SELECT a FROM Articulo a WHERE a.redactor.id = :id"),
    @NamedQuery(name="Articulo.findByCategoriaID", query="SELECT a FROM Articulo a WHERE a.categoria.id = :id"),
    @NamedQuery(name="Articulo.findByWord", query="SELECT a FROM Articulo a WHERE a.titulo LIKE :buscador"),
    @NamedQuery(name="Articulo.findByWordCategoriaID", query="SELECT a FROM Articulo a WHERE a.titulo LIKE :buscador AND a.categoria.id = :id"),
})
public class Articulo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String titulo, cuerpo, fecha;
    
    // ---- Relaciones ----
    @ManyToOne(fetch = FetchType.LAZY)
    private Redactor redactor;
    @ManyToOne(fetch = FetchType.LAZY)
    private Categoria categoria;
    @OneToMany(mappedBy="articulo", cascade = CascadeType.ALL, orphanRemoval=true)
    private List<Comentario> comentarios;
    
    
    // Constructores
    public Articulo() {
    }

    public Articulo(String titulo, String cuerpo, String fecha, Redactor redactor, Categoria categoria) {
        this.titulo = titulo;
        this.cuerpo = cuerpo;
        this.fecha = fecha;
        this.redactor = redactor;
        this.categoria = categoria;
    }
    
    
    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    public String getTitulo() {
        return this.titulo;
    }

    public void setTitulo(final String titulo) {
        this.titulo = titulo;
    }

    public String getCuerpo() {
        return this.cuerpo;
    }

    public void setCuerpo(final String cuerpo) {
        this.cuerpo = cuerpo;
    }

    public String getFecha() {
        return this.fecha;
    }

    public void setFecha(final String fecha) {
        this.fecha = fecha;
    }

    public Redactor getRedactor() {
        return redactor;
    }

    public void setRedactor(Redactor redactor) {
        this.redactor = redactor;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public List<Comentario> getComentarios() {
        return comentarios;
    }

    public void setComentarios(List<Comentario> comentarios) {
        this.comentarios = comentarios;
    }

    
    // Otros metodos
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Articulo)) {
            return false;
        }
        Articulo other = (Articulo) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }
}
