package uz.code.e_commerce_project.servlet;

import uz.code.e_commerce_project.db.DB;
import uz.code.e_commerce_project.model.Basket;
import uz.code.e_commerce_project.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import java.util.Objects;

@WebServlet("/removeFromBasket")
public class RemoveFromBasketServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int productID = Integer.parseInt(req.getParameter("productID"));
            Product product = DB.PRODUCTS.stream().filter(p -> p.getId() == productID).findFirst().orElse(null);
            if (product == null) {
                req.setAttribute("errorMessage", "Product not found!");
                req.getRequestDispatcher("/error.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession();
            Basket basket = (Basket) Objects.requireNonNullElse(session.getAttribute("basket"), new Basket());
            Map<Product, Integer> mapBasket = basket.getMapBasket();

            mapBasket.remove(product);
            session.setAttribute("basket", basket);

            resp.sendRedirect("main.jsp");
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid product ID!");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}