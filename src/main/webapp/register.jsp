<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Register</title>
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            width: 100%;
            max-width: 400px;
            padding: 20px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<% if (request.getAttribute("errorMessage") != null) { %>
<div class="error-message">
    <%= request.getAttribute("errorMessage") %>
</div>
<% } %>


<div class="form-container">
    <h3 class="text-center mb-4">Register</h3>
    <form action="register" method="post">

        <div class="mb-3">
            <input type="text" class="form-control" id="userName" name="userName" placeholder="Username" required>
        </div>


        <div class="mb-3">
            <input type="text" class="form-control" id="phone" name="phone" placeholder="Phone Number" required>
        </div>


        <div class="mb-3">
            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
        </div>


        <button type="submit" class="btn btn-primary w-100">Register</button>
    </form>
</div>
</body>
</html>
