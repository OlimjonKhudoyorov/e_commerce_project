<%@ page import="java.util.Objects" %>
<%@ page import="uz.code.e_commerce_project.model.Basket" %>
<%@ page import="uz.code.e_commerce_project.model.Product" %>
<%@ page import="java.util.Map" %>
<%@ page import="uz.code.e_commerce_project.db.DB" %>
<%@ page language="java" %>
<%
    String action = request.getParameter("action");
    session = request.getSession();
    Basket basket = (Basket) Objects.requireNonNullElse(session.getAttribute("basket"), new Basket());
    Map<Product, Integer> mapBasket = basket.getMapBasket();

    if (action != null) {
        if (action.startsWith("increase-")) {
            int productId = Integer.parseInt(action.split("-")[1]);
            Product product = DB.PRODUCTS.stream().filter(p -> p.getId() == productId).findFirst().orElse(null);
            if (product != null) {
                int quantity = mapBasket.getOrDefault(product, 0);
                mapBasket.put(product, quantity + 1);
            }
        } else if (action.startsWith("decrease-")) {
            int productId = Integer.parseInt(action.split("-")[1]);
            Product product = DB.PRODUCTS.stream().filter(p -> p.getId() == productId).findFirst().orElse(null);
            if (product != null) {
                int quantity = mapBasket.getOrDefault(product, 0);
                if (quantity > 1) {
                    mapBasket.put(product, quantity - 1);
                } else {
                    mapBasket.remove(product);
                }
            }
        } else if ("order".equals(action)) {

        }
        session.setAttribute("basket", basket);
    }

    response.sendRedirect("/basket.jsp");
%>