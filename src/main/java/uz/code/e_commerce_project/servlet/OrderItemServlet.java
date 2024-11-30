package uz.code.e_commerce_project.servlet;

import uz.code.e_commerce_project.model.Order;
import uz.code.e_commerce_project.model.OrderProduct;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/orderItem")
public class OrderItemServlet extends HttpServlet {
    public static List<OrderProduct> orderProducts;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        Integer userId = (Integer) session.getAttribute("userId");

        String orderId = req.getParameter("orderId");
        int id = 0;
        if (orderId != null) {
            id = Integer.parseInt(orderId);
        }

        if (userId == null || id == 0) {
            resp.sendRedirect("login.jsp");
            return;
        }

        Map<Order, List<OrderProduct>> orderListMap = OrderServlet.orders.get(userId);
        List<OrderProduct> orderProducts = null;

        for (Map.Entry<Order, List<OrderProduct>> order : orderListMap.entrySet()) {
            if (order.getKey().getId() == id) {
                orderProducts = order.getValue();
                break;
            }
        }

        if (orderProducts != null) {
            OrderItemServlet.orderProducts = orderProducts;
            resp.sendRedirect("/orderItem.jsp");
        } else {
            resp.sendRedirect("error.jsp");
        }
    }
}