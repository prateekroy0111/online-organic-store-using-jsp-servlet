

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login - MyCart</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid " >
            <div class="row">
                <div class="col-md-4 offset-md-4">
                    <div class="card mt-3 ">
                        <div class="card-header custom-bg text-white text-center">
                            <h3>User Login</h3>

                        </div>
                        <div class="card-body">
                            <%@include file="components/message.jsp" %>
                            <form action="LoginServlet" method="post">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" required>
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="pass" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" required>
                                </div>
                                <a href="register.jsp" class="text-center d-block mb-4"> if not registered click here !</a>
                                
                                <div class="container-fluid text-center">
                                       <button type="submit" class="btn btn-primary custom-bg border-0">Submit</button>
                                       <button type="reset" class="btn btn-primary custom-bg border-0">Reset</button>
                                </div>
                            </form>
                        </div>
                        
                    </div>


                </div>
            </div>
        </div>    

    </body>
</html>
