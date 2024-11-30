<%@ page import="java.util.UUID" %>
<%@ page import="java.util.List" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="uz.code.e_commerce_project.model.Category" %>
<%@ page import="uz.code.e_commerce_project.db.DB" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body, html {
            height: 100%;
            margin: 0;
        }

        .sidebar {
            width: 20%;
            background-color: #f8f9fa;
            border-right: 1px solid #ddd;
            padding: 20px;
            height: 100vh;
        }

        .content {
            width: 80%;
            padding: 20px;
            overflow-y: auto;
        }

        .row-container {
            display: flex;
            height: 100%;
        }

        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f8f9fa;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-weight: bold;
        }

        .form-group input,
        .form-group select {
            width: 100%;
        }

        .btn-container {
            text-align: right;
        }
    </style>
</head>
<body>

<div class="row-container">
    <div class="sidebar">
        <form action="/addCategory.jsp" method="post">
            <button name="product" value="Categories"
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


    <div class="content">
        <h1 style="margin-left: 450px">Add Products</h1>
        <div class="form-container">
            <form action="/addProduct" method="post" enctype="multipart/form-data">

                <div class="form-group">
                    <label for="name">Product Name</label>
                    <input type="text" name="name" id="name" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="number" name="price" id="price" class="form-control" step="0.01" required>
                </div>

                <div class="form-group">
                    <label for="categoryId">Category</label>
                    <select name="categoryId" id="categoryId" class="form-control" required>
                        <option value="">Select Category</option>
                        <%
                            for (Category category : DB.CATEGORIES) {
                        %>
                        <option value="<%=category.getId()%>"><%=category.getName()%>
                        </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="productPhoto">Product Photo</label>
                    <input type="file" name="productPhoto" id="productPhoto" class="form-control" accept="image/*"
                           required>
                </div>

                <div class="btn-container">
                    <button type="submit" class="btn btn-success">Add Product</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
