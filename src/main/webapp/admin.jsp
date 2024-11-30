<%@ page import="java.util.Base64" %>
<%@ page import="uz.code.e_commerce_project.model.Category" %>
<%@ page import="uz.code.e_commerce_project.db.DB" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body, html {
            height: 500px;
            margin: 0;
        }

        .sidebar {
            width: 20%;
            background-color: #f8f9fa;
            border-right: 1px solid #ddd;
            padding: 20px;
            height: 100vh;
        }

        .row-container {
            display: flex;
            height: 100%;
        }

    </style>
</head>
<body>

<%
    request.getSession(false);
    if (session == null) {
        response.sendRedirect("/login.jsp");
        return;
    }

    Boolean active = (Boolean) session.getAttribute("admin");
    if (active == null || !active) {
        response.sendRedirect("/login.jsp");
        return;
    }

    String name = request.getParameter("name");
    if (name != null && !name.isEmpty()) {
        Category category = new Category(name);
        DB.CATEGORIES.add(category);
    }
%>


<div class="row-container">

    <div class="sidebar">
        <form action="/addCategory.jsp" method="post">
            <button name="category" value="Categories"
                    class="btn btn-primary mb-2 w-100 <%="Categories".equals(request.getParameter("category")) ? "active" : ""%>">
                Categories
            </button>
        </form>

        <form action="/addProduct.jsp" method="post">
            <button name="product" value="Products"
                    class="btn btn-primary mb-2 w-100 <%="Products".equals(request.getParameter("product")) ? "active" : ""%>">
                Products
            </button>
        </form>
        <form action="/login.jsp" method="post">
            <button class="btn btn-primary w-100">Login</button>
        </form>
    </div>
</div>
</body>
</html>
