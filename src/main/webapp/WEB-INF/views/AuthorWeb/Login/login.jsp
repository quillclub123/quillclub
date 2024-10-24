<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Login Page QCW</title>

<!-- Font Awesome for eye icon -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Poppins');

/* BASIC */
html {
    background: url('assets/AuthorWeb/images/loginbg.jpg') no-repeat center center fixed;
    background-size: cover;
}

body {
    font-family: "Poppins", sans-serif;
    height: 100vh;
}

a {
    color: #92badd;
    display: inline-block;
    text-decoration: none;
    font-weight: 400;
}

h2 {
    text-align: center;
    font-size: 16px;
    font-weight: 600;
    display: inline-block;
    margin: 7px 8px 10px 8px;
    color: #cccccc;
}

/* STRUCTURE */
.wrapper {
    display: flex;
    align-items: center;
    flex-direction: column;
    justify-content: center;
    width: 100%;
    min-height: 100%;
    padding: 20px;
}

#formContent {
    -webkit-border-radius: 10px 10px 10px 10px;
    border-radius: 10px 10px 10px 10px;
    background: #fff;
    padding: 30px;
    width: 90%;
    max-width: 500px;
    position: relative;
    -webkit-box-shadow: 0 30px 60px 0 rgba(0, 0, 0, 0.3);
    box-shadow: 0 30px 60px 0 rgba(0, 0, 0, 0.3);
    text-align: center;
}

#formFooter {
    background-color: #f6f6f6;
    border-top: 1px solid #dce8f1;
    padding: 25px;
    text-align: center;
    -webkit-border-radius: 0 0 10px 10px;
    border-radius: 0 0 10px 10px;
}

/* TABS */
h2.inactive {
    color: #cccccc;
}

h2.active {
    color: #0d0d0d;
}

/* FORM TYPOGRAPHY */
input[type=button], input[type=submit], input[type=reset] {
    background-color: #56baed;
    border: none;
    color: white;
    padding: 15px 80px;
    text-align: center;
    display: inline-block;
    font-size: 13px;
    -webkit-box-shadow: 0 10px 30px 0 rgba(95, 186, 233, 0.4);
    box-shadow: 0 10px 30px 0 rgba(95, 186, 233, 0.4);
    border-radius: 5px;
    margin: 12px 20px 50px 20px;
    transition: all 0.3s ease-in-out;
}

input[type=button]:hover, input[type=submit]:hover, input[type=reset]:hover {
    background-color: #39ace7;
}

input[type=text], input[type=password] {
    background-color: #f6f6f6;
    border: none;
    color: #0d0d0d;
    padding: 15px 32px;
    text-align: center;
    font-size: 16px;
    margin: 15px 5px;
    width: calc(100% - 20px); /* Same width for both fields */
    border: 2px solid #f6f6f6;
    transition: all 0.5s ease-in-out;
    border-radius: 5px;
}

input[type=text]:focus, input[type=password]:focus {
    background-color: #fff;
    border-bottom: 2px solid #5fbae9;
}

/* ANIMATIONS */
.fadeInDown {
    animation-name: fadeInDown;
    animation-duration: 1.5s;
    animation-timing-function: ease-in-out;
    animation-fill-mode: both;
}

@keyframes fadeInDown {
    0% {
        opacity: 0;
        transform: translate3d(0, -50%, 0);
    }
    100% {
        opacity: 1;
        transform: none;
    }
}

/* Password Container */
.password-container {
    position: relative;
    width: calc(100% - 20px); /* Ensure same width as text input */
    margin: 20px 5px;
}

.password-container input {
    width: 100%; /* Full width inside container */
    padding-right: 40px; /* Space for eye icon */
}

.eye-icon {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #cccccc;
    font-size: 16px;
}

.eye-icon:hover {
    color: #39ace7;
}

/* OTHERS */
*:focus {
    outline: none;
}

#icon {
    width: 20%;
    height: auto;
    margin-top: 20px;
}

* {
    box-sizing: border-box;
}

#student_id-error {
    position: absolute;
    top: 48%;
    left: 9%;
    color: red;
}

#password-error {
     position: absolute;
     top: 78%;
    left: 2%;
    color: red;
}
</style>
</head>

<body>
    <div class="wrapper fadeInDown">
        <div id="formContent">
            <div class="fadeIn first">
                <img src="assets/images/QCW-Logo.jpg" id="icon" alt="User Icon" />
            </div>
            <!-- Tabs Titles -->
            <h2 class="active">Login to your account</h2>
            <!-- Login Form -->
            <form id="login_form" name="login_form" action="author_profile" method="post">
                <input type="text" id="student_id" class="fadeIn second" name="student_id" placeholder="Your ID">
                
                <div class="password-container">
                    <input type="password" id="password" class="fadeIn third" name="password" placeholder="Password">
                    <span id="togglePassword" class="eye-icon">
                        <i class="fa fa-eye" aria-hidden="true"></i>
                    </span>
                </div>
                
                <input type="submit" id="sbmt" class="fadeIn fourth" value="Log In" style="cursor: pointer;">
            </form>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
        integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js"></script>
    
    <script type="text/javascript">
        $(function() {
            $("form[name='login_form']").validate({
                rules: {
                    student_id: {
                        required: true,
                    },
                    password: {
                        required: true,
                    }
                },
                messages: {
                    student_id: {
                        required: "Please enter your ID",
                    },
                    password: {
                        required: "Please enter password"
                    }
                },
                submitHandler: function(form) {
                	$("#sbmt").val("Please Wait..");
                    var student_id = $("#student_id").val();
                    var password = $("#password").val();
                    var fd = new FormData();
                    fd.append("student_id", student_id.trim());
                    fd.append("password", password);
                    $.ajax({
                        url: 'check_login',
                        type: 'POST',
                        data: fd,
                        contentType: false,
                        processData: false,
                        success: function(data) {
                            if (data.status == 'Success') {
                            	$("#sbmt").val("Success");
                                form.submit();
                            } else {
                            	$("#sbmt").val("Invalid Credentials !!!");
                            	setTimeout(function() {
                            	    $("#sbmt").val("Log In");
                            	}, 2000);
                                
                            }
                        }
                    });
                }
            });
        });

        $('#togglePassword').on('click', function() {
            const passwordField = $('#password');
            const icon = $(this).find('i');
            if (passwordField.attr('type') === 'password') {
                passwordField.attr('type', 'text');
                icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                passwordField.attr('type', 'password');
                icon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        });
    </script>
</body>
</html>
