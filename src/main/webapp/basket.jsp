<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%@ page import="java.util.Objects" %>
<%@ page import="uz.code.e_commerce_project.model.Basket" %>
<%@ page import="uz.code.e_commerce_project.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Basket</title>
    <style>
        .cart-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 15px;
            background-color: #ffc75f;
        }

        .product-img {
            max-width: 120px;
            height: auto;
            border-radius: 5px;
            object-fit: cover;
        }

        .product-info {
            flex: 1;
            margin-left: 15px;
        }

        .product-name {
            font-size: 1.2rem;
            font-weight: bold;
            margin-top: 5px;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .quantity-btn {
            border: none;
            background-color: #0d6efd;
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .quantity-btn:hover {
            background-color: #0047ab;
        }

        .quantity-display {
            font-size: 1.2rem;
            font-weight: bold;
            margin: 0 10px;
        }

        .product-price {
            font-size: 1.2rem;
            color: #28a745;
            font-weight: bold;
            margin-left: 15px;
        }

        .order-btn {
            background-color: #28a745;
            color: white;
            font-size: 1.5rem;
            padding: 10px 20px;
            border-radius: 8px;
            position: fixed;
            bottom: 20px;
            right: 20px;
        }

        .order-btn:hover {
            background-color: #218838;
        }

        .total {
            text-align: right;
            margin-right: 50px;
            margin-top: 20px;
            font-size: 1.5rem;
        }

    </style>
</head>
<body>

<% if (request.getAttribute("error") != null) { %>
<p style="color: red;"><%= request.getAttribute("error") %></p>
<% } %>

<div class="container my-5">
    <a href="/main.jsp" class="btn btn-secondary position-absolute"
       style="top: 20px; left: 20px; padding: 10px 20px; font-size: 1rem; border-radius: 8px;">
        &larr; Back
    </a>

    <h1 class="mb-4 text-center">Cart</h1>
    <form method="post" action="/updateBasket.jsp">
        <%
            double sum = 0;
            session = request.getSession();
            Basket basket = (Basket) Objects.requireNonNullElse(session.getAttribute("basket"), new Basket());
            Map<Product, Integer> mapBasket = basket.getMapBasket();
            for (Map.Entry<Product, Integer> entry : mapBasket.entrySet()) {
                Product product = entry.getKey();
                int quantity = entry.getValue();
                double totalPrice = product.getPrice() * quantity;
                sum += product.getPrice() * quantity;
        %>
        <div class="cart-item">
            <img src="images/<%=product.getPath()%>" alt="<%=product.getName()%>" class="product-img"/>
            <div class="product-info">
                <h5 class="product-name"><%=product.getName()%>
                </h5>
            </div>
            <div class="quantity-control">
                <button type="submit" name="action" value="decrease-<%=product.getId()%>" class="quantity-btn">-
                </button>
                <span class="quantity-display"><%=quantity%></span>
                <button type="submit" name="action" value="increase-<%=product.getId()%>" class="quantity-btn">+
                </button>
            </div>
            <div class="product-price">
                <%=totalPrice%> $
            </div>
        </div>
        <% } %>
                <form method="post" action="/check">
                    <button type="submit" name="active" value="order" class="order-btn">Order</button>
                </form>
        <a href="/check" type="button" class="order-btn">Order</a>
        <h3 class="total text-end">Total: <%=sum%> $ </h3>
    </form>
</div>
</body>
</html>
