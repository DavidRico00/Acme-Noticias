package acme.controller;

import acme.dao.ArticuloDAO;
import acme.dao.ComentarioDAO;
import acme.model.Redactor;
import acme.utilidad.Propiedades;
import acme.utilidad.Seguridad;
import jakarta.annotation.Resource;
import jakarta.ejb.EJB;
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

@WebServlet(name = "RedactorController", urlPatterns = {"/creaRedactores", "/guardarRedactor", "/listaRedactores", "/eliminar"})
public class RedactorController extends HttpServlet {

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
        session.setAttribute("ContextPath", Propiedades.getInstance().ContextPath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vista = "";
        setAttributes(request);

        if (servletPath.equals("/creaRedactores")) {
            vista = "creaRedactores";
            
        } else if (servletPath.equals("/listaRedactores")) {
            TypedQuery<Redactor> query = em.createNamedQuery("Redactor.findAll", Redactor.class);
            List<Redactor> redactores = query.getResultList();
            request.setAttribute("redactores", redactores);
            vista = "listaRedactores";
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setAttributes(request);

        if (servletPath.equals("/guardarRedactor")) {
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String dni = request.getParameter("dni");
            String email = request.getParameter("email");
            String pwd = Seguridad.pwdMD5(request.getParameter("pwd"));

            Redactor redactor = new Redactor(nombre, apellido, dni, email, pwd);

            try {
                utx.begin();
                em.persist(redactor);
                utx.commit();
            } catch (Exception ex) {
            }

            response.sendRedirect(Propiedades.getInstance().ContextPath + "/listaRedactores");
            
        } else if (servletPath.equals("/eliminar")) {
            
            long id = Long.parseLong(request.getParameter("id"));
            try {
                utx.begin();
                Redactor redactor = em.find(Redactor.class, id);
                em.remove(redactor);
                utx.commit();
                response.setStatus(HttpServletResponse.SC_OK);
            } catch (Exception ex) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }
}
