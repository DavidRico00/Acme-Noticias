/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package acme.controller;

import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.UserTransaction;
import java.io.IOException;

/**
 *
 * @author Antonio
 */
@WebServlet(name = "AppController", urlPatterns = {"/main"})
public class AppController extends HttpServlet {
    @PersistenceContext(unitName = "AcmeNoticiasPU") 
    private EntityManager em;
    @Resource
    private UserTransaction utx;

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vista="error", accion = request.getServletPath();
        
        switch (accion) {
            case "/main":
                vista = "main";
                System.out.println("eoeoeoeoeoe");
                break;
            
        }
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/" + vista + ".jsp");
        rd.forward(request, response);
    }
}
