<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.manage.model.UserDetails"%>
<%@ page import="com.manage.model.ExamDetails"%>
<%@ page import="com.manage.dao.DbManager"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import= "java.util.ArrayList" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="HomePageStyles.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script defer
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<title>Home Screen</title>
<style>
.profile-dropdown {
	margin-right: 20px;
}

.profile-container {
	display: flex;
	align-items: center;
	border-radius: 20px;
	background-color: #f8f9fa;
	border: 1px solid #ddd;
	padding: 5px 10px;
	color: black;
}

.profile-container:hover {
	color: blue;
}

.profile-icon {
	font-size: 1.5em;
	border-radius: 50%;
	padding: 5px;
	background-color: #fff;
	margin-right: 10px;
}

.username {
	font-size: 1em;
	font-weight: bold;
}

.dropdown-item i {
	margin-right: 10px;
}

.navbar-nav {
	margin-left: 20px;
}

.container-wrapper {
	padding: 20px;
	height: calc(100vh - 72px);
}

.left-container, .right-container {
	height: 100%;
}

.left-container {
	position: relative;
	border-radius: 8px;
	flex: 2;
	background-color: #ffffff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin-right: 20px;
	overflow-y: auto;
	display: flex;
    flex-direction: column;
}



.card {
	margin-bottom: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s, box-shadow 0.3s;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
	cursor: pointer;
}

.card-body {
	padding: 20px;
}

.card-title {
	font-size: 20px;
	margin-bottom: 10px;
}

.card-text {
	font-size: 16px;
}

.add-exam-button {
	position: absolute;
	top: 20px;
	right: 20px;
}

.right-container {
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	flex: 1;
	background-color: #ffffff;
	padding: 20px;
	overflow-y: auto;
	transition: box-shadow 0.3s;
}

.right-container:hover {
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
}

#examDetails {
	background-color: #f8f9fa;
	border-radius: 8px;
	padding: 15px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	transition: background-color 0.3s;
}

#examDetails h2 {
	font-size: 24px;
	margin-bottom: 15px;
	color: #333;
}

#examDetails p {
	font-size: 16px;
	line-height: 1.5;
	color: #666;
}

#examDetails:hover {
	background-color: #e9ecef;
}

.search-form {
	margin-left: 70px;
	width: 400px;
}

.search-bar {
	border-radius: 20px;
}

.submit-button {
	border-radius: 20px;
}

.btn-black {
	color: #000;
	background-color: #0000;
	border-color: #000;
}

.btn-black:hover {
	color: #fff;
	background-color: #000;
	border-color: #000;
}

body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: whitesmoke;
}

.navbar-brand img {
	margin-left: 10px;
	width: 100px;
	height: auto;
	filter: brightness(0%) contrast(100%);
}

.custom-navbar {
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
	background-color: #ffffff;
}

.navbar-nav .nav-link:hover {
	color: blue;
}

.update-button, .apply-now-button {
	position: absolute;
	bottom: 20px;
	right: 20px;
}

.alert {
	position: fixed;
	top: 20px;
	right: 20px;
	z-index: 1000;
	width: 300px;
	transition: opacity 0.5s ease-in-out;
}

.alert.show {
	opacity: 1;
}

.card-body {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.card-text {
	padding-right: 60px;
}

.edit-btn {
	border-radius: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	width: 50px; 
	height: 100%; 
	position: absolute; 
	right: 0;
	top: 0;
	bottom: 0;
}

.no-exams-message {
	height: 100vh;
}
#showAllExamsBtn {
    align-self: flex-left; 
    margin-left:120px;
    position: absolute;
}
.badge {
padding: 6px;
}

</style>

</head>
<body>
<%
    request.setAttribute("currentPage", "homePage");
