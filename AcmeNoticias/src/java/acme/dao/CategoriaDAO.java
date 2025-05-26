package acme.dao;

import acme.model.Categoria;
import jakarta.ejb.Stateless;
import jakarta.persistence.TypedQuery;
import java.util.List;

@Stateless
public class CategoriaDAO extends BaseDAO<Categoria>{

    private TypedQuery<Categoria> query;
    
    @Override
    public Categoria find(long id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean persist(Categoria entidad) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean remove(Categoria entidad) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean merge(Categoria entidad) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    public List<Categoria> findAll(){
        query = em.createNamedQuery("Categoria.findAll", Categoria.class);
        return query.getResultList();
    }
}
