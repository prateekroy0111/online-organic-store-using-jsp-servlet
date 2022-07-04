package com.mycompany.organic.servlets;

import com.google.gson.Gson;
import com.mycompany.organic.dao.CategoryDao;
import com.mycompany.organic.dao.ProductDao;
import com.mycompany.organic.dao.UserDao;
import com.mycompany.organic.entities.Category;
import com.mycompany.organic.entities.Product;
import com.mycompany.organic.entities.User;
import com.mycompany.organic.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String op = request.getParameter("operation");
            if (op.trim().equals("addcategory")) {
                //fetching category data
                String title = request.getParameter("CatTitle");
                String descp = request.getParameter("CatDescp");

                Category category = new Category();
                category.setCategoryName(title);
                category.setCategoryDescp(descp);

                //save into the database
                CategoryDao categorydao = new CategoryDao(FactoryProvider.getFactory());
                int catid = categorydao.saveCategory(category);
                //out.println("Category Saved !");
                HttpSession httpsession = request.getSession();
                httpsession.setAttribute("message", "Category Added Successfully ! Category Id is:" + catid);
                response.sendRedirect("admin.jsp");
                return;
            } else if (op.trim().equals("addproduct")) {
                //add product to db
                try {
                    String pname = request.getParameter("ProdTitle");
                    String pdescp = request.getParameter("ProdDescp");
                    float pprice = Float.parseFloat(request.getParameter("ProdPrice"));
                    float pdiscount = Float.parseFloat(request.getParameter("ProdDiscount"));
                    float pquantity = Float.parseFloat(request.getParameter("ProdQuantity"));
                    int catid = Integer.parseInt(request.getParameter("catId"));
                    Part part = request.getPart("ProdImg");

                    Product p = new Product();
                    p.setpName(pname);
                    p.setpDescp(pdescp);
                    p.setpPrice(pprice);
                    p.setpDiscount(pdiscount);
                    p.setpQuantity(pquantity);
                    p.setpPhoto(part.getSubmittedFileName());

                    //get category by id
                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    Category category = cdao.getCategoryById(catid);
                    p.setCategory(category);

                    //product save
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                    pdao.saveProduct(p);

                    //upload photo
                    //find out the path to upload photo
                    String path = request.getRealPath("img") + File.separator + "products" + File.separator + part.getSubmittedFileName();
                    System.out.println(path);

                    //uploading code
                    FileOutputStream fos = new FileOutputStream(path);
                    InputStream is = part.getInputStream();
                    //reading data
                    byte data[] = new byte[is.available()];
                    is.read(data);
                    //writing the data
                    fos.write(data);
                    fos.close();

                    //out.println("Product saved Successfully !");
                    HttpSession httpsession = request.getSession();
                    httpsession.setAttribute("message", "Product is Added Successfully !");
                    response.sendRedirect("admin.jsp");
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (op.trim().equals("getProductDetails")) {
                try {
                    int productId = Integer.parseInt(request.getParameter("pId"));
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                    Product pObj = new Product();
                    pObj = pdao.getProductDetailsById(productId);

                    Map<String, String> ProductDetails = new LinkedHashMap<>();
                    ProductDetails.put("productID", Integer.toString(productId));
                    ProductDetails.put("ProdTitle", pObj.getpName());
                    ProductDetails.put("ProdDescp", pObj.getpDescp());
//                    ProductDetails.put("ProdImg", pObj.getpPhoto());
                    ProductDetails.put("ProdPrice", Float.toString(pObj.getpPrice()));
                    ProductDetails.put("ProdDiscount", Float.toString(pObj.getpDiscount()));
                    ProductDetails.put("ProdQuantity", Float.toString(pObj.getpQuantity()));
                    ProductDetails.put("catId", Integer.toString(pObj.getCategory().getCategoryId()));
                    ProductDetails.put("catName", pObj.getCategory().getCategoryName());

                    String json = new Gson().toJson(ProductDetails);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(json);

                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (op.trim().equals("getUserDetails")) {
                try {
                    int userId = Integer.parseInt(request.getParameter("uId"));
                    UserDao udao = new UserDao(FactoryProvider.getFactory());
                    User uObj = new User();
                    uObj = udao.getUserDetailsById(userId);
//                    System.out.println(userId);

                    Map<String, String> UserDetails = new LinkedHashMap<>();
                    UserDetails.put("categoryID", Integer.toString(userId));
                    UserDetails.put("user_name", uObj.getUserName());
                    UserDetails.put("user_email", uObj.getUserMail());
                    UserDetails.put("user_phone", uObj.getUserPhone());
                    UserDetails.put("user_add", uObj.getUserAddress());

                    String json = new Gson().toJson(UserDetails);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(json);
                } catch (Exception e) {
                    e.printStackTrace();
                }

            } else if (op.trim().equals("getCategoryDetails")) {
                try {
                    int categoryId = Integer.parseInt(request.getParameter("catId"));
                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    Category cObj = new Category();
                    cObj = cdao.getCategoryById(categoryId);
//                    System.out.println(categoryId);

                    Map<String, String> CategoryDetails = new LinkedHashMap<>();
                    CategoryDetails.put("categoryID", Integer.toString(categoryId));
                    CategoryDetails.put("CatTitle", cObj.getCategoryName());
                    CategoryDetails.put("CatDescp", cObj.getCategoryDescp());

                    String json = new Gson().toJson(CategoryDetails);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(json);

                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (op.trim().equals("updateProduct")) {
                try {
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());

                    int pid = Integer.parseInt(request.getParameter("productID"));
                    String pname = request.getParameter("ProdTitle");
                    String pdescp = request.getParameter("ProdDescp");
                    float pprice = Float.parseFloat(request.getParameter("ProdPrice"));
                    float pdiscount = Float.parseFloat(request.getParameter("ProdDiscount"));
                    float pquantity = Float.parseFloat(request.getParameter("ProdQuantity"));
                    int catid = Integer.parseInt(request.getParameter("catId"));
                    Part part = request.getPart("ProdImg");

                    Product p = new Product();
                    p.setpId(pid);
                    p.setpName(pname);
                    p.setpDescp(pdescp);
                    p.setpPrice(pprice);
                    p.setpDiscount(pdiscount);
                    p.setpQuantity(pquantity);
                    p.setpPhoto(part.getSubmittedFileName());
                    //p.setpPhoto("abc.jpg");

                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    Category category = cdao.getCategoryById(catid);
                    p.setCategory(category);

                    if (pdao.updateProductDetails(p)) {
                        System.out.println("inside query");
                        HttpSession httpsession = request.getSession();
                        httpsession.setAttribute("message", "Product is Updated Successfully !");
                        response.sendRedirect("admin.jsp");
                    } else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('ERROR!');");
                        out.println("location='admin.jsp';");
                        out.println("</script>");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (op.trim().equals("updateCategory")) {
                try {
                    CategoryDao pdao = new CategoryDao(FactoryProvider.getFactory());

                    int pid = Integer.parseInt(request.getParameter("categoryID"));
                    String cname = request.getParameter("CatTitle");
                    String cdescp = request.getParameter("CatDescp");

                    Category p = new Category();
                    p.setCategoryId(pid);
                    p.setCategoryName(cname);
                    p.setCategoryDescp(cdescp);

                    if (pdao.updateCategoryDetails(p)) {
                        System.out.println("inside query");
                        HttpSession httpsession = request.getSession();
                        httpsession.setAttribute("message", "Category is Updated Successfully !");
                        response.sendRedirect("admin.jsp");
                    } else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('ERROR!');");
                        out.println("location='admin.jsp';");
                        out.println("</script>");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
