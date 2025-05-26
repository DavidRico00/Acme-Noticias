package acme.controller;

import acme.dao.AdministradorDAO;
import acme.dao.ArticuloDAO;
import acme.dao.CategoriaDAO;
import acme.model.Administrador;
import acme.model.Articulo;
import acme.model.Categoria;
import acme.model.Redactor;
import acme.utilidad.Propiedades;
import acme.utilidad.Seguridad;
import jakarta.ejb.EJB;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AppController", urlPatterns = {"/main", "/login/*", "/logout"})
public class AppController extends HttpServlet {
    
    @EJB
    private ArticuloDAO articuloDAO;
    @EJB
    private CategoriaDAO categoriaDAO;
    @EJB
    private AdministradorDAO administradorDAO;

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
                String catId = request.getParameter("categoriaId");
                String buscador = request.getParameter("q");

                TypedQuery<Articulo> queryArt;
                List<Articulo> articulos = null;

                if (catId == null || buscador == null) {
                    articulos = articuloDAO.findAll();
                    
                } else if (!catId.equals("") && !buscador.equals("")) {
                    articulos = articuloDAO.findByWordCategoriaID(buscador, Long.parseLong(catId));

                } else if (!catId.equals("") && buscador.equals("")) {
                    articulos = articuloDAO.findByCategoriaID(Long.parseLong(catId));

                //} else if(catId.equals("") && !buscador.equals("")){
                } else {
                    articulos = articuloDAO.findByWord(buscador);
                }
                
                List<Categoria> categorias = categoriaDAO.findAll();

                request.setAttribute("articulos", articulos);
                request.setAttribute("categorias", categorias);
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
                String email = request.getParameter("email"), psw = Seguridad.pwdMD5(request.getParameter("password"));
                Administrador adm = checkAdmin(email, psw);
                if (adm != null) {
                    session.setAttribute("adminId", adm.getId());
                    session.setAttribute("id", adm.getId());
                    identificado = true;
                } else {
                    Redactor red = checkRedactor(email, psw);
                    if (red != null) {
                        session.setAttribute("redactorId", red.getId());
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

    private Administrador checkAdmin(String email, String pwd) {
        Administrador adm = administradorDAO.findByEmailPwd(email, pwd);
        return adm;
    }

    private Redactor checkRedactor(String email, String pwd) {
        //Redactor adm = redactorDAO.findByEmailPwd(email, pwd);
        //return adm;
        return null;
    }
}
