package acme.dao;

import acme.model.Articulo;
import jakarta.ejb.Stateless;
import jakarta.persistence.TypedQuery;
import java.util.List;

@Stateless
public class ArticuloDAO extends BaseDAO<Articulo, Long> {

    private TypedQuery<Articulo> query;

    @Override
    public Articulo find(Long id) {
        return em.find(Articulo.class, id);
    }

    @Override
    public boolean persist(Articulo entidad) {
        try {
            utx.begin();
            em.persist(entidad);
            utx.commit();
        } catch (Exception ex) {
            return false;
        }
        return true;
    }

    @Override
    public boolean remove(Articulo entidad) {
        try {
            utx.begin();
            em.remove(entidad);
            utx.commit();
        } catch (Exception ex) {
            return false;
        }
        return true;
    }

    @Override
    public boolean merge(Articulo entidad) {
        try {
            utx.begin();
            em.merge(entidad);
            utx.commit();
        } catch (Exception ex) {
            return false;
        }
        return true;
    }

    public List<Articulo> findAll() {
        query = em.createNamedQuery("Articulo.findAll", Articulo.class);
        return query.getResultList();
    }

    public List<Articulo> findByRedactorID(long redId) {
        query = em.createNamedQuery("Articulo.findByRedactorID", Articulo.class);
        query.setParameter("id", redId);
        return query.getResultList();
    }

    public List<Articulo> findByCategoriaID(long catId) {
        query = em.createNamedQuery("Articulo.findByCategoriaID", Articulo.class);
        query.setParameter("id", catId);
        return query.getResultList();
    }

    public List<Articulo> findByWord(String word) {
        query = em.createNamedQuery("Articulo.findByWord", Articulo.class);
        query.setParameter("buscador", "%" + word + "%");
        return query.getResultList();
    }

    public List<Articulo> findByWordCategoriaID(String word, long catId) {
        query = em.createNamedQuery("Articulo.findByWordCategoriaID", Articulo.class);
        query.setParameter("buscador", "%" + word + "%");
        query.setParameter("id", catId);
        return query.getResultList();
    }

}
