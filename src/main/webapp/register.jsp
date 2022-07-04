

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
        <%@include file="components/common_css_js.jsp" %>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid">
            <div class="col-md-4 offset-md-4 mt-5">

                <div class="card">
                    <%@include file="components/message.jsp" %>
                    <div class="card-body px-5"> 
                        <h3 class="text-center">Sign Up Here</h3>
                        <form action="RegisterServlet" method="post">
                            <div class="form-group">
                                <label for="name">User Name</label>
                                <input name="user_name" type="text" class="form-control" id="name" placeholder="Enter Your Name:" required>
                            </div>
                            <div class="form-group">
                                <label for="email">User E-mail</label>
                                <input type="email" name="user_email" class="form-control" id="email" placeholder="Enter Your E-mail:" required>
                            </div>
                            <div class="form-group">
                                <label for="Password">User Password</label>
                                <input type="password" name="user_pass" class="form-control" id="Password" placeholder="Enter Your Password:" required>
                            </div>
                            <div class="form-group">
                                <label for="phone" >User phone</label>
                                <input type="text" name="user_phone" class="form-control" id="phone" placeholder="Enter Your Phone No:" required  pattern="[7-9]{1}[0-9]{9}" 
                                       title="Phone number starting with 7-9 and remaning 9 digit with 0-9">
                            </div>
                            <div class="form-group">
                                <label for="address">User Address</label>
                                <textarea name="user_add" style="height: 175px" class="form-control" placeholder="Enter Your Address" required></textarea>
                            </div>
                            <div class="container text-center" >
                                <button class="btn btn-outline-success">Register</button>
                                <button class="btn btn-outline-warning">Reset</button>
                            </div>
                        </form> 
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
