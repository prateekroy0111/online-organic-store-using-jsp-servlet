<%

    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You're not logged in ! Login first to access checkout page!!");
        response.sendRedirect("login.jsp");
        return;
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>checkout panel</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container">
            <div class="row">
                <div class="col-md-6 mt-5">
                    <!-- cart -->
                    <div class="card">
                        <div class="card-body">
                            <h3 class="text-center my-3"> Your Selected Items</h3>
                            <div class="cart-body">


                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mt-5">
                    <!-- form details-->
                    <div class="card">
                        <div class="card-body">
                            <h3 class="text-center my-3"> Your Details for Order</h3>
                            <form action="" method="post">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input value="<%= user.getUserMail()%>"type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" required>
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                <div class="form-group">
                                    <label for="name">Your Name</label>
                                    <input value="<%= user.getUserName()%>"type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name" required>

                                </div>
                                <div class="form-group">
                                    <label for="contact">Your Contact number</label>
                                    <input value="<%= user.getUserPhone()%>"type="text" class="form-control" id="contact" aria-describedby="emailHelp" placeholder="Enter Contact" required>

                                </div>
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <textarea class="form-control" id="address" rows="3" required><%= user.getUserAddress()%></textarea>
                                </div>
                                <div class="container text-center">
                                    <div class="form-group">
                                        <label for="payment_method">Payment Methods</label>
                                    </div>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="radio" class="form-check-input" id="payment_method" name="payment_method" value="upi" checked>UPI xyz@okhdfc
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="radio" class="form-check-input" id="payment_method" name="payment_method" value="cod">Cash on delivery
                                    </label>
                                </div>
                                <span style="color: red;">Due to pandemic we're offering only UPI payments. after payment you have to send a screenshot of that payment to 1234567890 on Whatsapp</span>

                                <div class=" form-group container text-center">
                                    <button class="btn btn-outline-success " id="" type="button"  data-toggle="modal" data-target="#checkoutModal">Order Now</button>
                                    <a class="btn btn-outline-primary " href="index.jsp">Continue Shopping</a>
                                </div>

                            </form>

                        </div>
                    </div>
                    <!-- View All Categories Modal -->
                    <!-- Modal -->
                    <div class="modal fade" id="checkoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header custom-bg text-white">
                                    <h5 class="modal-title" id="exampleModalLabel">Thank You for ordering !</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="emptyCart(); updateCart(); ">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    Your Products will be delivered at your doorstep within 2-4 days. 
                                    
                                    <script>
                                        $(document).on("click", "#checkoutButton2", function () {
                                            window.location='index.jsp';
                                            emptyCart();
                                        });
                                    </script>
                                </div>
                                <div class="modal-footer">
                                    <a class="btn btn-outline-primary " href="index.jsp" id="checkoutButton2" >Continue Shopping</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- comment End view all category Modal-->
                </div>
            </div>
        </div>

        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
