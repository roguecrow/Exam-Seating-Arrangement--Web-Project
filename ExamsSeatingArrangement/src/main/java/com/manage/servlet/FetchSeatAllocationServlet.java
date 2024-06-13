package com.manage.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.manage.dao.DbManager;
import com.manage.model.LocationDetails;

/**
 * Servlet implementation class FetchSeatAllocationServlet
 */
@WebServlet("/FetchSeatAllocationServlet")
public class FetchSeatAllocationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FetchSeatAllocationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("hii from post");
		int examId = Integer.parseInt(request.getParameter("examId"));
        int rollNo = Integer.parseInt(request.getParameter("rollNo"));

        DbManager dbManager;
		try {
			dbManager = new DbManager();
	        LocationDetails locationDetails = dbManager.getExamLocationDetails(rollNo, examId);
	        response.setContentType("application/json");
	        PrintWriter out = response.getWriter();
	        Gson gson = new Gson();
	        String jsonResponse = gson.toJson(locationDetails);
	        System.out.println("jsonResponse  :--" +jsonResponse);
	        out.print(jsonResponse);
	        out.flush();
			//doGet(request, response);

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
