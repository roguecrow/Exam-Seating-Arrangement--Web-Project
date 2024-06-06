<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.manage.model.UserDetails" %>
<%@ page import ="com.manage.model.ExamDetails" %>
<%@ page import ="com.manage.util.DbManager" %>
<%@ page import = "java.util.List"%>
<%@ page import="java.sql.SQLException" %>



<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="HomePageStyles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
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
        }
        .right-container {
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            flex: 1;
            background-color: #ffffff;
            padding: 20px;
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

    </style>
</head>
<body>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0"); 

if (session == null || session.getAttribute("userDetails") == null) {
    response.sendRedirect("login.jsp");
    return;
}

UserDetails userDetails = (UserDetails) session.getAttribute("userDetails");
String userName = userDetails != null ? userDetails.getUsername() : "User";
int roleId = userDetails != null ? userDetails.getRoleId() : 1; 
%>

<div id="alertMessage" class="alert" role="alert"></div>

<div id="nav-placeholder"></div>
<div class="container-fluid container-wrapper">
    <div class="row h-100">
        <div class="col-lg-8 col-md-7 col-sm-12 left-container">
            <% if (roleId == 0) { %>
            <a href="addExam.jsp" class="btn btn-primary add-exam-button">Add New Exam</a>
            <% } %>
            <h2>Exams</h2>
            <%
           
            DbManager dbManager = new DbManager();
            List<ExamDetails> exams = null;
            try {
            	exams = dbManager.getAllExams();
            	} catch (SQLException e) {
            		e.printStackTrace();
            		}
            if (exams != null) {
            	for (ExamDetails exam : exams) {
            	%>
            <div class="card" id="exam<%= exam.getExamId() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= exam.getExamName() %></h5>
                    <p class="card-text"><%= exam.getDescription() %></p>
                </div>
            </div>
<%
        }
    }
%>
        </div>
        <div class="col-lg-4 col-md-5 col-sm-12 right-container">
            <div id="examDetails">
                <h2>Exam Details</h2>
                <p>Select an exam to view details.</p>
            </div>
            <% if (roleId == 0) { %>
            <div class="update-button">
                <button class="btn btn-info">Update</button>
            </div>
            <% } else { %>
            <button type="button" class="btn btn-primary btn-lg apply-now-button">Apply Now</button>
           <% } %>
             
        </div>
    </div>
</div>
<div id="addExamModalPlaceholder"></div>
<script>
  $(function() {
    $("#nav-placeholder").load("navbar.jsp");

    $("#addExamModalPlaceholder").load("AddNewExamModel.jsp", function() {
        $(".card").click(function(){
            var examId = $(this).attr("id").substring(4); 
            
            $.ajax({
                url: "GetExamDetailsServlet",
                method: "GET",
                data: {examId: examId},
                success: function(response) {
                    $("#examDetails").html(response);
                },
                error: function(xhr, status, error) {
                    console.error("Error retrieving exam details:", error);
                }
            });
        });
    });

    <% String message = request.getParameter("message"); %>
    <% if (message != null) { %>
      var messageType = "";
      var alertMessage = "";

      <% if (message.equals("examAddedSuccessfully")) { %>
        messageType = "success";
        alertMessage = "Exam added successfully!";
      <% } else if (message.equals("errorAddingExam")) { %>
        messageType = "error";
        alertMessage = "Something went wrong. Please try again later.";
      <% } %>

      showAlert(alertMessage, messageType);
    <% } %>

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
  });
</script>

</body>
</html>

