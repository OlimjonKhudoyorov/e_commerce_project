<%@ page import="uz.code.e_commerce_project.model.OrderProduct" %>
<%@ page import="uz.code.e_commerce_project.servlet.OrderItemServlet" %>
<%@ page import="uz.code.e_commerce_project.model.Product" %>
<%@ page import="uz.code.e_commerce_project.db.DB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>OrderItem</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('https://via.placeholder.com/1920x1080/00FF00/FFFFFF');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .container {
            background-color: rgb(0, 157, 255);
            padding: 20px;
            border-radius: 10px;
        }

        .btn {
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <a href="/main.jsp" class="btn btn-secondary position-absolute"
       style="top: 20px; left: 20px; padding: 10px 20px; font-size: 1rem; border-radius: 8px;">
        &larr; Back
    </a>
    <h1 class="text-center mb-4">OrderItem History</h1>

    <%
        request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <% for (OrderProduct orderProduct : OrderItemServlet.orderProducts) { %>
    <div class="card mb-4">
        <div class="card-header d-flex row">
            <h5 class="col">ProductId #<%= orderProduct.getProductId() %>
            </h5>
            <% Product productById = DB.getProductById(orderProduct.getProductId()); %>
            <p class="mb-0 col">Name: <%= productById.getName() %>
            </p>
            <p class="mb-0 col">Price: <%= productById.getPrice() %>$</p>
            <p class="col">Quantity: <%= orderProduct.getQuantity()%>
            </p>
            <p class="col">Category Id: <%= productById.getCategoryId() %>
            </p>
        </div>
    </div>
    <% } %>
</div>
</body>
</html>