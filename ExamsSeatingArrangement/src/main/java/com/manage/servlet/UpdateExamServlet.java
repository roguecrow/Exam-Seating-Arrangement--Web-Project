package com.manage.servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.manage.dao.DbManager;
import com.manage.model.ExamDetails;

/**
 * Servlet implementation class UpdateExamServlet
 */
@WebServlet("/UpdateExamServlet")
public class UpdateExamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateExamServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String examId = request.getParameter("examId");
		System.out.println("from update exam servlet");
		System.out.println("examId - "+examId);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        int examId = Integer.parseInt(request.getParameter("examId"));
        String examName = request.getParameter("examName");
        String examDate = request.getParameter("examDate");
        String applicationStart = request.getParameter("applicationStart");
        String applicationEnd = request.getParameter("applicationEnd");

        try {
			DbManager manage = new DbManager();
			if(manage.updateExamDetails(examId,Date.valueOf(examDate),Date.valueOf(applicationStart),Date.valueOf(applicationEnd))) {
				System.out.println("success");
			}
			else {
				System.out.println("failed");
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        System.out.println("Exam ID: " + examId);
        System.out.println("Exam Name: " + examName);
        System.out.println("Exam Date: " + examDate);
        System.out.println("Application Start Date: " + applicationStart);
        System.out.println("Application End Date: " + applicationEnd);

        response.sendRedirect("homePage.jsp?message=examUpdatedSuccessfully&type=success");
	}

}
