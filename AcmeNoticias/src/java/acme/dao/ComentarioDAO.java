
package acme.dao;
import acme.model.Comentario;
import jakarta.ejb.Stateless;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.HeuristicMixedException;
import jakarta.transaction.HeuristicRollbackException;
import jakarta.transaction.NotSupportedException;
import jakarta.transaction.RollbackException;
import jakarta.transaction.SystemException;
import java.util.List;

@Stateless
public class ComentarioDAO extends BaseDAO<Comentario>{

    private TypedQuery<Comentario> query;
    
    @Override
    public Comentario find(long id) {
        return em.find(Comentario.class, id);
    }

    @Override
    public boolean persist(Comentario entidad) {
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
    public boolean remove(Comentario entidad) {
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
    public boolean merge(Comentario entidad) {
        try {
            utx.begin();
            em.merge(entidad);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            return false;
        }
        
        return true;
    }
    
    public List<Comentario> findAll(){
        query = em.createNamedQuery("Comentario.findAll", Comentario.class);
        return query.getResultList();
    }
}
