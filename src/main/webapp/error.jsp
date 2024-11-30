<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 11/29/2024
  Time: 10:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
</head>
<body>
<h2>Error occurred:</h2>
<p><%= request.getAttribute("errorMessage") %>
</p>
<a href="/main.jsp">Back to main page</a>
</body>
</html>
