package acme.dao;

import acme.model.Administrador;
import jakarta.ejb.Stateless;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.HeuristicMixedException;
import jakarta.transaction.HeuristicRollbackException;
import jakarta.transaction.NotSupportedException;
import jakarta.transaction.RollbackException;
import jakarta.transaction.SystemException;

@Stateless
public class AdministradorDAO extends BaseDAO<Administrador> {

    private TypedQuery<Administrador> query;

    @Override
    public Administrador find(long id) {
        return em.find(Administrador.class, id);
    }

    @Override
    public boolean persist(Administrador entidad) {
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
    public boolean remove(Administrador entidad) {
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
    public boolean merge(Administrador entidad) {
        try {
            utx.begin();
            em.merge(entidad);
            utx.commit();
        } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
            return false;
        }
        return true;
    }

    public Administrador findByEmailPwd(String email, String pwd) {
        try {
            query = em.createNamedQuery("Administrador.findByEmailPwd", Administrador.class);
            query.setParameter("email", email);
            query.setParameter("pwd", pwd);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

}
