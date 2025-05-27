package acme.controller;

import acme.dao.ArticuloDAO;
import acme.model.Articulo;
import acme.utilidad.Propiedades;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Comparator;
import java.util.List;

@WebServlet(name = "AdministradorController", urlPatterns = {"/dashboard"})
public class AdministradorController extends HttpServlet {
/*      /dashboard  GET  ADMIN  ✅
*/

    @EJB
    private ArticuloDAO articuloDAO;

    private HttpSession session;
    String servletPath, pathInfo;

    private void setAttributes(HttpServletRequest request) {
        servletPath = request.getServletPath();
        pathInfo = request.getPathInfo();
        session = request.getSession();
        session.setAttribute("ContextPath", Propiedades.contextPath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setAttributes(request);
        if(session.getAttribute("adminId") == null){
            response.sendRedirect(Propiedades.redirect + "/main");
            return;
        }
        
        String vista = "";

        if (servletPath.equals("/dashboard") && pathInfo==null || pathInfo.equals("")) {
            List<Articulo> articulos = articuloDAO.findAll();
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
        } else
            response.sendRedirect(Propiedades.redirect + "/main");   
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.sendRedirect(Propiedades.redirect + "/main");        
    }

}
