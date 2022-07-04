<%-- 
    Document   : about
    Created on : 22-Mar-2021, 7:58:17 pm
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>About Page</title>
        <%@include file="components/common_css_js.jsp" %>
        <link rel="stylesheet" href="css/style.css">
        <style>
            .setPosition{
                margin: 0px auto;
            }
            .img-wrapper img{
                max-width: 280px;
            }
        </style>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-12">
                    <h2>About Sai Farms:</h2>
                    <br>
                    <p class="setPosition">
                        Sai Farms is a lush green farms located near Paud,Mulshi, Pune. We're working in field of organic farming since 3 generations. Now a days food we are eating is having many dangerous residues of pesticide & insecticide. Many health problems are increasing day by day, like Cancer, Blood pressure, sugar(Diabetes), abnormalities in new born babies. This is problem of harmful residues in soil & in food. It is like playing with our health & nature.
                    </p>
                    <div class="row">
                        <div class="col-sm-9 col-md-9 col-lg-9">
                            <p class="setPosition">
                                So, we intend to provide you fresh, lush greens and pure organic products as well as poultry products such as eggs and various pulses, cereals & jaggery Through this e-commerce platform.
                            <p><br>Kundan kandhare</br><br> +918999365632</br><br>kskandhare@gmail.com<br></p>
                            
                        </div>

                        <div class="container text-center">
                            <p>
                            <br><h2>Developed By:</h2></br>
                            <br>Chaitanya Joshi: chaitanya.joshi19@vit.edu</br> 
                            <br>Prateek Roy: prateek.roy19@vit.edu</br>
                            <br>Abhijeet Gawas: abhigeet.gawas19@vit.edu</br> 
                            <br>Aneesh Khandelwal: aneesh.khandelwal19@vit.edu</br>
                            </p>
                            <div>
                                <!--<div class="col-sm-3 col-md-3 col-lg-3">
                                    <img src="D:\MCA SEM-4\java\organic_store - Copy\src\main\webapp\img\sai _farms_logo.jpg" style="max-width:90%; width:auto; height: auto;" class="rounded" >
                                </div>-->
                            </div>
                        </div>
                    </div>
                </div>

                <%@include file="components/common_modals.jsp" %>
                </body>
                </html>
