<%-- 
    Document   : testJSP
    Created on : 16-May-2021, 9:13:36 PM
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <script language="javascript" type="text/javascript">
            function call() {
                var name = "xyz";
                window.location.replace("testJSP.jsp?name=" + name);
            }
        </script>
        <input type="button" value="Get" onclick='call()'>
        <%
            String name = request.getParameter("name");
            if (name != null) {
                out.println(name);
            }
        %>

    </body>
</html>
