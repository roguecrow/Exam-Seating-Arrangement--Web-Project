<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.manage.model.UserDetails"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Preview Details</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
.preview-container {
    background-color: #fff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-top: 50px;
}

.preview-container h2 {
    margin-bottom: 20px;
    font-weight: bold;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    font-weight: bold;
}

.form-group p {
    margin-left: 150px;
}

.btn-container {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}
</style>
</head>
<body>
    <%! 
        // Define the formatDate method
        String formatDate(Date date) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
            return dateFormat.format(date);
        }
    %>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="preview-container">
                    <h2>Preview Details</h2>
                    <%
                        UserDetails userDetail = (UserDetails) session.getAttribute("userDetails");
                        String examId = request.getParameter("examId");
                    %>
                    <div class="form-group">
                        <label><strong>Full Name:</strong></label>
                        <p><%= userDetail.getName() %></p>
                    </div>
                    <div class="form-group">
                        <label><strong>Gender:</strong></label>
                        <p><%= userDetail.getGender() %></p>
                    </div>
                    <div class="form-group">
                        <label><strong>Date of Birth:</strong></label>
                        <p><%= formatDate(userDetail.getDob()) %></p>
                    </div>
                    <div class="form-group">
                        <label><strong>Qualification:</strong></label>
                        <p><%= userDetail.getQualification() %></p>
                    </div>
                    <div class="form-group">
                        <label>Address:</label>
                        <p><%= userDetail.getAddress() %></p>
                    </div>
                    <div class="form-group">
                        <label>Native City:</label>
                        <p><%= userDetail.getNativeCity() %></p>
                    </div>
                    <div class="form-group">
                        <label>State:</label>
                        <p><%= userDetail.getState() %></p>
                    </div>
                    <div class="form-group">
                        <label>Aadhar Number:</label>
                        <p><%= userDetail.getAadharNumber() %></p>
                    </div>
                    <div class="form-group">
                        <label>City Preference 1:</label>
                        <p><%= userDetail.getCityPreference1() %></p>
                    </div>
                    <div class="form-group">
                        <label>City Preference 2:</label>
                        <p><%= userDetail.getCityPreference2() %></p>
                    </div>
                    <div class="form-group">
                        <label>City Preference 3:</label>
                        <p><%= userDetail.getCityPreference3() %></p>
                    </div>
                    <div class="form-group">
                        <label>Passport Size Photo:</label>
                        <p><img src="DocumentServlet?type=passportPhoto" alt="Passport Photo" style="max-width: 200px; max-height: 200px;"></p>
                    </div>
                    <div class="form-group">
                        <label>Digital Signature:</label>
                        <p><img src="DocumentServlet?type=digitalSignature" alt="Digital Signature" style="max-width: 200px; max-height: 200px;"></p>
                    </div>
                    <div class="form-group">
                        <label>Qualification Documents:</label>
                        <p><a href="DocumentServlet?type=qualificationDocuments" target="_blank">Download Qualification Documents</a></p>
                    </div>
                    <div class="btn-container">
                        <a href="documentsUploadPage.jsp?examId=<%= examId %>" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
                        <form action="ApplyExamServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action1" value="submitDetails">
                            <input type="hidden" name="examId" value="<%= examId %>">
                            <button type="submit" class="btn btn-success">Submit <i class="fas fa-check"></i></button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
