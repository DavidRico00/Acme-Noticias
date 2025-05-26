package acme.controller;

import acme.dao.RedactorDAO;
import acme.model.Redactor;
import acme.utilidad.Propiedades;
import acme.utilidad.Seguridad;
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

@WebServlet(name = "RedactorController", urlPatterns = {"/creaRedactores", "/guardarRedactor", "/listaRedactores", "/eliminar"})
public class RedactorController extends HttpServlet {

    @EJB
    private RedactorDAO redactorDAO;

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
        String vista = "";
        setAttributes(request);

        if (servletPath.equals("/creaRedactores")) {
            vista = "creaRedactores";
            
        } else if (servletPath.equals("/listaRedactores")) {
            List<Redactor> redactores = redactorDAO.findAll();
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
            redactorDAO.persist(redactor);

            response.sendRedirect(Propiedades.redirect + "/listaRedactores");
            
        } else if (servletPath.equals("/eliminar")) {
            
            long id = Long.parseLong(request.getParameter("id"));
            
            if(redactorDAO.remove(redactorDAO.find(id)))
                response.setStatus(HttpServletResponse.SC_OK);
            else
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
