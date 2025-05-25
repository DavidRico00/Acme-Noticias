package acme.controller;

import acme.model.Categoria;
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
import jakarta.transaction.UserTransaction;
import java.util.List;

@WebServlet(name = "CategoriaController", urlPatterns = {"/gestionCategorias", "/categoria/*"})
public class CategoriaController extends HttpServlet {
/*      /gestionCategorias      GET     ADMIN
        /categoria/nueva        GET     ADMIN
        /categoria/editar?id    GET     ADMIN
        /categoria/guardar      POST    ADMIN
        /categoria/eliminar?id  POST    ADMIN
*/

    @PersistenceContext(unitName = "AcmeNoticiasPU")
    private EntityManager em;
    @Resource
    private UserTransaction utx;

    private HttpSession session;
    String servletPath, pathInfo;

    private void setAttributes(HttpServletRequest request) {
        servletPath = request.getServletPath();
        pathInfo = request.getPathInfo();
        session = request.getSession();
        session.setAttribute("ContextPath", Propiedades.getInstance().ContextPath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setAttributes(request);
        if(session.getAttribute("adminId") == null){
            response.sendRedirect(Propiedades.getInstance().ContextPath + "/main");
            return;
        }
        
        String vista = "";
        
        if (servletPath.equals("/gestionCategorias") && pathInfo==null || pathInfo.equals("")) {
            TypedQuery<Categoria> query = em.createNamedQuery("Categoria.findAll", Categoria.class);
            List<Categoria> categorias = query.getResultList();
            request.setAttribute("categorias", categorias);
            vista = "gestionCategorias";
            
        } else if (servletPath.equals("/categoria")) {
            if (pathInfo.equals("/nueva")) {
                vista = "nuevaCategoria";
                
            } else if (pathInfo.equals("/editar")) {
                long id = Long.parseLong(request.getParameter("id"));
                Categoria cat = em.find(Categoria.class, id);
                request.setAttribute("categoria", cat);
                vista = "nuevaCategoria";
            }
        }
            

        if (!vista.equals("")) {
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp");
            rd.forward(request, response);
        
        } else
            response.sendRedirect(Propiedades.getInstance().ContextPath + "/main");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setAttributes(request);
        if(session.getAttribute("adminId") == null){
            response.sendRedirect(Propiedades.getInstance().ContextPath + "/main");
            return;
        }

        if (servletPath.equals("/categoria")) {
            switch (pathInfo) {
                case "/guardar": {
                    String nombre = request.getParameter("nombre");
                    String desc = request.getParameter("descripcion");

                    if (request.getParameter("id") == null || request.getParameter("id").equals("")) {
                        Categoria cat = new Categoria(nombre, desc);
                        try {
                            utx.begin();
                            em.persist(cat);
                            utx.commit();
                        } catch (Exception ex) {
                        }
                        
                    } else {
                        long id = Long.parseLong(request.getParameter("id"));
                        Categoria cat = em.find(Categoria.class, id);
                        cat.setNombre(nombre);
                        cat.setDescripcion(desc);

                        try {
                            utx.begin();
                            em.merge(cat);
                            utx.commit();
                        } catch (Exception ex) {
                        }
                    }

                    response.sendRedirect(Propiedades.getInstance().ContextPath + "/gestionCategorias");
                }
                break;

                case "/eliminar": {
                    long id = Long.parseLong(request.getParameter("id"));
                    try {
                        utx.begin();
                        Categoria cat = em.find(Categoria.class, id);
                        em.remove(cat);
                        utx.commit();
                        response.setStatus(HttpServletResponse.SC_OK);
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    }
                }
                break;
            }
        }

    }

}
