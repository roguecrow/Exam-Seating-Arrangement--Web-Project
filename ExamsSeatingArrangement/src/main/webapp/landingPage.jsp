<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamEase</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f8f9fa;
        color: #343a40;
        font-family: 'Arial', sans-serif;
    }
    .container {
        padding: 10px;
        margin-top: 20px;
    }
    h1, h2 {
        color: #007bff;
    }
    .navbar {
        background-color: #ffffff; 
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        margin-bottom: 20px;
    }
    .navbar-brand {
        display: flex;
        align-items: center;
    }
    .navbar-brand img {
        margin-right: 10px;
    }
   .navbar-brand .site-title {
    color: #000000; 
    margin-left: 10px;
    font-weight: 500;
    }
    .disclaimer {
        color: red;
        font-weight: bold;
    }
    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
    }
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <img src="exam_ease_logo.png" alt="Logo" width="60" height="44" class="d-inline-block align-text-top">
      <span class="site-title">ExamEase Portal</span>
    </a>
    <div class="collapse navbar-collapse justify-content-end">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="login.jsp">Login</a>
        </li>
        <li class="nav-item ml-2">
          <a class="nav-link btn btn-outline-primary btn-register" href="registerPage.jsp">Register</a>
        </li>
      </ul>
    </div>
  </div>	
</nav>

<div class="container">
  <h1>Welcome to Competitive Exams Application Portal</h1>
  <p>Our website offers a streamlined process for applying to various competitive exams. Follow the steps below to complete your application.</p>
  
  <h2>About Our Site</h2>
  <p>We provide comprehensive information and resources to help you prepare for and apply to competitive exams. Our portal is designed to make the application process as simple and efficient as possible.</p>

  <h2>How to Apply for Exams</h2>
  <ol>
    <li><strong>Register:</strong> Create an account by clicking on the login button and filling in your details.</li>
    <li><strong>Browse Exams:</strong> Explore the list of available exams and select the one you wish to apply for.</li>
    <li><strong>Fill Application Form:</strong> Complete the application form with accurate details and upload any required documents.</li>
    <li><strong>Submit:</strong> Review your application and submit it for processing.</li>
    <li><strong>Payment:</strong> Pay the application fee through our secure payment gateway.</li>
    <li><strong>Confirmation:</strong> Receive a confirmation email with your application details and further instructions.</li>
  </ol>

  <h2>Disclaimer</h2>
  <p class="disclaimer">Please ensure that all the information provided is accurate and up-to-date. Incomplete or incorrect applications may lead to disqualification. Make sure to read all instructions carefully before submitting your application.</p>

  <div class="text-right mt-4">
    <a href="login.jsp" class="btn btn-primary">Apply for Exams</a>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
