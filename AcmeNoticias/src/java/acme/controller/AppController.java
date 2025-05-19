package acme.controller;

import acme.model.Administrador;
import acme.model.Articulo;
import acme.model.Redactor;
import acme.utilidad.Propiedades;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.UserTransaction;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AppController", urlPatterns = {"/main", "/login/*", "/logout"})
public class AppController extends HttpServlet {

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
        String vista = "";
        setAttributes(request);

        switch (servletPath) {
            case "/main": {
                vista = "main";
                TypedQuery<Articulo> query = em.createNamedQuery("Articulo.findAll", Articulo.class);
                List<Articulo> articulos = query.getResultList();
                request.setAttribute("articulos", articulos);
            }
            break;

            case "/login": {
                vista = "login";
                request.removeAttribute("msg");
            }
            break;

            case "/logout": {
                session.invalidate();
                response.sendRedirect(Propiedades.getInstance().redirect + "/main");
            }
            break;

            default:
                vista = "error";
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

        if (servletPath.equals("/login")) {
            if (pathInfo.equals("/check")) {
                boolean identificado = false;
                String email = request.getParameter("email"), psw = request.getParameter("password");

                Administrador adm = checkAdmin(email, psw);
                if (adm != null) {
                    session.setAttribute("admin", adm.getId());
                    session.setAttribute("id", adm.getId());
                    identificado = true;
                } else {
                    Redactor red = checkRedactor(email, psw);
                    if (red != null) {
                        session.setAttribute("redactor", adm.getId());
                        session.setAttribute("id", red.getId());
                        identificado = true;
                    }
                }

                if (identificado) {
                    response.sendRedirect(Propiedades.getInstance().redirect + "/main");
                } else {
                    request.setAttribute("msg", "Error: email o contraseña erroneos");
                    vista = "login";
                }
            }
        }

        if (!vista.equals("")) {
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp");
            rd.forward(request, response);
        }

    }

    private Administrador checkAdmin(String email, String psw) {
        Administrador adm = null;

        try {
            TypedQuery<Administrador> query = em.createNamedQuery("Administrador.findByEmailPwd", Administrador.class);
            query.setParameter("email", email);
            query.setParameter("pwd", psw);
            adm = query.getSingleResult();
        } catch (Exception e) {
        }

        return adm;
    }

    private Redactor checkRedactor(String email, String psw) {
        Redactor adm = null;

        try {
            TypedQuery<Redactor> query = em.createNamedQuery("Redactor.findByEmailPwd", Redactor.class);
            query.setParameter("email", email);
            query.setParameter("pwd", psw);
            adm = query.getSingleResult();
        } catch (Exception e) {
        }

        return adm;
    }
}
