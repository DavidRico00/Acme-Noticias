package acme.controller;

import acme.model.Articulo;
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
import java.util.Comparator;
import java.util.List;
import java.util.Set;

@WebServlet(name = "AdministradorController", urlPatterns = {"/dashboard"})
public class AdministradorController extends HttpServlet {

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

        if (servletPath.equals("/dashboard")) {
            TypedQuery<Articulo> query = em.createNamedQuery("Articulo.findAll", Articulo.class);
            List<Articulo> articulos = query.getResultList();
            float totalComentarios = 0;
            for (Articulo art : articulos) {
                totalComentarios += art.getComentarios().size();
            }
            totalComentarios /= articulos.size();
            request.setAttribute("media", totalComentarios);

            articulos.sort(Comparator.comparingInt((Articulo a) -> a.getComentarios().size()).reversed());
            if (articulos.size() > 5) {
                articulos = articulos.subList(0, 5);
            }

            request.setAttribute("articulosMasComentados", articulos);

            vista = "dashboard";
        } 

        if (!vista.equals("")) {
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 
    }

}
