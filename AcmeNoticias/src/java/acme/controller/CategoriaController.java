package acme.controller;

import acme.dao.CategoriaDAO;
import acme.model.Categoria;
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
import java.util.List;

@WebServlet(name = "CategoriaController", urlPatterns = {"/gestionCategorias", "/categoria/*"})
public class CategoriaController extends HttpServlet {
/*      /gestionCategorias      GET     ADMIN
        /categoria/nueva        GET     ADMIN
        /categoria/editar?id    GET     ADMIN
        /categoria/guardar      POST    ADMIN
        /categoria/eliminar?id  POST    ADMIN
*/

    @EJB
    private CategoriaDAO categoriaDAO;

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
        
        if (servletPath.equals("/gestionCategorias") && pathInfo==null || pathInfo.equals("")) {
            List<Categoria> categorias = categoriaDAO.findAll();
            request.setAttribute("categorias", categorias);
            vista = "gestionCategorias";
            
        } else if (servletPath.equals("/categoria")) {
            if (pathInfo.equals("/nueva")) {
                vista = "nuevaCategoria";
                
            } else if (pathInfo.equals("/editar")) {
                long id = Long.parseLong(request.getParameter("id"));
                Categoria cat = categoriaDAO.find(id);
                request.setAttribute("categoria", cat);
                vista = "nuevaCategoria";
            }
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
        setAttributes(request);
        if(session.getAttribute("adminId") == null){
            response.sendRedirect(Propiedades.redirect + "/main");
            return;
        }

        if (servletPath.equals("/categoria")) {
            switch (pathInfo) {
                case "/guardar": {
                    String nombre = request.getParameter("nombre");
                    String desc = request.getParameter("descripcion");

                    if (request.getParameter("id") == null || request.getParameter("id").equals("")) {
                        Categoria cat = new Categoria(nombre, desc);
                        categoriaDAO.persist(cat);
                        
                    } else {
                        long id = Long.parseLong(request.getParameter("id"));
                        Categoria cat = categoriaDAO.find(id);
                        cat.setNombre(nombre);
                        cat.setDescripcion(desc);

                        categoriaDAO.merge(cat);
                    }

                    response.sendRedirect(Propiedades.redirect + "/gestionCategorias");
                }
                break;

                case "/eliminar": {
                    long id = Long.parseLong(request.getParameter("id"));
                    
                    if(categoriaDAO.remove(categoriaDAO.find(id)))
                        response.setStatus(HttpServletResponse.SC_OK);
                    else
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                }
                break;
            }
        }

    }

}
