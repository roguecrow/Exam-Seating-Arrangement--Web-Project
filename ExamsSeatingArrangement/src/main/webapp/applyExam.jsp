<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.manage.model.ExamDetails"%>
<%@ page import="com.manage.dao.DbManager"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Details Form</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
	

<style>
body {
	padding: 20px;
	background-color: #f8f9fa;
}

.form-container {
	max-width: 800px;
	margin: auto;
	padding: 20px;
	background: white;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.form-container h2 {
	text-align: left;
	margin-bottom: 20px;
	font-size: large;
}

.form-container .form-group {
	margin-bottom: 15px;
}

.form-container .form-control {
	border-radius: 5px;
}

.form-container .form-select {
	border-radius: 5px;
}

.form-container .btn-primary {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	border-radius: 5px;
}

.form-container .invalid-feedback {
	font-size: 14px;
}

.row {
	display: flex;
	justify-content: center;
}



.exam-detail-item label {
	font-weight: bold;
}
</style>
</head>
<body>
<%
String examIdParam = request.getParameter("examId");

String examName = "";
String examDate = "";
DbManager manage = new DbManager();
int examId = Integer.parseInt(examIdParam);
if (examIdParam != null && !examIdParam.isEmpty()) {
	try {
		ExamDetails examDetail = manage.getExamById(examId);
		if (examDetail != null) {
	examName = examDetail.getExamName();
	examDate = examDetail.getExamDate().toString();
		}
	} catch (NumberFormatException e) {
		out.println("Invalid exam ID.");
	}
}

List<String> cities = manage.cityLocationsForExam(examId);
System.out.println("from applyExam page = "+cities);
%>

<div class="container">
    <form action="ApplyExamServlet" method="post"> 
        <div class="row">
            <div class="col-lg-6">
                <div class="form-container p-4 mb-4">
                    <h2>Personal Details</h2>
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="full_name" required>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="gender" class="form-label">Gender</label>
                            <select class="form-select" id="gender" name="gender" required>
                                <option value="">Select</option>
                                <option value="M">Male</option>
                                <option value="F">Female</option>
                                <option value="O">Other</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="dob" class="form-label">Date of Birth</label>
                            <input type="date" class="form-control" id="dob" name="dob" required>
                        </div>
                        <div class="col-md-4">
                            <label for="age" class="form-label">Age</label>
                            <input type="text" class="form-control" id="age" name="age" readonly>
                        </div>
                    </div>
                    <div class="mb-3">
                    <label for="qualification" class="form-label">Qualification</label>
                            <select class="form-select" id="qualification" name="qualification">
                                <option value="" disabled selected>Select your qualification</option>
                                <option value="High School">High School</option>
                                <option value="Intermediate">Intermediate</option>
                                <option value="Diploma">Diploma</option>
                                <option value="Bachelor of Engineering (B.E)">Bachelor of Engineering (B.E)</option>
                                <option value="Bachelor of Technology (B.Tech)">Bachelor of Technology (B.Tech)</option>
                                <option value="Bachelor of Science (B.Sc)">Bachelor of Science (B.Sc)</option>
                                <option value="Bachelor of Commerce (B.Com)">Bachelor of Commerce (B.Com)</option>
                                <option value="Bachelor of Arts (B.A)">Bachelor of Arts (B.A)</option>
                                <option value="Bachelor of Business Administration (B.B.A)">Bachelor of Business Administration (B.B.A)</option>
                                <option value="Master of Engineering (M.E)">Master of Engineering (M.E)</option>
                                <option value="Master of Technology (M.Tech)">Master of Technology (M.Tech)</option>
                                <option value="Master of Science (M.Sc)">Master of Science (M.Sc)</option>
                                <option value="Master of Commerce (M.Com)">Master of Commerce (M.Com)</option>
                                <option value="Master of Arts (M.A)">Master of Arts (M.A)</option>
                                <option value="Master of Business Administration (M.B.A)">Master of Business Administration (M.B.A)</option>
                                <option value="Doctor of Philosophy (Ph.D)">Doctor of Philosophy (Ph.D)</option>
                            </select>
                    </div>
						<div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <textarea class="form-control" id="address" name="address" rows="3" maxlength="255" required></textarea>
                    </div>
                    <div class="text-start">
                        <a href="homePage.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">        
                <div class="form-container p-4 mb-4">
                    <div class="exam-details-container">
                        <h2>Exam Details</h2>
                        <div class="row mb-3 exam-detail-item">
                            <div class="col-md-6">
                                <label for="examName" class="form-label">Exam Name: <%= examName %></label>
                            </div>
                            <div class="col-md-6">
                                <label for="examDate" class="form-label">Exam Date: <%= examDate %></label>
                            </div>
                        </div>
                    </div>
                    <h2>Other Details</h2>   
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="nativeCity" class="form-label">Native City</label>
                            <input type="text" class="form-control" id="nativeCity" name="native_city" required>
                        </div>
                        <div class="col-md-6">
                            <label for="state" class="form-label">State</label>
                            <input type="text" class="form-control" id="state" name="state" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="aadharNumber" class="form-label">Aadhar Number</label>
                        <input type="text" class="form-control" id="aadharNumber" name="aadhar_number" pattern="\d{12}" >
                    </div>
                    <h2>City Preferences</h2>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="cityPreference1" class="form-label">City Preference 1</label>
                            <select class="form-select" id="cityPreference1" name="city_preference_1" >
                                <option value="">Select</option>
                                <% for (String city : cities) { %>
                                <option value="<%= city %>"><%= city %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="cityPreference2" class="form-label">City Preference 2</label>
                            <select class="form-select" id="cityPreference2" name="city_preference_2" >
                                <option value="">Select</option>
                                <% for (String city : cities) { %>
                                <option value="<%= city %>"><%= city %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="cityPreference3" class="form-label">City Preference 3</label>
                            <select class="form-select" id="cityPreference3" name="city_preference_3" >
                                <option value="">Select</option>
                                <% for (String city : cities) { %>
                                <option value="<%= city %>"><%= city %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="text-end">
                        <button type="submit" class="btn btn-success">Next <i class="fas fa-arrow-right"></i></button>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" id="examId" name="examId" value= "<%= examId%>">
        <input type="hidden" name="action1" value="applyExam">
    </form>
</div>


<script>

    document.addEventListener('DOMContentLoaded', function() {
        const formElements = document.querySelectorAll('.form-control, .form-select');

        formElements.forEach(element => {
             if (!element.id.startsWith('cityPreference')) {
                element.addEventListener('change', function() {
                    localStorage.setItem(element.name, element.value);
                });
            }

            const savedValue = localStorage.getItem(element.name);
            if (savedValue) {
                element.value = savedValue;
            }
        });

        document.getElementById('dob').addEventListener('change', function() {
            const dob = new Date(this.value);
            const today = new Date();
            let age = today.getFullYear() - dob.getFullYear();
            const monthDifference = today.getMonth() - dob.getMonth();
            if (monthDifference < 0 || (monthDifference === 0 && today.getDate() < dob.getDate())) {
                age--;
            }
            document.getElementById('age').value = age;

            localStorage.setItem('age', age);
        });

        const savedAge = localStorage.getItem('age');
        if (savedAge) {
            document.getElementById('age').value = savedAge;
        }
    });
    
    const cityPreference1 = document.getElementById('cityPreference1');
    const cityPreference2 = document.getElementById('cityPreference2');
    const cityPreference3 = document.getElementById('cityPreference3');

    [cityPreference1, cityPreference2, cityPreference3].forEach(cityPreference => {
        cityPreference.addEventListener('change', function() {
            const selectedCity = cityPreference.value;
            
            [cityPreference1, cityPreference2, cityPreference3].forEach(otherCityPreference => {
                if (otherCityPreference !== cityPreference) {
                    [...otherCityPreference.options].forEach(option => {
                        if (option.value === selectedCity) {
                            option.disabled = true; 
                        }
                    });
                }
            });
        });
    });

</script>

</body>
</html>
