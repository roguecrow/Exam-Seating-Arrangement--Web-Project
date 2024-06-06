package com.manage.servlet;

import com.manage.model.ExamDetails;
import com.manage.util.DbManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "GetExamDetailsServlet", urlPatterns = {"/GetExamDetailsServlet"})
public class GetExamDetailsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int examId = Integer.parseInt(request.getParameter("examId"));
            
            DbManager dbManager = new DbManager();
            ExamDetails examDetails = null;
            try {
                examDetails = dbManager.getExamById(examId);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            out.println("<h2>" + examDetails.getExamName() + "</h2>");
            out.println("<p><strong>Description:</strong> " + examDetails.getDescription() + "</p>");
            out.println("<p><strong>Exam Date:</strong> " + examDetails.getExamDate() + "</p>");
            out.println("<p><strong>Application Start Date:</strong> " + examDetails.getApplicationStartDate() + "</p>");
            out.println("<p><strong>Application End Date:</strong> " + examDetails.getApplicationEndDate() + "</p>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
			processRequest(request, response);
		} catch (ClassNotFoundException | ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
			processRequest(request, response);
		} catch (ClassNotFoundException | ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
