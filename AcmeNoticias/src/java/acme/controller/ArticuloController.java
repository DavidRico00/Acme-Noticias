package acme.controller;

import acme.model.Articulo;
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
import jakarta.transaction.NotSupportedException;
import jakarta.transaction.SystemException;
import jakarta.transaction.UserTransaction;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ArticuloController", urlPatterns = {"/articulo/*", "/misarticulos"})
public class ArticuloController extends HttpServlet {

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
        String vista = "";

        if (servletPath.equals("/articulo")) {
            if (pathInfo == null) {
                long id = Long.parseLong(request.getParameter("id"));
                Articulo art = em.find(Articulo.class, id);
                request.setAttribute("articulo", art);
                vista = "articulo";
            } else if (pathInfo.equals("/nuevo")) {
                vista = "crearArticulo";
            }
        } else if (servletPath.equals("/misarticulos")) {
            if (pathInfo == null) {
                List<Articulo> articulos;
                long id = Long.parseLong(request.getParameter("id"));
                TypedQuery<Articulo> qArticulo = em.createNamedQuery("Articulo.findByRedactorID", Articulo.class);
                qArticulo.setParameter("id", id);
                articulos = qArticulo.getResultList();
                request.setAttribute("articulos", articulos);
                vista = "misArticulos";
            }
        }

        if (!vista.equals("")) {
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vista = "";
        setAttributes(request);
        
        if(servletPath.equals("/articulo")){
            if(pathInfo.equals("/eliminar")){
                long id = Long.parseLong(request.getParameter("id"));
                try {
                    utx.begin();
                    Articulo articulo = em.find(Articulo.class, id);
                    em.remove(articulo);
                    utx.commit();
                    response.setStatus(HttpServletResponse.SC_OK);
                } catch (Exception ex) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                }
                
            }
        }
    }

}
