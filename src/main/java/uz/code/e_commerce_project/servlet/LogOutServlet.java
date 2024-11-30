package uz.code.e_commerce_project.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/logout")
public class LogOutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().invalidate();

        req.getSession().removeAttribute("currentUser");
        req.getSession().removeAttribute("userId");

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("currentUser") || cookie.getName().equals("userId")) {
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
        }

        resp.sendRedirect("/login.jsp");
    }
}
