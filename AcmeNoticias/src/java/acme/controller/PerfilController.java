package acme.controller;

import acme.model.Redactor;
import acme.utilidad.Propiedades;
import acme.utilidad.Seguridad;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
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

@MultipartConfig
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
                try {
                    long id = Long.parseLong(request.getParameter("id"));
                    Redactor redactor = em.find(Redactor.class, id);

                    String email = request.getParameter("email");
                    String dni = request.getParameter("dni");
                    String pwdantigua = Seguridad.pwdMD5(request.getParameter("pwdantigua"));
                    if (!pwdantigua.equals(redactor.getPwd())) {
                        request.getSession().setAttribute("msg", "Contraseña antigua incorrecta");
                        response.sendRedirect(Propiedades.getInstance().ContextPath + "/perfil?id=" + id);
                        return;
                    } else {
                        redactor.setPwd(Seguridad.pwdMD5(request.getParameter("pwdnueva")));
                        redactor.setEmail(email);
                        redactor.setDni(dni);

                        Part imgPart = request.getPart("profileimg");

                        if (imgPart != null && imgPart.getSize() > 0 && !imgPart.getSubmittedFileName().trim().isEmpty()) {
                            String fileName = redactor.getId().toString() + ".jpg";

                            // Ruta relativa para guardar en BD y mostrar en <img>
                            String rutaImgRelativa = "/img/" + fileName;
                            redactor.setRutaimg(rutaImgRelativa);

                            // Ruta física absoluta para guardar el archivo en /web/img/
                            String absolutePath = getServletContext().getRealPath("/img");
                            File imgDir = new File(absolutePath);
                            File f = new File(imgDir, fileName);

                            try (OutputStream fos = new FileOutputStream(f); InputStream filecontent = imgPart.getInputStream()) {

                                byte[] bytes = new byte[1024];
                                int read;
                                while ((read = filecontent.read(bytes)) != -1) {
                                    fos.write(bytes, 0, read);
                                }
                            }
                        }

                        utx.begin();
                        em.merge(redactor);
                        utx.commit();
                        response.sendRedirect(Propiedades.getInstance().ContextPath + "/perfil?id=" + id);
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                }
            }
        }
    }

}
