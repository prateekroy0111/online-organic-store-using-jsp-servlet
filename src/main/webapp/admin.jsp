<%@page import="com.mycompany.organic.entities.*"%>
<%@page import="com.mycompany.organic.dao.*"%>
<%@page import="java.util.Map"%>
<%@page import="com.mycompany.organic.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.organic.helper.FactoryProvider"%>
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You're not logged in ! Login first !!");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You're not admin ! you're not allowed to access this page !!");
            response.sendRedirect("login.jsp");
            return;
        }
    }

    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cdao.getCategories();

    //getting count
    Map<String, Long> m = Helper.getCounts(FactoryProvider.getFactory());

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>
        <style>
            .modal {
                overflow-y:auto;
            }
        </style>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container admin">
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>
            </div>
            <!-- first row -->
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center" data-toggle="modal" data-target="#viewAllUsersModal">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/team.png" alt="alt"/>
                            </div>
                            <h1><%= m.get("UserCount")%></h1>
                            <h1 class="text-uppercase text-muted">Users</h1>
                            <p class="mt-2">click here to VIEW ALL USERS</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center" data-toggle="modal" data-target="#viewAllCategoriesModal">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/list.png" alt="alt"/>
                            </div>
                            <h1><%= list.size()%></h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>
                            <p class="mt-2">click here to VIEW ALL CATEGORIES</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center" data-toggle="modal" data-target="#viewAllProductsModal">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/natural.png" alt="alt"/>
                            </div>
                            <h1><%= m.get("ProdCount")%></h1>
                            <h1 class="text-uppercase text-muted">Products</h1>
                            <p class="mt-2">click here to VIEW ALL PRODUCTS</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- second row -->
            <div>
                <div class="row mt-3">
                    <div class="col-md-6">
                        <div class="card" data-toggle="modal" data-target="#addCategoryModal">
                            <div class="card-body text-center">
                                <div class="container">
                                    <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/add.png" alt="alt"/>
                                </div>
                                <p class="mt-2">click here to add new Category</p>
                                <h1 class="text-uppercase text-muted">Add Category</h1>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card" data-toggle="modal" data-target="#addProductModal">
                            <div class="card-body text-center">
                                <div class="container">
                                    <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/addproduct.png" alt="alt"/>
                                </div>
                                <p class="mt-2">click here to add new Product</p>
                                <h1 class="text-uppercase text-muted">Add Product</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Product modal -->
        <!-- Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Add Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="addproduct">
                            <div class="form-group">
                                <label for="ProdTitle">Product Name:</label>
                                <input type="text" class="form-control" name="ProdTitle" id="ProdTitle" value="" required />
                            </div>
                            <div class="form-group">
                                <label for="ProdDescp">Product Description:</label>
                                <textarea style="height: 100px" class="form-control" name="ProdDescp" id="ProdDescp" required ></textarea>
                            </div>
                            <div class="form-group">
                                <label for="ProdImg">Upload Image of the Product:</label>
                                <br><input type="file" id="picid" class="form-control" name="ProdImg" id="ProdImg" value="" required title="Upload the Product Picture again"/>
                            </div>
                            <div class="form-group">
                                <label for="ProdPrice">Product Price:</label>
                                <input type="number" class="form-control" name="ProdPrice" id="ProdPrice" value="" required />
                            </div>
                            <div class="form-group">
                                <label for="ProdDiscount">Product Discount (if any):</label>
                                <input type="number" class="form-control" id="ProdDiscount" name="ProdDiscount" value="" />
                            </div>
                            <div class="form-group">
                                <label for="ProdQuantity">Product Quantity:</label>
                                <input type="number" class="form-control" id="ProdQuantity" name="ProdQuantity" value="" required />
                            </div>
                            <div class="form-group">
                                <label for="catid">Product Category:</label>
                                <select name="catId" id="catid" required>
                                    <option value="">-----------SELECT-----------</option>
                                    <%
                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCategoryId()%>"><%= c.getCategoryName()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Product</button>
                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- comment End Product Modal-->

        <!-- View All Products Modal -->
        <!-- Modal -->
        <div class="modal fade" id="viewAllProductsModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">View All Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">Product Id</th>
                                    <th scope="col">Product Name</th>
                                    <th scope="col">Product Price</th>
                                    <th scope="col">Product Quantity</th>
                                    <th scope="col">Product Category</th>
                                    <th scope="col">Edit</th>
                                    <th scope="col">Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    //out.println(c);
                                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                                    List<Product> listProduct = null;
                                    listProduct = pdao.getAllProducts();
                                    for (Product pro : listProduct) {
                                %>
                                <tr>
                                    <td scope="row"><%= pro.getpId()%></td>
                                    <td><%= pro.getpName()%></td>
                                    <td><%= pro.getpPrice()%></td>
                                    <td><%= pro.getpQuantity()%></td>
                                    <td><%= pro.getCategory().getCategoryName()%></td>
                                    <td>
                                        <a href="" data-product-id="<%= pro.getpId()%>" data-toggle="modal" data-target="#editProductModal" data-dismiss="modal" class="btn btn-warning" id="edit-product">Edit</a>
                                    </td>  
                                    <td>
                                        <a href="DeleteProductServlet?productID=<%= pro.getpId()%>" class="btn btn-danger">Delete</a>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- comment End View All Products Modal-->

        <!-- Edit Products Modal -->
        <!-- Modal -->
        <div class="modal fade" id="editProductModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Edit Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="editProductForm" action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="productID" value="">
                            <input type="hidden" name="operation" value="updateProduct">
                            <div class="form-group">
                                <label for="ProdTitle">Product Name:</label>
                                <input type="text" class="form-control" name="ProdTitle" id="ProdTitle" value="" required />
                            </div>
                            <div class="form-group">
                                <label for="ProdDescp">Product Description:</label>
                                <textarea style="height: 100px" class="form-control" name="ProdDescp" id="ProdDescp" required ></textarea>
                            </div>
                            <div class="form-group">
                                <label for="ProdImg">Upload Image of the Product:</label>
                                <br><input type="file" id="picid" class="form-control" name="ProdImg" id="ProdImg" value="" title="Upload the Product Picture again" required/>
                            </div>
                            <div class="form-group">
                                <label for="ProdPrice">Product Price:</label>
                                <input type="number" class="form-control" name="ProdPrice" id="ProdPrice" value="" required />
                            </div>
                            <div class="form-group">
                                <label for="ProdDiscount">Product Discount (if any):</label>
                                <input type="number" class="form-control" id="ProdDiscount" name="ProdDiscount" value="" />
                            </div>
                            <div class="form-group">
                                <label for="ProdQuantity">Product Quantity:</label>
                                <input type="number" class="form-control" id="ProdQuantity" name="ProdQuantity" value="" required />
                            </div>
                            <div class="form-group">
                                <label for="catid">Product Category:</label>
                                <select name="catId" id="catid" required>
                                    <option value="">-----------SELECT-----------</option>
                                    <%
                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCategoryId()%>"><%= c.getCategoryName()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Update Product Details</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- comment End View All Products Modal-->

        <!-- Add category modal -->
        <!-- Modal -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Add Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addcategory">
                            <div class="form-group">
                                <label for="CatTitle">Category Name:</label>
                                <input type="text" class="form-control" id="CatTitle" name="CatTitle" placeholder="Enter title of category" required />
                            </div>
                            <div class="form-group">
                                <label for="CatDescp">Category Description:</label>
                                <textarea style="height: 200px" class="form-control" id="CatDescp" name="CatDescp" placeholder="Enter description of category" required ></textarea>
                            </div>
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- comment End category Modal-->
        
        <!-- Edit category modal -->
        <!-- Modal -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Edit Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" id="editCategoryForm" name="editCategoryForm">
                            <input type="hidden" name="operation" value="updateCategory">
                            <input type="hidden" name="categoryID" id="categoryID">
                            <div class="form-group">
                                <label for="CatTitle">Category Name:</label>
                                <input type="text" class="form-control" id="CatTitle" name="CatTitle" required />
                            </div>
                            <div class="form-group">
                                <label for="CatDescp">Category Description:</label>
                                <textarea style="height: 200px" class="form-control" id="CatDescp" name="CatDescp" required ></textarea>
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
        <!-- comment End Edit category Modal-->

        <!-- View All Categories Modal -->
        <!-- Modal -->
        <div class="modal fade" id="viewAllCategoriesModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">View All Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">Category Id</th>
                                    <th scope="col">Category Name</th>
                                    <th scope="col">Category Description</th>
                                    <th scope="col">Edit</th>
                                    <th scope="col">Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                    //out.println(c);
//                                    List<Category> listCategories = null;
//                                    listCategories                      
                                    for (Category cat : list) {
                                %>
                                <tr>
                                    <td scope="row"><%= cat.getCategoryId()%></td>
                                    <td><%= cat.getCategoryName()%></td>
                                    <td><%= cat.getCategoryDescp()%></td>
                                    <td>
                                        <a href="" data-category-id="<%= cat.getCategoryId()%>" data-toggle="modal" data-target="#editCategoryModal" data-dismiss="modal" class="btn btn-warning" id="edit-category">Edit</a>
                                    </td>  
                                    <td>
                                        <a href="DeleteCategoryServlet?catId=<%= cat.getCategoryId()%>" class="btn btn-danger">Delete</a>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- comment End view all category Modal-->

        <!-- View All User Modal -->
        <!-- Modal -->
        <div class="modal fade" id="viewAllUsersModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">View All User Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">User Id</th>
                                    <th scope="col">User Name</th>
                                    <th scope="col">User Email</th>
                                    <th scope="col">User Phone</th>
                                    <th scope="col">User Address</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    //out.println(c);
                                    UserDao udao = new UserDao(FactoryProvider.getFactory());
                                    List<User> listUser = null;
                                    listUser = udao.getAllUsers();
                                    for (User usr : listUser) {
                                %>
                                <tr>
                                    <td scope="row"><%= usr.getUserId()%></td>
                                    <td><%= usr.getUserName()%></td>
                                    <td><%= usr.getUserMail()%></td>
                                    <td><%= usr.getUserPhone()%></td>
                                    <td><%= usr.getUserAddress()%></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- comment End View All Products Modal-->

        <%@include file="components/common_modals.jsp"%>
        <script src="js/ajaxJS.js"></script>
    </body>
</html>
