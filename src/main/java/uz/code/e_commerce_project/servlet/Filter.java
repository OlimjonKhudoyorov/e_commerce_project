package uz.code.e_commerce_project.servlet;

import uz.code.e_commerce_project.model.User;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebFilter("/*")
public class Filter extends HttpFilter {
    List<String> openPages = new ArrayList<>(List.of(
            "/",
            "/login.jsp",
            "/register.jsp",
            "/main.jsp",
            "/basket.jsp"
    ));

    List<String> userPages = new ArrayList<>(List.of(
            "/main.jsp",
            "/basket.jsp",
            "/myOrders.jsp",
            "/orderItem.jsp"
    ));

    List<String> adminPages = new ArrayList<>(List.of(
            "/admin.jsp",
            "/addCategory.jsp",
            "/addProduct.jsp"
    ));

    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpSession session = req.getSession();
        User user = null;
        if (session.getAttribute("currentUser") != null) {
            user = (User) session.getAttribute("currentUser");
        }

        String userRole = user != null ? user.getRole() : null;
        String requestURI = req.getRequestURI();

        if (openPages.contains(requestURI)) {
            chain.doFilter(req, res);
            return;
        } else if (userPages.contains(requestURI)) {
            if (userRole == null) {
                session.setAttribute("requestPage", requestURI);
                res.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }
            chain.doFilter(req, res);
        } else if (adminPages.contains(requestURI)) {
            if (!("admin").equals(userRole)) {
                session.setAttribute("requestPage", requestURI);
                res.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }
            chain.doFilter(req, res);
        }
        chain.doFilter(req, res);
    }
}