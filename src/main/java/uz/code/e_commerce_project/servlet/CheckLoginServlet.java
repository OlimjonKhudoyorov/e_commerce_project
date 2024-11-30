package uz.code.e_commerce_project.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Base64;

@WebServlet("/check")
public class CheckLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            response.sendRedirect("/login.jsp");
            return;
        }
        boolean active = false;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("user")) {
                String value = cookie.getValue();
                String key = "youneverfinduser";
                Base64.Encoder encoder = Base64.getEncoder();
                String string = encoder.encodeToString(key.getBytes());
                if (value.equals(string)) {
                    active = true;
                }
            }
        }
        if (active) {
            response.sendRedirect("/order");
        } else {
            response.sendRedirect("/login.jsp");
        }
    }
}
