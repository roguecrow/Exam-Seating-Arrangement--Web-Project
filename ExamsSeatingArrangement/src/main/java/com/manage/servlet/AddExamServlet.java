package com.manage.servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.manage.dao.DbManager;

/**
 * Servlet implementation class AddExam
 */
@WebServlet("/AddExam")
public class AddExamServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    static String homePageError = "homePage.jsp?message=errorAddingExam&type=error";
    static String homePageSuccess = "homePage.jsp?message=examAddedSuccessfully&type=success";

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddExamServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String examName = request.getParameter("examName");
        String examDescription = request.getParameter("examDescription");
        Date examDate = Date.valueOf(request.getParameter("examDate")); 
        int locationIndex = Integer.parseInt(request.getParameter("locationIndex"));

        Date applicationStart = Date.valueOf(request.getParameter("applicationStart"));
        Date applicationEnd = Date.valueOf(request.getParameter("applicationEnd"));

        int examId = 0;
        try {
            DbManager manage = new DbManager();
            examId = manage.createExam(examName, examDescription, examDate, applicationStart, applicationEnd);
            
            for (int i = 0; i < locationIndex; i++) {
                String city = request.getParameter("locations[" + i + "].city");
                String venueName = request.getParameter("locations[" + i + "].venueName");
                String hallName = request.getParameter("locations[" + i + "].hallName");
                int capacity = Integer.parseInt(request.getParameter("locations[" + i + "].capacity"));
                String address = request.getParameter("locations[" + i + "].address");
                String locationUrl = request.getParameter("locations[" + i + "].locationUrl");
                
                System.out.println("Location " + (i + 1) + " Data:");
                System.out.println("City: " + city);
                System.out.println("Venue Name: " + venueName);
                System.out.println("Hall Name: " + hallName);
                System.out.println("Capacity: " + capacity);
                System.out.println("Address: " + address);
                System.out.println("Location URL: " + locationUrl);
                System.out.println();
                
                int affectedRows = manage.addLocationToExam(city, venueName, hallName, capacity, address, locationUrl, examId);
                
                if (affectedRows != 1) {
                    manage.deleteExam(examId);
                    redirectWithError(response, homePageError);
                    return;
                }
            }
            
            redirectWithError(response, homePageSuccess);
        } catch (java.sql.SQLIntegrityConstraintViolationException e) {
            e.printStackTrace();
            try {
                DbManager manage = new DbManager();
                int affectedRow = manage.deleteExam(examId);
                System.out.println("deleted exam row :" + affectedRow);
            } catch (SQLException | ClassNotFoundException ex) {
                ex.printStackTrace();
            }
            redirectWithError(response, homePageError);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            redirectWithError(response, homePageError);
        }

        System.out.println("Exam Name: " + examName);
        System.out.println("Exam Description: " + examDescription);
        System.out.println("Exam Date: " + examDate);
        System.out.println("Application Start Date: " + applicationStart);
        System.out.println("Application End Date: " + applicationEnd);
    }

    private void redirectWithError(HttpServletResponse response, String url) {
        try {
            response.sendRedirect(url);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
