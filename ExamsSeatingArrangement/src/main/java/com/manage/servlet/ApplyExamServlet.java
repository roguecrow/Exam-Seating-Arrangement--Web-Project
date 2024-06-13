package com.manage.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.manage.dao.DbManager;
import com.manage.dao.ExamSeatAllocator;
import com.manage.model.UserDetails;

/**
 * Servlet implementation class ApplyExamServlet
 */
@WebServlet("/ApplyExamServlet")
@MultipartConfig
public class ApplyExamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApplyExamServlet() {
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
        String action = request.getParameter("action1");
        System.out.println("action :" +action);
        HttpSession session = request.getSession();
        UserDetails userDetail = (UserDetails) session.getAttribute("userDetails");

        if (userDetail == null) {
            userDetail = new UserDetails();
        }

        
        switch (action) {
            case "uploadDoc":
			try {
				handleDocumentUpload(request, response, userDetail);
			} catch (ClassNotFoundException | ServletException | IOException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
                break;
            case "applyExam":
            	System.out.println("case 2");
                handleExamApplication(request, response, userDetail);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                break;
        }
        
    }

    private void handleDocumentUpload(HttpServletRequest request, HttpServletResponse response, UserDetails userDetail) throws ServletException, IOException, ClassNotFoundException, SQLException {
        System.out.println("from handle doc");
        
        DbManager manage = new DbManager();
        HttpSession session = request.getSession();
        UserDetails details = (UserDetails) session.getAttribute("userDetails");
        String examIdStr = (String) session.getAttribute("examId");
        int examId = Integer.parseInt(examIdStr);
        ExamSeatAllocator allocator = new ExamSeatAllocator();
        String appId = examIdStr+details.getRollNo();
        System.out.println("application ID :"+appId);

        Part passportPhotoPart = request.getPart("passportPhoto");
        Part digitalSignaturePart = request.getPart("digitalSignature");
        Part qualificationDocumentsPart = request.getPart("qualificationDocuments");

        InputStream passportPhoto = passportPhotoPart != null ? passportPhotoPart.getInputStream() : null;
        InputStream digitalSignature = digitalSignaturePart != null ? digitalSignaturePart.getInputStream() : null;
        InputStream qualificationDocuments = qualificationDocumentsPart != null ? qualificationDocumentsPart.getInputStream() : null;
                
        if(manage.addUserDetails(userDetail,appId) == 1 && manage.addUserDocument(userDetail.getRollNo(), passportPhoto, digitalSignature, qualificationDocuments) == 1) {
        	
        	allocator.allocateSeats(details,examId);
        	response.sendRedirect("homePage.jsp?message=examAppliedSuccessfully");
        }
        else {
        	response.sendRedirect("homePage.jsp?message=examApplicationUnSuccessfull");
        }

        if (passportPhoto != null) passportPhoto.close();
        if (digitalSignature != null) digitalSignature.close();
        if (qualificationDocuments != null) qualificationDocuments.close();
        
    }

    private void handleExamApplication(HttpServletRequest request, HttpServletResponse response, UserDetails userDetail) throws ServletException, IOException {
        String fullName = request.getParameter("full_name");
        String gender = request.getParameter("gender");
        String dobString = request.getParameter("dob");
        String qualification = request.getParameter("qualification");
        String address = request.getParameter("address");
        String nativeCity = request.getParameter("native_city");
        String state = request.getParameter("state");
        String aadharNumber = request.getParameter("aadhar_number");
        String cityPreference1 = request.getParameter("city_preference_1");
        String cityPreference2 = request.getParameter("city_preference_2");
        String cityPreference3 = request.getParameter("city_preference_3");
        
        String examId = request.getParameter("examId");
        System.out.println("examId - " + examId);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date dob = null;
        try {
            dob = dateFormat.parse(dobString);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        userDetail.setName(fullName);
        userDetail.setGender(gender.charAt(0)); 
        userDetail.setDob(dob);
        userDetail.setQualification(qualification);
        userDetail.setAddress(address);
        userDetail.setNativeCity(nativeCity);
        userDetail.setState(state);
        userDetail.setAadharNumber(aadharNumber);
        userDetail.setCityPreference1(cityPreference1);
        userDetail.setCityPreference2(cityPreference2);
        userDetail.setCityPreference3(cityPreference3);

        System.out.println("Full Name: " + fullName);
        System.out.println("Gender: " + gender);
        System.out.println("Date of Birth: " + dob);
        System.out.println("Qualification: " + qualification);
        System.out.println("Address: " + address);
        System.out.println("Native City: " + nativeCity);
        System.out.println("State: " + state);
        System.out.println("Aadhar Number: " + aadharNumber);
        System.out.println("City Preference 1: " + cityPreference1);
        System.out.println("City Preference 2: " + cityPreference2);
        System.out.println("City Preference 3: " + cityPreference3);

        System.out.println("Roll No: " + userDetail.getRollNo());
        System.out.println("Role ID: " + userDetail.getRoleId());
        System.out.println("full name" + userDetail.getName());
        System.out.println("Gender: " + userDetail.getGender());
        HttpSession session = request.getSession();
        session.setAttribute("userDetails", userDetail);
        session.setAttribute("examId",examId);
        response.sendRedirect("documentsUploadPage.jsp?examId="+examId);
        
        System.out.println("from apply exam");
    }

}
