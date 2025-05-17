package acme.controller;

import acme.model.Rol;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.UserTransaction;
import java.util.List;


@WebServlet(name = "RolController", urlPatterns = {"/rol/*", "/roles"})
public class RolController extends HttpServlet {
    
    @PersistenceContext(unitName = "AcmeNoticiasPU") 
    private EntityManager em;
    @Resource
    private UserTransaction utx;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vista; 
 
        String accion = "/roles"; 
        if (request.getServletPath().equals("/rol")) { 
            if (request.getPathInfo() != null) { 
                accion = request.getPathInfo(); 
            } else { 
                accion = "error"; 
            } 
        } 
        
        switch (accion) { 
            case "/roles" -> { 
                List<Rol> lb; 
                TypedQuery<Rol> q = em.createNamedQuery("Rol.findAll", Rol.class); 
                lb = q.getResultList(); 
                request.setAttribute("roles", lb); 
                vista = "roles"; 
            } 
            case "/new" -> { 
                vista = "formRol"; 
            } 
            default -> { 
                vista = "error"; 
            } 
        } 
 
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp"); 
        rd.forward(request, response); 
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String accion = request.getPathInfo(); 
 
        if (accion.equals("/save")) { 
 
            String name = request.getParameter("name"); 
            try { 
 
                if (name.isEmpty()) { 
                    throw new NullPointerException(); 
                } 
                Rol p = new Rol(name); 
                save(p); 
                response.sendRedirect("http://localhost:8080/AcmeNoticias/roles"); 
 
            } catch (Exception e) { 
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
            throw new RuntimeException(e); 
        } 
    } 

}
