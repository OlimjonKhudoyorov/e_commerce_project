<%@ page import="uz.code.e_commerce_project.model.Order" %>
<%@ page import="uz.code.e_commerce_project.model.OrderProduct" %>
<%@ page import="uz.code.e_commerce_project.servlet.OrderServlet" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.code.e_commerce_project.model.User" %>

<html>
<head>
    <title>Order History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <a href="/main.jsp" class="btn btn-secondary position-absolute"
       style="top: 20px; left: 20px; padding: 10px 20px; font-size: 1rem; border-radius: 8px;">
        &larr; Back
    </a>
    <h1 class="text-center mb-4">Order History</h1>

    <%
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null) {
            Integer userId = currentUser.getId();
            Map<Order, List<OrderProduct>> orderListMap = OrderServlet.orders.get(userId);

            if (orderListMap != null && !orderListMap.isEmpty()) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                for (Map.Entry<Order, List<OrderProduct>> entry : orderListMap.entrySet()) {
                    Order order = entry.getKey();
    %>
    <div class="card mb-4">
        <div class="card-header d-flex row">
            <h5 class="col">Order Id #<%= order.getId() %></h5>
            <p class="mb-0 col">Date: <%= dateFormat.format(order.getDateTime()) %></p>
            <p class="mb-0 col">Order Status: <%= order.getStatus() %></p>
            <a href="/orderItem?orderId=<%= order.getId() %>" type="button" class="btn btn-success col">Show</a>
        </div>
    </div>
    <%
        }
    } else {
    %>
    <p class="text-center text-muted">You have no orders yet.</p>
    <%
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    %>
</div>
</body>
</html>