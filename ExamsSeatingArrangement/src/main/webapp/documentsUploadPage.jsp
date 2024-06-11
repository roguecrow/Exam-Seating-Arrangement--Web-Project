<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.manage.model.UserDetails"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Documents</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
    body {
        background-color: #f8f9fa;
    }
    .form-container {
        background-color: #fff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin-top: 50px;
    }
    .form-container h2 {
        margin-bottom: 20px;
    }
</style>
</head>
<body>
<%
UserDetails userDetail = (UserDetails) session.getAttribute("userDetails");
String examId = request.getParameter("examId");
%>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="form-container">
                <h2>Upload Documents</h2>
                <form id="documentUploadForm" action="ApplyExamServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                   
                    <div class="form-group">
                        <label for="passportPhoto">Passport Size Photo</label>
                        <input type="file" class="form-control-file" id="passportPhoto" name="passportPhoto" required>
                    </div>
                    <div class="form-group">
                        <label for="digitalSignature">Digital Signature</label>
                        <input type="file" class="form-control-file" id="digitalSignature" name="digitalSignature" required>
                    </div>
                    <div class="form-group">
                        <label for="qualificationDocuments">Qualification Documents</label>
                        <input type="file" class="form-control-file" id="qualificationDocuments" name="qualificationDocuments" required>
                    </div>
                    <div class="d-flex justify-content-between">
                        <input type="hidden" name="action1" value="uploadDoc">
                        <a href="applyExam.jsp?examId=<%=examId%>" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
                        <button type="submit" class="btn btn-success">Next <i class="fas fa-arrow-right"></i></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>
    function validateForm() {
        var passportPhoto = document.getElementById('passportPhoto').files[0];
        var digitalSignature = document.getElementById('digitalSignature').files[0];
        var qualificationDocuments = document.getElementById('qualificationDocuments').files[0];

        if (!passportPhoto || !digitalSignature || !qualificationDocuments) {
            alert("All fields are required.");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
