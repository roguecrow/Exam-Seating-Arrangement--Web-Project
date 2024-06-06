package com.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.manage.encrypt.PasswordEncryption;
import com.manage.model.UserDetails;
import com.manage.util.DbManager;

/**
 * Servlet implementation class FirstServlet
 */
@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    UserDetails details = new UserDetails();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignInServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
        System.out.println("hii from get");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        try {
            HttpSession session = request.getSession();
            DbManager manage = new DbManager();
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            PasswordEncryption mask = new PasswordEncryption();
            
            if(action != null) {
            	
                switch (action) {
                case "register":
                    System.out.println("register");
                    if (manage.findUser(email, password,details,false)) {
                    	System.out.println("account already there");
                        request.setAttribute("errorMessage", "Account already there.");
                        
                        request.getRequestDispatcher("registerPage.jsp").forward(request, response);
                    }
                    else  {
                        manage.userRegisteration(name, email, mask.encrypt(password));
                        manage.findUser(email, password, details, false);
                       
                        session.setAttribute("userDetails", details);
                        session.setAttribute("exams", manage.getAllExams());
                        response.sendRedirect("HomePage.jsp");
                    }

                    break;
                case "signin":
                    System.out.println("sign in");
                    if (manage.findUser(email, password,details,true)) {
                        System.out.println(details.getUsername() +" "+ details.getRollNo());
                        session.setAttribute("userDetails", details);
                        session.setAttribute("exams", manage.getAllExams());
                        response.sendRedirect("HomePage.jsp");
                    } else {
                        
                        request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
                        
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                    break;
                default:
                    throw new IllegalArgumentException("Unexpected value: " + action);
            }
            	
            }
            else {
            	System.out.println("action is null");
                response.sendRedirect("registerPage.jsp");

            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
