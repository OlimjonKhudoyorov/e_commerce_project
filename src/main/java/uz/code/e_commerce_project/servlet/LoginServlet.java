package uz.code.e_commerce_project.servlet;

import uz.code.e_commerce_project.db.DB;
import uz.code.e_commerce_project.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    public static User currentUser;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String phoneNumber = req.getParameter("phone").trim();
        String password = req.getParameter("password");

        Optional<User> optionalUser = DB.USERS.stream()
                .filter(item -> item.getPhoneNumber().equals(phoneNumber)
                        && item.getPassword().equals(password))
                .findFirst();

        if (optionalUser.isPresent()) {
            User currentUser = optionalUser.get();
            HttpSession session = req.getSession();

            session.setAttribute("currentUser", currentUser);
            session.setAttribute("role", currentUser.getRole());

            Object basket = session.getAttribute("basket");
            setUserToSession(req, currentUser);

            String requestPage = (String) session.getAttribute("requestPage");
            if (requestPage != null) {
                session.removeAttribute("requestPage");
                resp.sendRedirect(req.getContextPath() + requestPage);
            } else {
                if ("admin".equals(currentUser.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/admin.jsp");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/myOrders.jsp");
                }
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=true");
        }
    }

    private void setUserToSession(HttpServletRequest req, User currentUser) {
        HttpSession session = req.getSession();
        session.setAttribute("currentUser", currentUser);
    }
}