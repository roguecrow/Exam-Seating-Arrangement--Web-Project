package com.manage.servlet;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.manage.model.UserDetails;

/**
 * Servlet implementation class DocumentServlet
 */
@WebServlet("/DocumentServlet")
public class DocumentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DocumentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        HttpSession session = request.getSession();
        UserDetails userDetail = (UserDetails) session.getAttribute("userDetails");

        if (userDetail != null) {
            InputStream inputStream = null;
            String contentType = "image/jpeg";

            switch (type) {
                case "passportPhoto":
                    inputStream = new ByteArrayInputStream(userDetail.getPassportSizePhoto());
                    break;
                case "digitalSignature":
                    inputStream = new ByteArrayInputStream(userDetail.getDigitalSignature());
                    break;
                case "qualificationDocuments":
                    inputStream = new ByteArrayInputStream(userDetail.getQualificationDocuments());
                    contentType = "application/pdf";
                    break;
            }

            if (inputStream != null) {
                response.setContentType(contentType);
                OutputStream outputStream = response.getOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
