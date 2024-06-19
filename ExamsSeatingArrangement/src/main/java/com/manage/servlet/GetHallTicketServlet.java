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
import com.google.gson.JsonObject;
import com.manage.dao.DbManager;

/**
 * Servlet implementation class GetHallTicketServlet
 */
@WebServlet("/GetHallTicketServlet")
public class GetHallTicketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetHallTicketServlet() {
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
        String serialNumber = request.getParameter("serialNumber");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
  
            DbManager manage = new DbManager();

            // Get exam details
            String examDetailsJson = manage.getExamDetails(serialNumber);

            if (examDetailsJson != null) {
                out.print(examDetailsJson);
            } else {
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("error", "No hall ticket found for the given serial number.");
                out.print(new Gson().toJson(errorResponse));
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Database access error", e);
        }
    }
}
