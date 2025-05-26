package acme.controller;

import acme.dao.ArticuloDAO;
import acme.dao.ComentarioDAO;
import acme.model.Articulo;
import acme.model.Comentario;
import acme.utilidad.Propiedades;
import jakarta.ejb.EJB;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "ComentarioController", urlPatterns = {"/comentario/*"})
public class ComentarioController extends HttpServlet {
/*      /comentario/agregar?id      POST    TODOS
        /comentario/eliminar?id     POST    TODOS
*/

    @EJB
    private ComentarioDAO comentarioDAO;
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
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setAttributes(request);

        if (servletPath.equals("/comentario")) {
            if (pathInfo.equals("/agregar")) {
                long id = Long.parseLong(request.getParameter("articuloId"));
                String nombre = request.getParameter("nombre");
                String cuerpo = request.getParameter("cuerpo");

                Articulo articulo = articuloDAO.find(id);

                LocalDate fechaActual = LocalDate.now();

                DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                String fechaFormateada = fechaActual.format(formato);

                Comentario comentario = new Comentario(nombre, cuerpo, fechaFormateada, articulo);

                List<Comentario> comentarios = articulo.getComentarios();
                comentarios.add(comentario);
                articulo.setComentarios(comentarios);
                
                comentarioDAO.persist(comentario);
                articuloDAO.merge(articulo);
                
                response.sendRedirect(Propiedades.redirect + "/articulo?id=" + id);
            }
            
            else if(pathInfo.equals("/eliminar")){
                long id = Long.parseLong(request.getParameter("id"));
                long artId = Long.parseLong(request.getParameter("artId"));

                Comentario com = comentarioDAO.find(id);
                Articulo art = articuloDAO.find(artId);
                art.getComentarios().remove(com);
                art.setComentarios(art.getComentarios());
                articuloDAO.merge(art);
                    
                response.sendRedirect(Propiedades.redirect + "/articulo?id=" + artId);
            }
        }
    }
}
