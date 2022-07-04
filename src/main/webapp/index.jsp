<%-- 
    Document   : index
    Created on : 19-Mar-2021, 11:58:21 am
    Author     : Dell
--%>

<%@page import="com.mycompany.organic.helper.Helper"%>
<%@page import="com.mycompany.organic.entities.Category"%>
<%@page import="com.mycompany.organic.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.organic.entities.Product"%>
<%@page import="com.mycompany.organic.dao.ProductDao"%>
<%@page import="com.mycompany.organic.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyCart-Home</title>
        <%@include file="components/common_css_js.jsp" %>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>

        <div class="container-fluid">
            <div class="row mt-3 mx-2">
                <%                    String c = request.getParameter("category");
                    //out.println(c);
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                    List<Product> list = null;

                    if (c == null || c.trim().equals("all")) {
                        list = pdao.getAllProducts();
                    } else {
                        int cid = Integer.parseInt(c.trim());
                        list = pdao.getAllProductsById(cid);
                    }

                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> l = cdao.getCategories();
                %>
                <!-- Show Categories -->
                <div class="col-md-2">
                    <div class="list-group mt-4">
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                            All Products
                        </a>
                        <%
                            for (Category cat : l) {
                        %>
                        <a href="index.jsp?category=<%= cat.getCategoryId()%>" class="list-group-item list-group-item-action">
                            <%= cat.getCategoryName()%>
                        </a>
                        <%
                            }
                        %>
                    </div>
                </div>

                <!-- Show list of products -->
                <div class="col-md-10">
                    <div class="row mt-4">
                        <div class="col-md-12">
                            <div class="card-columns">
                                <!-- traversing products-->
                                <%
                                    for (Product p : list) {
                                %>
                                <div class="card poroduct-card">
                                    <div class="container text-center">
                                        <img class="card-img-top m-2" style="max-height: 225px;  max-width:90%; width:auto;" src="img/products/<%= p.getpPhoto()%>" alt="Card image cap">
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= p.getpName()%></h5>
                                        <p class="card-text"><%= Helper.get10Words(p.getpDescp())%></p>
                                        <div class="card-footer text-center">
                                            <button class="btn custom-bg text-white" onclick="add_to_cart(<%= p.getpId()%>, '<%= p.getpName()%>', <%= p.getPriceAfterDiscount()%>)">Add to cart</button>
                                            <button class="btn btn-outline-success"> &#8377;<%= p.getPriceAfterDiscount()%>/-  <span class="text-secondary discount-lable"><%= (int) p.getpDiscount()%>% off</span></button>

                                        </div>
                                    </div>
                                </div>

                                <% }
                                    if (list.size() == 0) {
                                        out.println("<h3>No items in this category !</h3>");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Edit User Modal -->
        <!-- Modal -->
        <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Edit User Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="editUserForm" action="ProductOperationServlet" method="post">
                            <input type="hidden" name="userID">
                            <input type="hidden" name="operation" value="updateuser">
                            <div class="form-group">
                                <label for="name">User Name</label>
                                <input name="user_name" type="text" class="form-control" id="name" placeholder="Enter Your Name:" required>
                            </div>
                            <div class="form-group">
                                <label for="email">User E-mail</label>
                                <input type="email" name="user_email" class="form-control" id="email" placeholder="Enter Your E-mail:" required>
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
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Update Details</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- comment End View All Categories Modal-->
        <%@include file="components/common_modals.jsp" %>

        <script src="js/ajaxJS.js"></script>
    </body>
</html>
