package acme.controller;

import acme.dao.AdministradorDAO;
import acme.dao.ArticuloDAO;
import acme.dao.CategoriaDAO;
import acme.dao.RedactorDAO;
import acme.model.Articulo;
import acme.model.Categoria;
import acme.model.Redactor;
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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "ArticuloController", urlPatterns = {"/articulo/*", "/misarticulos"})
public class ArticuloController extends HttpServlet {

    @EJB
    private ArticuloDAO articuloDAO;
    @EJB
    private AdministradorDAO administradorDAO;
    @EJB
    private RedactorDAO redactorDAO;
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
        String vista = "";

        if (servletPath.equals("/articulo")) {
            if (pathInfo == null) {
                long id = Long.parseLong(request.getParameter("id"));
                Articulo art = articuloDAO.find(id);
                request.setAttribute("articulo", art);
                vista = "articulo";

                if (session.getAttribute("adminId") != null) {
                    long idAux = (long) session.getAttribute("adminId");
                    request.setAttribute("usuario", administradorDAO.find(idAux));
                } else if (session.getAttribute("redactorId") != null) {
                    long idAux = (long) session.getAttribute("redactorId");
                    request.setAttribute("usuario", redactorDAO.find(idAux));
                }

            } else if (pathInfo.equals("/nuevo")) {
                List<Categoria> categorias = categoriaDAO.findAll();
                request.setAttribute("categorias", categorias);
                vista = "crearArticulo";

            } else if (pathInfo.equals("/editar")) {
                long id = Long.parseLong(request.getParameter("id"));
                Articulo art = articuloDAO.find(id);
                request.setAttribute("articulo", art);
                vista = "crearArticulo";

                List<Categoria> categorias = categoriaDAO.findAll();
                request.setAttribute("categorias", categorias);
            }

        } else if (servletPath.equals("/misarticulos")) {
            if (pathInfo == null) {
                long id = Long.parseLong(request.getParameter("id"));
                
                List<Articulo> articulos = articuloDAO.findByRedactorID(id);
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

        if (servletPath.equals("/articulo")) {
            if (pathInfo.equals("/eliminar")) {
                long id = Long.parseLong(request.getParameter("id"));
                
                if(articuloDAO.remove(articuloDAO.find(id)))
                    response.setStatus(HttpServletResponse.SC_OK);
                else
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

            } else if (pathInfo.equals("/guardar")) {
                String titulo = request.getParameter("titulo");
                long categoriaId = Long.parseLong(request.getParameter("categoriaId"));
                String contenido = request.getParameter("contenidoHtml");

                Categoria cat = categoriaDAO.find(categoriaId);
                long redactorId = Long.parseLong(request.getParameter("redactorId"));

                if (request.getParameter("articuloId") != null) {
                    Articulo art = articuloDAO.find(Long.parseLong(request.getParameter("articuloId")));
                    art.setTitulo(titulo);
                    art.setCuerpo(contenido);
                    art.setCategoria(cat);

                    articuloDAO.merge(art);

                } else {
                    Redactor red = redactorDAO.find(redactorId);

                    LocalDate fechaActual = LocalDate.now();
                    DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    String fechaFormateada = fechaActual.format(formato);

                    Articulo articulo = new Articulo(titulo, contenido, fechaFormateada, red, cat);

                    articuloDAO.persist(articulo);
                }
                
                response.sendRedirect(Propiedades.redirect + "/misarticulos?id=" + redactorId);
            }
        }
    }

}
