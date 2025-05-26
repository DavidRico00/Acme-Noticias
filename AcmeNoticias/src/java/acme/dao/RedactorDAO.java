package acme.dao;

import acme.model.Redactor;
import jakarta.ejb.Stateless;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.HeuristicMixedException;
import jakarta.transaction.HeuristicRollbackException;
import jakarta.transaction.NotSupportedException;
import jakarta.transaction.RollbackException;
import jakarta.transaction.SystemException;
import java.util.List;

@Stateless
public class RedactorDAO extends BaseDAO<Redactor> {

    private TypedQuery<Redactor> query;

    @Override
    public Redactor find(long id) {
        return em.find(Redactor.class, id);
    }

    @Override
    public boolean persist(Redactor entidad) {
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
    public boolean remove(Redactor entidad) {
        try {
            utx.begin();
            Redactor red = em.merge(entidad);
            em.remove(red);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            return false;
        }
        return true;

    }

    @Override
    public boolean merge(Redactor entidad) {
        try {
            utx.begin();
            em.merge(entidad);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            return false;
        }
        return true;
    }

    public List<Redactor> findAll() {
        query = em.createNamedQuery("Redactor.findAll", Redactor.class);
        return query.getResultList();
    }

    public Redactor findByEmailPwd(String email, String pwd) {
        try {
            query = em.createNamedQuery("Redactor.findByEmailPwd", Redactor.class);
            query.setParameter("email", email);
            query.setParameter("pwd", pwd);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
