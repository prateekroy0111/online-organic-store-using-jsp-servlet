<%@page import="com.mycompany.organic.entities.User"%>
<%
    User user2 = (User)session.getAttribute("current-user");
    if(user2==null)
    {
        session.setAttribute("message","You're not logged in ! Login first !!");
        response.sendRedirect("login.jsp");
        return;
    }
    else
    {
        if(user2.getUserType().equals("admin"))
        {
            session.setAttribute("message","You're not normal user ! you're not allowed to access this page !!");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Normal User Panel</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        
        <jsp:include page="index.jsp" />
        
       <%@include file="components/common_modals.jsp"%> 
    </body>
</html>
