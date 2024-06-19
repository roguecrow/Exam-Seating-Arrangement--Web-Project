<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="com.manage.model.UserDetails"%>
<%@ page import="com.manage.model.ExamDetails"%>
<%@ page import="com.manage.dao.DbManager"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Exams</title>
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
    .container-wrapper {
        display: flex;
    }
    .left-container {
        flex: 0 0 40%;
        border-right: 1px solid #ddd;
        padding: 20px;
    }
    .right-container {
        flex: 1;
        padding: 20px;
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

    .list-group-item {
        cursor: pointer;
    }

    .list-group-item:hover {
        background-color: #f0f0f0;
    }

    .list-group-item.active {
        background-color: #007bff;
        border-color: #007bff;
        color: white;
    }

    .seat-grid {
        display: grid;
        grid-gap: 10px;
        margin-bottom: 20px;
    }

.seat-cell {
    width: 40px;
    height: 40px;
    background-color: #e0e0e060;
    border: 2px solid #f5f5f5;
    display: flex;
    border-radius: 10px;
    align-items: center;
    justify-content: center;
    font-size: 1em;
    font-weight: bold;
    cursor: pointer;
}

    .seat-cell.allocated {
        background-color: #007bff;
        color: white;
        border-color: #0056b3;
    }

    .venue-details-container {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 5px;
        border: 1px solid #ddd;
        margin-top: 20px;
    }

    .venue-details {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
    }

    .venue-details p {
        margin: 0;
        font-size: 1.1em;
        font-weight: bold;
    }
</style>
</head>
<body>
<%
    request.setAttribute("currentPage", "otherPage");
%>
<jsp:include page="navbar.jsp" />

<%
    DbManager manage = new DbManager();
    UserDetails userDetails = (UserDetails) session.getAttribute("userDetails");
    String userName = userDetails != null ? userDetails.getUsername() : "User";
    int roleId = userDetails != null ? userDetails.getRoleId() : 1;
    List<ExamDetails> exams = (List<ExamDetails>) session.getAttribute("exams");
    List<Integer> appliedExams = manage.getExamIdsForRollNo(userDetails.getRollNo());
%>
<div class="container-fluid container-wrapper">
    <div class="left-container">
        <h2>Applied Exams</h2>
        <ul class="list-group">
            <%
            if (exams != null && !exams.isEmpty()) {
                for (ExamDetails exam : exams) {
                    if (appliedExams.contains(exam.getExamId())) {
            %>
            <li class="list-group-item" data-exam-id="<%= exam.getExamId() %>"><%= exam.getExamName() %></li>
            <%
                    }
                }
            } else {
            %>
            <li class="list-group-item">No applied exams to show</li>
            <%
            }
            %>
        </ul>
    </div>
    <div class="right-container">
        <h2>Exam Seat Allocation</h2>
        <div id="seat-grid" class="seat-grid"></div>
        <div class="venue-details-container">
            <div id="venue-details" class="venue-details">
                <p id="serial-no"></p>
                <p id="venue-name"></p>
                <p id="hall-name"></p>
            </div>
        </div>
    </div>
</div>

<script>
    $(function() {
        $(".list-group-item").click(function() {
            $(".list-group-item").removeClass("active");
            $(this).addClass("active");

            var examId = $(this).data("exam-id");
            console.log("Selected Exam ID:", examId);

            $.ajax({
                url: 'FetchSeatAllocationServlet',
                method: 'POST',
                data: { examId: examId, rollNo: <%= userDetails.getRollNo() %> },
                success: function(response) {
                    var seatGrid = $("#seat-grid");
                    seatGrid.empty();

                    var totalCapacity = response.totalCapacity;
                    var allocatedSeat = response.allocatedSeat;
                    var venueName = response.venueName;
                    var hallName = response.hallName;
                    var serialNo = response.serialNo; // Assuming serialNo is returned by the servlet

                    var rows = Math.ceil(Math.sqrt(totalCapacity));
                    var columns = Math.ceil(totalCapacity / rows);

                    seatGrid.css('grid-template-rows', 'repeat(' + rows + ', 1fr)');
                    seatGrid.css('grid-template-columns', 'repeat(' + columns + ', 1fr)');

                    for (var i = 1; i <= totalCapacity; i++) {
                    	var seatCell = $("<div class='seat-cell'></div>").append('<i class="fas fa-chair"></i>');
                    	 if (i == allocatedSeat) {
                             seatCell.addClass("allocated").attr('data-bs-toggle', 'popover').attr('data-bs-content', 'Allocated Seat: ' + i);
                         }
                        seatGrid.append(seatCell);
                    }

                    $("#venue-name").text("Venue: " + venueName);
                    $("#hall-name").text("Hall: " + hallName);
                    $("#serial-no").text("Serial No: " + serialNo);
                    
                    $('[data-bs-toggle="popover"]').each(function () {
                        var popoverContent = $(this).attr('data-bs-content');
                        $(this).popover({
                            content: popoverContent,
                            placement: 'top', 
                            trigger: 'hover', 
                            html: true 
                        });
                    });
                }
            });
        });
    });
</script>
</body>
</html>
