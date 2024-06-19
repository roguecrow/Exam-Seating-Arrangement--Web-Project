<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Generate Hall Ticket - ExamEase Portal</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
    .container {
        padding: 25px;
    }
    .hall-ticket {
        border: 2px solid #007bff;
        padding: 80px;
        border-radius: 20px;
        margin: 50px;
    }
    .hall-ticket-header {
        text-align: center;
        font-weight: bold;
        font-size: 24px;
        margin-bottom: 20px;
    }
    .profile-section {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
    }
    .profile-section img {
        border-radius: 10px;
        max-height: 200px;
        max-width: 150px;
        object-fit: contain;
    }
    .details-section, .exam-section {
        margin-bottom: 20px;
    }
    .exam-section p, .details-section p {
        margin: 0;
        padding: 5px 0;
    }
    .signature-section {
        text-align: right;
        margin-bottom: 20px;
    }
    .signature-section img {
        height: 100px;
        width: 200px;
        object-fit: contain;
    }
    .dos-donts {
        font-weight: bold;
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

<%
    request.setAttribute("currentPage", "otherPage");
%>
<jsp:include page="navbar.jsp" />

<div class="container">
    <h1>Generate Exam Hall Ticket</h1>
     <form id="hallTicketForm" class="form-inline">
        <div class="form-group mb-2">
            <input type="text" class="form-control mr-2" id="serialNumber" name="serialNumber" placeholder = "Enter Serial Number"required>
        </div>
        <button type="submit" class="btn btn-primary mb-2">Submit</button>
    </form>
    <div id="errorMessage" class="text-danger mt-3"></div>
    <div id="hallTicketDetails" class="hall-ticket" style="display:none;" >
        <div class="hall-ticket-header">
            <span id="examName">Exam Name</span>
        </div>
        <div class="profile-section">
            <div class="profile-details">
                <p><strong>Name:</strong> <span id="studentName"></span></p>
                <p><strong>Roll Number:</strong> <span id="rollNumber"></span></p>
                <p><strong>Date of Birth:</strong> <span id="dob"></span></p>
                <p><strong>Address:</strong> <span id="address"></span></p>
            </div>
            <div class="profile-picture">
                <img id="profileImage" src="" alt="Profile Picture">
            </div>
        </div>
        <div class="details-section">
            <p><strong>Exam Date:</strong> <span id="examDate"></span></p>
            <p><strong>Exam Time:</strong> <span id="examTime"></span></p>
            <p><strong>City:</strong> <span id="examCity"></span></p>
            <p><strong>Venue:</strong> <span id="examVenue"></span></p>
            <p><strong>Hall:</strong> <span id="examHall"></span></p>
            <p><strong>Serial Number:</strong> <span id="serialNumberDisplay"></span></p>
        </div>
        <div class="signature-section">
            <img id="digitalSignature" src="" alt="Digital Signature">
        </div>
        <div class="dos-donts">
            <h3>Dos and Don'ts in the Exam Hall</h3>
            <p>1. Do bring your hall ticket and a valid ID proof.</p>
            <p>2. Do arrive at least 30 minutes before the exam.</p>
            <p>3. Don't bring any electronic gadgets inside the exam hall.</p>
            <p>4. Don't engage in any form of malpractice.</p>
        </div>
        <button id="downloadButton" class="btn btn-primary">Download Hall Ticket</button>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#hallTicketForm').on('submit', function(event) {
        event.preventDefault();
        var serialNumber = $('#serialNumber').val();
        $.ajax({
            url: 'GetHallTicketServlet',
            type: 'POST',
            data: { serialNumber: serialNumber },
            success: function(response) {
                if (response.error) {
                    $('#errorMessage').text(response.error);
                    $('#hallTicketDetails').hide();
                } else {
                    $('#examName').text(response.exam_name);
                    $('#studentName').text(response.name);
                    $('#rollNumber').text(response.roll_no);
                    $('#dob').text(response.dob);
                    $('#address').text(response.address);
                    $('#examDate').text(response.exam_date);
                    $('#examTime').text("10:00 AM"); // Assuming fixed time or get from response
                    $('#examCity').text(response.city);
                    $('#examVenue').text(response.venue_name);
                    $('#examHall').text(response.hall_name);
                    $('#serialNumberDisplay').text(serialNumber);
                    $('#profileImage').attr('src', 'data:image/jpeg;base64,' + response.passport_size_photo);
                    $('#digitalSignature').attr('src', 'data:image/jpeg;base64,' + response.digital_signature);
                    $('#hallTicketDetails').show();
                    $('#errorMessage').text('');
                }
            }
        });
    });

    $('#downloadButton').on('click', function() {
        var serialNumber = $('#serialNumber').val();
        window.location.href = 'DownloadHallTicketServlet?serialNumber=' + serialNumber;
    });
});
</script>

</body>
</html>
