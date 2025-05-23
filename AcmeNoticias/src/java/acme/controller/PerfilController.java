package acme.controller;

import acme.model.Redactor;
import acme.utilidad.Propiedades;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import jakarta.transaction.UserTransaction;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

@WebServlet(name = "PerfilController", urlPatterns = {"/perfil/*"})
public class PerfilController extends HttpServlet {

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

        if (servletPath.equals("/perfil")) {
            long id = Long.parseLong(request.getParameter("id"));

            Redactor redactor = em.find(Redactor.class, id);
            request.setAttribute("redactor", redactor);
            vista = "perfil";
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vista = "";
        setAttributes(request);

        if (servletPath.equals("/perfil")) {
            if (pathInfo.equals("/editarperfil")) {
                long idweqw = Long.parseLong(request.getParameter("id"));
                System.out.println(idweqw);
                try {
                    long id = Long.parseLong(request.getParameter("id"));
                    Redactor redactor = em.find(Redactor.class, id);
                    String email = request.getParameter("email");
                    String dni = request.getParameter("dni");

                    redactor.setEmail(email);
                    redactor.setDni(dni);
                    final Part imgPart = request.getPart("profileimg");
                    if (imgPart != null || !imgPart.getSubmittedFileName().equals("")) {
                        String relativePath = "" + File.separator + "img";
                        String absolutePath = getServletContext().getRealPath(relativePath);
                        String fileName = redactor.getId().toString();
                        redactor.setRutaimg(Propiedades.getInstance().ContextPath + File.separator + "img" + File.separator + fileName + ".jpg");
                        File f = new File(absolutePath + File.separator + "img" + File.separator + fileName + ".jpg");
                        OutputStream fos = new FileOutputStream(f);
                        InputStream filecontent = imgPart.getInputStream();
                        int read = 0;
                        final byte[] bytes = new byte[1024];
                        while ((read = filecontent.read(bytes)) != -1) {
                            fos.write(bytes, 0, read);
                        }
                        fos.close();
                        filecontent.close();
                    }
                    utx.begin();
                    em.merge(redactor);
                    utx.commit();
                    response.sendRedirect(Propiedades.getInstance().ContextPath + "/perfil?id=" + id);
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                }
            }
        }
    }

}
