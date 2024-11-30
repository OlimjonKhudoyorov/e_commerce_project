<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.util.*" %>
<%@ page import="uz.code.e_commerce_project.model.User" %>
<%@ page import="uz.code.e_commerce_project.model.Product" %>
<%@ page import="uz.code.e_commerce_project.db.DB" %>
<%@ page import="uz.code.e_commerce_project.model.Basket" %>
<%@ page import="uz.code.e_commerce_project.model.Category" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Main</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
        }

        .sidebar {
            border-radius: 8px;
            width: 20%;
            background-color: rgb(2, 253, 90);
            border-right: 1px solid #ddd;
            padding: 20px;
            height: 100vh;
            margin-left: 20px;
            margin-top: 20px;
        }

        .col .btn.active {
            color: white;
            background-color: aqua;
        }

        .sidebar .btn.active {
            background-color: red;
            color: #024341;
            width: 100%;
            border-color: #090303;
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

        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            background-color: #fdf402;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .product-img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
            object-fit: cover;
            max-height: 150px;
        }

        .product-name {
            margin: 10px 0 5px;
            font-size: 1.1rem;
            font-weight: bold;
        }

        .product-price {
            color: #28a745;
            font-size: 1rem;
            margin-bottom: 10px;
        }

        .profile-container {
            display: flex;
            margin-right: .5rem !important;
            gap: 10px;
        }

        .profile-container img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .custom-green-bg {
            background-color: green !important;
        ] color: white !important;
        }

        .username {
            display: flex;
            align-items: center;
        }

        .profile-container p {
            margin: 0;
            font-size: 16px;
            color: #333;
            font-weight: bold;
        }
    </style>
</head>
<body>
<%
    request.getSession();
    User currentUser = (User) session.getAttribute("currentUser");
    String username = null;

    if (currentUser != null) {
        username = currentUser.getUsername();
    }

    List<Product> PRODUCTS = DB.PRODUCTS;
    String categoryId = request.getParameter("categoryId");
    String productId = request.getParameter("productId");
    String categoryLength = request.getParameter("categorylength");

    if (categoryLength != null) {
        int categorySize = Integer.parseInt(categoryLength);
        if (categoryId != null && !categoryId.equals("0") && categorySize != PRODUCTS.size()) {
            int id = Integer.parseInt(categoryId);
            PRODUCTS = new ArrayList<>(DB.PRODUCTS.stream()
                    .filter(p -> p.getCategoryId() == id).toList());
        }
    } else if (categoryId != null && !categoryId.equals("0")) {
        int id = Integer.parseInt(categoryId);
        PRODUCTS = new ArrayList<>(DB.PRODUCTS.stream()
                .filter(p -> p.getCategoryId() == id).toList());
    }

    Basket basket = (Basket) Objects.requireNonNullElse(session.getAttribute("basket"), new Basket());
    Map<Product, Integer> mapBasket = basket.getMapBasket();

    if (productId != null && !productId.isEmpty()) {
        int proid = Integer.parseInt(productId);
        Product product = DB.PRODUCTS.stream()
                .filter(p -> p.getId() == proid)
                .findFirst()
                .orElse(null);
        if (product != null) {
            mapBasket.put(product, mapBasket.getOrDefault(product, 0) + 1);
            session.setAttribute("basket", basket);
        }
    }
%>
<div class="row-container">
    <div class="sidebar">
        <h4 style="margin-left: 75px">Categories</h4>
        <form action="${pageContext.request.contextPath}/main.jsp" method="post">
            <input type="hidden" name="categoryId" value="0">
            <button name="category" value="All"
                    class="btn btn-primary w-100 all-products <%="All".equals(request.getParameter("category")) ? "active" : ""%>">
                All
            </button>
        </form>
        <%
            for (Category category : DB.CATEGORIES) {
        %>
        <form action="${pageContext.request.contextPath}/main.jsp" method="post">
            <input type="hidden" name="categoryId" value="<%=category.getId()%>">
            <button name="category" value="<%=category.getName()%>"
                    class="btn btn-primary w-100 <%=category.getName().equals(request.getParameter("category")) ? "active" : ""%>"><%=category.getName()%>
            </button>
        </form>
        <%
            }
        %>
    </div>
    <div class="content">
        <h1>Products List</h1>
        <div class="d-flex">
            <% if (currentUser == null) { %>
            <a href="${pageContext.request.contextPath}/login.jsp" class="me-2">
                <button class="btn btn-secondary mb-3">Login</button>
            </a>
            <% } %>
            <a href="/basket.jsp" class="me-2">
                <button class="btn btn-primary mb-3">Cart <%=mapBasket.size()%>
                </button>
            </a>
            <% if (currentUser != null) { %>
            <a href="myOrders.jsp" class="me-2">
                <button class="btn btn-primary mb-3">MyOrders</button>
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="me-2">
                <button class="btn btn-primary mb-3">Log out</button>
            </a>
            <div class="profile-container">
                <img src="images/img/account-icon.jpg" alt="account.jpg">
            </div>
            <div class="username">
                <p><strong><%=username%>
                </strong></p>
            </div>
            <% } %>
        </div>

        <div class="row row-cols-4 g-4">
            <% for (Product product : PRODUCTS) { %>
            <div class="col">
                <form action="${pageContext.request.contextPath}/main.jsp" method="post">
                    <div class="product-card">
                        <img src="${pageContext.request.contextPath}/images/<%=product.getPath()  %>"
                             alt="<%=product.getName()%>" class="product-img img-fluid mb-2">
                        <h5 class="product-name"><%=product.getName()%>
                        </h5>
                        <p class="product-price"><%=product.getPrice()%> $</p>
                        <input type="hidden" name="productId" value="<%=product.getId()%>">
                        <input type="hidden" name="categoryId" value="<%=product.getCategoryId()%>">
                        <input type="hidden" name="categorylength" value="<%=PRODUCTS.size()%>">
                        <% if (mapBasket.get(product) != null) { %>
                        <a HREF="${pageContext.request.contextPath}/removeFromBasket?productID=<%=product.getId()%>"
                           class="btn btn-danger w-100">Remove</a>
                        <%} else {%>
                        <button class="btn w-100 custom-green-bg <%=(product.getId() + "").equals(request.getParameter("selectedProduct")) ? "active" : ""%>">
                            Add to Cart
                        </button>
                        <%}%>
                    </div>
                </form>
            </div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>