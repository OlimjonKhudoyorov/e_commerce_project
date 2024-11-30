package uz.code.e_commerce_project.servlet;

import uz.code.e_commerce_project.model.User;
import uz.code.e_commerce_project.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("userName");
        String phoneNumber = req.getParameter("phone");
        String password = req.getParameter("password");


        User user = new User(username, phoneNumber, password, "user");


        boolean register = userService.register(user);

        if (register) {
            resp.sendRedirect("/login.jsp");
        } else {
            req.setAttribute("errorMessage", "Username or phone number is already taken.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}