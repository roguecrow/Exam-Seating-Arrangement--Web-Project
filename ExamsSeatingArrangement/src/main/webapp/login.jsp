<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>Login</title>
    <link rel="stylesheet" href="login.css">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const errorMessage = '<%= request.getAttribute("errorMessage") %>';
            if (errorMessage && errorMessage !== 'null') {
                alert(errorMessage);
            }
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="main-div">
                <div class="first-line">
                    <h1>Exam Portal - Login</h1>
                </div>
                <div class="second-line">
                    <h6>Sign in to apply for Exams.</h6>
                </div>
                <form id="registrationForm" action="SignInServlet" method="post">
                    <label for="email">Email:</label><br>
                    <input type="email" id="email" name="email" required><br>
                    
                    <label for="password">Password:</label><br>
                    <input type="password" id="password" name="password" required><br>

                    <input type="checkbox" id="rememberMe" name="rememberMe" checked/>            
                    <label for="rememberMe">Remember Me</label><br>
                    
                    <input type="hidden" name="action" value="signin">
                    
                    <button type="submit">Login</button><br>
                </form>
                <h5 class="sign-navigator">Don't have an Account? <a href="registerPage.jsp">Create one</a></h5>
            </div>
        </div>
        <div class="image-container">
        <h1>Lets get you an Account</h1>
            
        </div>
    </div>
</body>
</html>
