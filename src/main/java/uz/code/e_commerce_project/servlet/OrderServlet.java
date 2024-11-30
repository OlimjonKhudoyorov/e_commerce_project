package uz.code.e_commerce_project.servlet;

import uz.code.e_commerce_project.enumration.OrderStatus;
import uz.code.e_commerce_project.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    public static Map<Integer, Map<Order, List<OrderProduct>>> orders = new HashMap<>();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect("/login.jsp");
            return;
        }

        Integer userId = currentUser.getId();
        if (!orders.containsKey(userId)) {
            orders.put(userId, new HashMap<>());
        }

        Map<Order, List<OrderProduct>> orderListMap = orders.get(userId);

        Order order = new Order();
        order.setUserId(userId);
        order.setDateTime(new Date());
        order.setStatus(OrderStatus.NEW);

        List<OrderProduct> orderProducts = new ArrayList<>();

        Basket basket = (Basket) session.getAttribute("basket");
        if (basket == null) {
            basket = new Basket();
            session.setAttribute("basket", basket);
        }
        Map<Product, Integer> mapBasket = basket.getMapBasket();

        for (Map.Entry<Product, Integer> entry : mapBasket.entrySet()) {
            OrderProduct orderProduct = new OrderProduct();
            orderProduct.setOrderId(order.getId());
            orderProduct.setProductId(entry.getKey().getId());
            orderProduct.setQuantity(entry.getValue());
            orderProducts.add(orderProduct);
        }

        orderListMap.put(order, orderProducts);
        orders.put(userId, orderListMap);

        session.removeAttribute("basket");

        resp.sendRedirect("/myOrders.jsp");
    }
}