%>
<jsp:include page="navbar.jsp" />

    <%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    if (session == null || session.getAttribute("userDetails") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    DbManager manage = new DbManager();
    UserDetails userDetails = (UserDetails) session.getAttribute("userDetails");
    String userName = userDetails != null ? userDetails.getUsername() : "User";
    int roleId = userDetails != null ? userDetails.getRoleId() : 1;
    int examId = 0;
    List<ExamDetails> exams = (List<ExamDetails>) session.getAttribute("exams");
    List<Integer> appliedExams = manage.getExamIdsForRollNo(userDetails.getRollNo());
    %>

    <div id="alertMessage" class="alert" role="alert"></div>
    <div class="container-fluid container-wrapper">
        <div class="row h-100">
            <div class="col-lg-8 col-md-7 col-sm-12 left-container">
                <% if (roleId == 0) { %>
                <a href="addExam.jsp" class="btn btn-primary add-exam-button">Add New Exam</a>
                <% } %>
                <h2>Exams</h2>
                <button id="showAllExamsBtn" class="btn btn-outline-secondary">Show All</button>
                <%
                if (exams != null && !exams.isEmpty()) {
                    for (ExamDetails exam : exams) {
                        boolean isApplied = appliedExams.contains(exam.getExamId());
                %>
                <div class="card <%= isApplied ? "applied-exam" : "" %>" id="exam<%=exam.getExamId()%>">
                    <div class="card-body">
                        <div>
                            <h5 class="card-title"><%=exam.getExamName()%></h5>
                            <p class="card-text"><%=exam.getDescription()%></p>
                        </div>
                        <%
                        if (roleId == 0) {
                        %>
                        <button class="btn btn-light edit-btn" data-toggle="modal"
                            data-target="#updateExamModal"
                            data-exam-id="<%=exam.getExamId()%>"
                            data-exam-name="<%=exam.getExamName()%>"
                            data-exam-date="<%=exam.getExamDate()%>"
                            data-application-start="<%=exam.getApplicationStartDate()%>"
                            data-application-end="<%=exam.getApplicationEndDate()%>">
                            <i class="fa fa-pencil"></i>
                        </button>
                        <%
                        }
                        %>
                        <% if (isApplied) { %>
                        <span class="badge badge-success">Applied</span>
                        <% } %>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="no-exams-message d-flex justify-content-center align-items-center" style="height: 100%;">
                    <h4>No exams to show</h4>
                </div>
                <%
                }
                %>
            </div>
            <div class="col-lg-4 col-md-5 col-sm-12 right-container">
                <div id="examDetails">
                    <h2>Exam Details</h2>
                    <p>Select an exam to view details.</p>
                </div>
                <% if (roleId != 0) { %>
                <a id="applyNowButton" href="#" class="btn btn-primary btn-lg apply-now-button">Apply Now</a>
                <% } %>
            </div>
        </div>
    </div>

    <div class="modal fade" id="updateExamModal" tabindex="-1" role="dialog" aria-labelledby="updateExamModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateExamModalLabel">Update Exam Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="updateExamForm" action="UpdateExamServlet" method="post">
                        <input type="hidden" id="examIdInput" name="examId">
                        <div class="form-group">
                            <label for="examName">Exam Name</label>
                            <input type="text" class="form-control" id="examName" name="examName" readonly>
                        </div>
                        <div class="form-group">
                            <label for="examDate">Exam Date</label>
                            <input type="date" class="form-control" id="examDate" name="examDate" required>
                            <small id="examDateError" class="form-text text-danger"></small>
                        </div>
                        <div class="form-group">
                            <label for="applicationStart">Application Start Date</label>
                            <input type="date" class="form-control" id="applicationStart" name="applicationStart" required>
                            <small id="applicationStartError" class="form-text text-danger"></small>
                        </div>
                        <div class="form-group">
                            <label for="applicationEnd">Application End Date</label>
                            <input type="date" class="form-control" id="applicationEnd" name="applicationEnd" required>
                            <small id="applicationEndError" class="form-text text-danger"></small>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" form="updateExamForm">Save Changes</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(function() {
            $("#nav-placeholder").load("navbar.jsp");
            
            $(".card").click(function() {
                var examId = $(this).attr("id").substring(4);
                var isApplied = $(this).hasClass("applied-exam");
                if (isApplied) {
                    $("#applyNowButton").hide();
                } else {
                    $("#applyNowButton").attr("href", "applyExam.jsp?examId=" + examId).show();
                }

                $("#examIdInput").val(examId);

                $.ajax({
                    url: "GetExamDetailsServlet",
                    method: "GET",
                    data: { examId: examId },
                    success: function(response) {
                        $("#examDetails").html(response);
                        $("#updateButton").data("exam-id", examId).show();
                    },
                    error: function(xhr, status, error) {
                        console.error("Error retrieving exam details:", error);
                    }
                });
            });

            var message = "<%= request.getParameter("message") %>";
            var type = "<%= request.getParameter("type") %>";
            if (message) {
                var alertMessage = "";

                if (message === "examAddedSuccessfully") {
                    alertMessage = "Exam added successfully!";
                    type = "success";
                } else if (message === "errorAddingExam") {
                    alertMessage = "Something went wrong. Please try again later.";
                } else if (message === "examUpdatedSuccessfully") {
                    alertMessage = "Exam updated successfully!";
                    type = "success";
                } else if (message === "errorUpdatingExam") {
                    alertMessage = "Error updating exam. Please try again later.";
                } else if (message === "examAppliedSuccessfully") {
                    alertMessage = "Exam applied successfully!";
                    type = "success";
                } else if (message === "examApplicationUnSuccessfull") {
                    alertMessage = "Exam application unsuccessful. Please try again later.";
                }

                showAlert(alertMessage, type);
            }

            function showAlert(message, type) {
                if (message) {
                    var alertElement = $('#alertMessage');
                    alertElement.text(message);
                    if (type === 'success') {
                        alertElement.removeClass('alert-danger').addClass('alert-success');
                    } else {
                        alertElement.removeClass('alert-success').addClass('alert-danger');
                    }
                    alertElement.addClass('show');
                    setTimeout(function() {
                        alertElement.fadeOut('slow', function() {
                            $(this).remove();
                        });
                    }, 3000);
                }
            }

            $('#updateExamModal').on('show.bs.modal', function(event) {
                var button = $(event.relatedTarget);
                var examId = button.data('exam-id');
                var examName = button.data('exam-name');
                var examDate = button.data('exam-date');
                var applicationStart = button.data('application-start');
                var applicationEnd = button.data('application-end');
                console.log("Exam Date:", examDate);
                console.log("Application Start:", applicationStart, "Application End:", applicationEnd);

                var modal = $(this);
                modal.find('#examIdInput').val(examId);
                modal.find('#examName').val(examName);
                modal.find('#examDate').val(examDate);
                modal.find('#applicationStart').val(applicationStart);
                modal.find('#applicationEnd').val(applicationEnd);
            });

            $('#updateExamForm').submit(function(event) {
                console.log("Form submitted");

                var examDate = $('#examDate').val();
                var applicationStart = $('#applicationStart').val();
                var applicationEnd = $('#applicationEnd').val();

                console.log("Exam Date:", examDate);
                console.log("Application Start:", applicationStart);
                console.log("Application End:", applicationEnd);

                var threeDaysFromToday = new Date();
                threeDaysFromToday.setDate(threeDaysFromToday.getDate() + 3);
                document.getElementById('examDateError').innerText = '';
                document.getElementById('applicationStartError').innerText = '';
                document.getElementById('applicationEndError').innerText = '';
                document.getElementById('examNameError').innerText = '';

                var valid = true;

                if (new Date(applicationStart) >= new Date(applicationEnd)) {
                    document.getElementById('applicationStartError').innerText = 'The application start date should be before the application end date.';
                    valid = false;
                }
                if (new Date(applicationStart) >= new Date(examDate) || new Date(applicationEnd) >= new Date(examDate)) {
                    document.getElementById('applicationEndError').innerText = 'Both application start and end dates should be before the exam date.';
                    valid = false;
                } 
                if (new Date(examDate) < threeDaysFromToday) {
                    document.getElementById('examDateError').innerText = 'The exam date should be at least 3 days from today.';
                    valid = false;
                }

                if (!valid) {
                    event.preventDefault();
                }
            });
            
            $(document).ready(function() {
                $("#showAllExamsBtn").click(function() {
                    $.ajax({
                        url: "GetExamDetailsServlet",  
                        method: "POST",
                        success: function(response) {
                             location.reload();
                        },
                        error: function(xhr, status, error) {
                            console.error("Error retrieving all exams:", error);
                        }
                    });
                });
            });

        });
    </script>
</body>

</html>

