<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400..700&family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="registerPage.css">
    <title>Registration Form</title>
    <link rel="icon" type="image/x-icon" href="C:\Users\babu3560\Desktop\Registration form\images\favicon.ico">
    <style>
        input[type="text"], 
        input[type="email"],
        input[type="password"],
        input[type="date"],
        input[type="number"], 	
        button[type="submit"] {
            width: 150%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const errorMessage = '<%= request.getAttribute("errorMessage") %>';
            if (errorMessage && errorMessage !== 'null') {
                alert(errorMessage);
            }
        });

        function validateForm() {
            var name = document.getElementById("name").value;
            var email = document.getElementById("email").value;
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var nameRegex = /^[A-Za-z\s]+$/;

            if (!nameRegex.test(name)) {
                alert("Name should contain only alphabetic characters.");
                return false;
            }

            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="image-container">
            <h1>Let's get you an Account</h1>
        </div>
        <div class="main-reg">
            <form id="registrationForm" action="SignInServlet" method="post" onsubmit="return validateForm()">
                <label for="name">Full Name:</label><br>
                <input type="text" id="name" name="name" required minlength="2" maxlength="30" placeholder="Enter your full name"><br>
                
                <label for="email">Email:</label><br>
                <input type="email" id="email" name="email" required placeholder="Enter your email"><br>
                
                <label for="password">Password:</label><br>
                <input type="password" id="password" name="password" required minlength="8" maxlength="16" placeholder="Enter your password"><br>
                
                <label for="confirmPassword">Confirm Password:</label><br>
                <input type="password" id="confirmPassword" name="confirmPassword" required minlength="8" maxlength="16" placeholder="Enter your password again"><br>
                
                <input type="hidden" name="action" value="register">
                
                <button type="submit">Register</button>
            </form>
            <h5 class="sign-navigator">Already have an Account? <a href="login.jsp">Sign In</a></h5>
        </div>
    </div>
</body>
</html>
