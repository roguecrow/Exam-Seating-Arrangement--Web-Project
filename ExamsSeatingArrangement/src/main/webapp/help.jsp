<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Help - ExamEase Portal</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<%
    request.setAttribute("currentPage", "otherPage");
%>
<jsp:include page="navbar.jsp" />
<!-- Rest of your other page content -->

<style>
    body {
        background-color: #f8f9fa;
        color: #343a40;
        font-family: 'Arial', sans-serif;
    }
    .container {
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        padding: 20px;
        margin-top: 30px;
    }
    h1 {
        color: #007bff;
        margin-bottom: 20px;
    }
    .form-group {
        margin-bottom: 15px;
    }
    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
    }
    
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

    .custom-navbar {
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        background-color: #ffffff;
    }

    .navbar-nav .nav-link:hover {
        color: blue;
    }
    
</style>
</head>
<body>
<!-- Main Content -->
<div class="container">
  <h1>Help & Support</h1>
  <p>If you are facing any issues with the seating arrangement or have any other queries, please contact us using the form below or reach out via email.</p>
  
  <h2>Contact Form</h2>
  <form action="SendContactEmailServlet" method="POST">
    <div class="form-group">
      <label for="userName">Name:</label>
      <input type="text" class="form-control" id="userName" name="userName" required>
    </div>
    <div class="form-group">
      <label for="userEmail">Email:</label>
      <input type="email" class="form-control" id="userEmail" name="userEmail" required>
    </div>
    <div class="form-group">
      <label for="issueType">Issue Type:</label>
      <select class="form-control" id="issueType" name="issueType" required>
        <option value="Seating Arrangement">Seating Arrangement</option>
        <option value="Application Process">Application Process</option>
        <option value="Payment Issues">Payment Issues</option>
        <option value="Other">Other</option>
      </select>
    </div>
    <div class="form-group">
      <label for="message">Message:</label>
      <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>

  <h2>Contact Information</h2>
  <p>If you prefer, you can also reach us at:</p>
  <ul>
    <li><strong>Email:</strong> <a href="mailto:admin@examease.com">admin@examease.com</a></li>
    <li><strong>Phone:</strong> +1-800-555-1234</li>
    <li><strong>Address:</strong> 123 ExamEase Street, Education City, EC 12345</li>
  </ul>
</div>

<script>
    $(function() {
    });
</script>
</body>
</html>
