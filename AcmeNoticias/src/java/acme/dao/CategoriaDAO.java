package acme.dao;

import acme.model.Categoria;
import jakarta.ejb.Stateless;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.HeuristicMixedException;
import jakarta.transaction.HeuristicRollbackException;
import jakarta.transaction.NotSupportedException;
import jakarta.transaction.RollbackException;
import jakarta.transaction.SystemException;
import java.util.List;

@Stateless
public class CategoriaDAO extends BaseDAO<Categoria>{

    private TypedQuery<Categoria> query;
    
    @Override
    public Categoria find(long id) {
        return em.find(Categoria.class, id);
    }

    @Override
    public boolean persist(Categoria entidad) {
        try {
            utx.begin();
            em.persist(entidad);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            return false;
        }
        return true;
    }

    @Override
    public boolean remove(Categoria entidad) {
        try {
            utx.begin();
            em.remove(entidad);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            return false;
        }
        return true;
    }

    @Override
    public boolean merge(Categoria entidad) {
        try {
            utx.begin();
            em.merge(entidad);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            return false;
        }
        return true;
    }
    
    public List<Categoria> findAll(){
        query = em.createNamedQuery("Categoria.findAll", Categoria.class);
        return query.getResultList();
    }
}
