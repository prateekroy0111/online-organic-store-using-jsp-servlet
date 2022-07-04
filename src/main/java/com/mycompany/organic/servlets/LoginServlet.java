package com.mycompany.organic.servlets;

import com.mycompany.organic.dao.UserDao;
import com.mycompany.organic.entities.User;
import com.mycompany.organic.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            //coding area
            String email = (String) request.getParameter("email");
            String pass = (String) request.getParameter("pass");
            //validations

            //authenticating user
            UserDao userdao = new UserDao(FactoryProvider.getFactory());
            User user = userdao.getUserByEmailAndPassword(email, pass);
            //System.out.println(user);
            HttpSession httpsession = request.getSession();

            if (user == null) {

                httpsession.setAttribute("message", "Invalid Details ! please re-enter !!");
                response.sendRedirect("login.jsp");
                return;
            } else {
                out.println("<h1> Welcome " + user.getUserName() + " </h1>");
                //login
                httpsession.setAttribute("current-user", user);
                if (user.getUserType().equals("admin")) {
                    //admin.jsp
                    response.sendRedirect("admin.jsp");
                } else if (user.getUserType().equals("normal")) {
                    //normal.jsp
                    response.sendRedirect("normal.jsp");
                } else {
                    out.println("We have not identified User's type");
                }

            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
