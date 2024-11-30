<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #000;
            text-align: center;
            padding: 50px;
            color: white;
        }
        .login-container {
            background: #28a745;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            width: 400px;
            margin: auto;
            padding: 20px;
        }
        h1 {
            color: white;
        }
        .error {
            color: red;
            margin-bottom: 15px;
        }
        input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            width: 95%;
            padding: 10px;
            background-color: #0069d9;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #004085;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h1>Login</h1>
    <form action="/login" method="post">
        <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <input type="text" name="phone" placeholder="Telefon raqam" required>
        <input type="password" name="password" placeholder="Parol" required>
        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>