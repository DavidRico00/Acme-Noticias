package acme.controller;

import acme.model.Articulo;
import acme.model.Comentario;
import acme.utilidad.Propiedades;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.HeuristicMixedException;
import jakarta.transaction.HeuristicRollbackException;
import jakarta.transaction.NotSupportedException;
import jakarta.transaction.RollbackException;
import jakarta.transaction.SystemException;
import jakarta.transaction.UserTransaction;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "ComentarioController", urlPatterns = {"/comentario/*"})
public class ComentarioController extends HttpServlet {
/*      /comentario/agregar?id      POST    TODOS
        /comentario/eliminar?id     POST    TODOS
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

                Articulo articulo = em.find(Articulo.class, id);

                LocalDate fechaActual = LocalDate.now();

                DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                String fechaFormateada = fechaActual.format(formato);

                Comentario comentario = new Comentario(nombre, cuerpo, fechaFormateada, articulo);

                List<Comentario> comentarios = articulo.getComentarios();
                comentarios.add(comentario);
                articulo.setComentarios(comentarios);

                try {
                    utx.begin();
                    em.persist(comentario);
                    em.merge(articulo);
                    utx.commit();
                } catch (NotSupportedException | SystemException | RollbackException | HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException ex) {
                    Logger.getLogger(ComentarioController.class.getName()).log(Level.SEVERE, null, ex);
                }
                response.sendRedirect(Propiedades.getInstance().redirect + "/articulo?id=" + id);
            }
            
            else if(pathInfo.equals("/eliminar")){
                long id = Long.parseLong(request.getParameter("id"));
                long artId = Long.parseLong(request.getParameter("artId"));
                try {
                    utx.begin();
                    Comentario com = em.find(Comentario.class, id);
                    Articulo art = em.find(Articulo.class, artId);
                    art.getComentarios().remove(com);
                    art.setComentarios(art.getComentarios());
                    em.merge(art);
                    em.remove(com);
                    utx.commit();
                } catch (Exception ex) {
                    System.out.println("ERROR AL ELIMINAR COMENTARIO CON ID: " + id);
                }
                response.sendRedirect(Propiedades.getInstance().ContextPath + "/articulo?id=" + artId);
            }
        }
    }
}
