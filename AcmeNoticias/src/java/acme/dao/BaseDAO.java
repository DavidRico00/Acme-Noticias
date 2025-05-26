package acme.dao;

import jakarta.annotation.Resource;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.UserTransaction;

@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public abstract class BaseDAO<C, L> {
    
    @PersistenceContext(unitName = "AcmeNoticiasPU")
    protected EntityManager em;
    @Resource
    protected UserTransaction utx;
    
    public abstract C find(L id);
    
    public abstract boolean persist(C entidad);
    
    public abstract boolean remove(C entidad);
    
    public abstract boolean merge(C entidad);
}
