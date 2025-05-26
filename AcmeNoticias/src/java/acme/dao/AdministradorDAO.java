package acme.dao;

import acme.model.Administrador;
import jakarta.ejb.Stateless;
import jakarta.persistence.TypedQuery;

@Stateless
public class AdministradorDAO extends BaseDAO<Administrador> {

    private TypedQuery<Administrador> query;

    @Override
    public Administrador find(long id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean persist(Administrador entidad) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean remove(Administrador entidad) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean merge(Administrador entidad) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Administrador findByEmailPwd(String email, String pwd) {
        query = em.createNamedQuery("Administrador.findByEmailPwd", Administrador.class);
        query.setParameter("email", email);
        query.setParameter("pwd", pwd);
        return query.getSingleResult();
    }

}
