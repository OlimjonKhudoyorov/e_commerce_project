<%@ page import="uz.code.e_commerce_project.model.Category" %>
<%@ page import="uz.code.e_commerce_project.db.DB" %>
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
            text-align: center;
        }

        .row-container {
            display: flex;
            height: 100%;
        }

        .form-container {
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f8f9fa;
            max-width: 400px;
        }
    </style>
</head>
<body>
<%
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


    <div class="content">
        <h1>Add Category</h1>
        <div class="form-container">
            <form action="/addCategory.jsp" method="post">

                <div class="mb-3">
                    <label for="name" class="form-label">Category Name</label>
                    <input type="text" name="name" id="name" class="form-control" required>
                </div>

                <button type="submit" class="btn btn-success w-100">Add Category</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>
