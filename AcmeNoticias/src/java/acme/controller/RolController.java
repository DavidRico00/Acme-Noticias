package acme.controller;

import acme.model.Rol;
import acme.utilidad.Propiedades;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.SystemException;
import jakarta.transaction.UserTransaction;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet(name = "RolController", urlPatterns = {"/rol/*", "/roles"})
public class RolController extends HttpServlet {
    
    @PersistenceContext(unitName = "AcmeNoticiasPU") 
    private EntityManager em;
    @Resource
    private UserTransaction utx;
    
    private HttpSession session;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vista="error", accion = request.getServletPath();
        session = request.getSession();
        
        switch (accion) { 
            case "/roles" -> { 
                List<Rol> lb; 
                TypedQuery<Rol> q = em.createNamedQuery("Rol.findAll", Rol.class); 
                lb = q.getResultList(); 
                request.setAttribute("roles", lb); 
                vista = "roles"; 
            } 
            case "/rol" -> {
                if(request.getPathInfo().equals("/new"))
                    vista = "formRol";
            } 
        } 
 
        session.setAttribute("ContextPath", Propiedades.getInstance().ContextPath);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp"); 
        rd.forward(request, response); 
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        session = request.getSession();
        session.setAttribute("ContextPath", Propiedades.getInstance().ContextPath);
 
        if (request.getServletPath().equals("/rol") && request.getPathInfo().equals("/save")) { 
            String name = request.getParameter("name");
            
            if(!name.isEmpty())
            {
                Rol p = new Rol(name); 
                save(p); 
                response.sendRedirect(Propiedades.getInstance().redirect+"/roles"); 
            } else {
                request.setAttribute("msg", "Error: datos no válidos"); 
                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/error.jsp"); 
                rd.forward(request, response); 
            }
        } else { 
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/error.jsp"); 
            rd.forward(request, response); 
        }
    }


    public void save(Rol p) { 
        Long id = p.getId(); 
        try { 
            utx.begin(); 
            if (id == null) { 
                em.persist(p); 
            } else { 
                em.merge(p); 
            } 
            utx.commit(); 
        } catch (Exception e) {
            try {
                utx.rollback();
            } catch (IllegalStateException | SecurityException | SystemException ex) {
                Logger.getLogger(RolController.class.getName()).log(Level.SEVERE, null, ex);
            }            
            throw new RuntimeException(e); 
        } 
    } 

}
