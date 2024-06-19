<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.manage.model.UserDetails"%>
<%@ page import="com.manage.dao.DbManager"%>
<%@ page import="java.util.Base64"%>

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
        max-width: 100%;
    }
    .form-container h2 {
        margin-bottom: 20px;
    }
    .document-preview {
        max-width: 150px;
        max-height: 150px;
        object-fit: cover;
    }
    .pdf-preview {
        width: 100%;
        height: 300px;
    }
    .hidden-form {
        display: none;
    }
    @media (min-width: 768px) {
        .form-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            align-items: flex-start;
        }
        .form-container .row {
            width: 100%;
        }
        .form-container .col-md-4 {
            flex: 0 0 33.3333%;
            max-width: 33.3333%;
        }
        .form-container .form-group {
            margin-bottom: 1rem;
        }
        .form-container .justify-content-end {
            justify-content: flex-end;
        }
        .form-container .hidden-form {
            margin-top: 1.5rem;
        }
    }
</style>

</head>
<body>
<%
UserDetails userDetail = (UserDetails) session.getAttribute("userDetails");
DbManager manage = new DbManager();
boolean docExists = manage.getExamDocById(userDetail);
session.setAttribute("userDetails",userDetail);
String examId = request.getParameter("examId");
%>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="form-container d-flex flex-column align-items-center align-items-lg-start">
                <h2>Upload Documents</h2>
                <% if (docExists) { %>
                    <div class="alert alert-success" role="alert">
                        Documents already uploaded. You can view or re-upload them if necessary.
                    </div>
                    <div class="d-flex flex-wrap justify-content-center justify-content-lg-start">
                        <div class="col-md-4 mb-4">
                            <div class="form-group">
                                <label for="passportPhoto">Passport Size Photo</label>
                                <img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(userDetail.getPassportSizePhoto()) %>" class="img-thumbnail document-preview" alt="Passport Photo">
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="form-group">
                                <label for="digitalSignature">Digital Signature</label>
                                <img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(userDetail.getDigitalSignature()) %>" class="img-thumbnail document-preview" alt="Digital Signature">
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="form-group">
                                <label for="qualificationDocuments">Qualification Documents</label>
                                <embed src="data:application/pdf;base64,<%= Base64.getEncoder().encodeToString(userDetail.getQualificationDocuments()) %>" type="application/pdf" class="pdf-preview" />
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-end mt-3">
                        <button type="button" class="btn btn-primary mr-2" onclick="toggleUpdateForm()">Update Documents</button>
                            <input type="hidden" name="examId" value="<%= examId %>">
                            <a href="ApplicationPreview.jsp?examId=<%= examId %>" class="btn btn-success">Next</a>
                    </div>
                    <div id="updateForm" class="hidden-form mt-3">
                        <form id="documentUpdateForm" action="ApplyExamServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                            <div class="form-group">
                                <label for="updatePassportPhoto">Passport Size Photo</label>
                                <input type="file" class="form-control-file" id="updatePassportPhoto" name="updatePassportPhoto">
                            </div>
                            <div class="form-group">
                                <label for="updateDigitalSignature">Digital Signature</label>
                                <input type="file" class="form-control-file" id="updateDigitalSignature" name="updateDigitalSignature">
                            </div>
                            <div class="form-group">
                                <label for="updateQualificationDocuments">Qualification Documents</label>
                                <input type="file" class="form-control-file" id="updateQualificationDocuments" name="updateQualificationDocuments">
                            </div>
                            <div class="d-flex justify-content-end">
                                <input type="hidden" name="action1" value="updateDoc"> 
                                <input type="hidden" name="examId" value="<%= examId %>">
                                <button type="submit" class="btn btn-primary">Save Updates</button>
                            </div>
                        </form>
                    </div>
                <% } else { %>
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
                            <a href="applyExam.jsp?examId=<%= examId %>" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
                            <button type="submit" class="btn btn-success">Next <i class="fas fa-arrow-right"></i></button>
                        </div>
                    </form>
                <% } %>
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

    function validateUpdateForm() {
        var updatePassportPhoto = document.getElementById('updatePassportPhoto').files[0];
        var updateDigitalSignature = document.getElementById('updateDigitalSignature').files[0];
        var updateQualificationDocuments = document.getElementById('updateQualificationDocuments').files[0];

        if (!updatePassportPhoto && !updateDigitalSignature && !updateQualificationDocuments) {
            alert("At least one document must be selected for update.");
            return false;
        }
        return true;
    }

    function toggleUpdateForm() {
        var updateForm = document.getElementById('updateForm');
        if (updateForm.style.display === "none" || updateForm.style.display === "") {
            updateForm.style.display = "block";
        } else {
            updateForm.style.display = "none";
        }
    }
</script>
</body>
</html>
