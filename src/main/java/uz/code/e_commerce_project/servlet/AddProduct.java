package uz.code.e_commerce_project.servlet;

import uz.code.e_commerce_project.db.DB;
import uz.code.e_commerce_project.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.UUID;

@MultipartConfig
@WebServlet("/addProduct")
public class AddProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String absolutePath = getServletContext().getRealPath("/") + "uploaded/";
        String name = req.getParameter("name");
        String price = req.getParameter("price");
        String categoryId = req.getParameter("categoryId");
        Part part = req.getPart("productPhoto");

        if (name != null && price != null && categoryId != null && part != null && part.getSize() > 0) {
            Files.createDirectories(Path.of(absolutePath));

            String fileExtension = Path.of(part.getSubmittedFileName()).getFileName().toString().split("\\.")[1].toLowerCase();

            String[] allowedExtensions = {"jpg", "jpeg", "png"};
            if (!Arrays.asList(allowedExtensions).contains(fileExtension)) {
                resp.getWriter().write("Only image files (jpg, jpeg, png) are allowed!");
                return;
            }

            String uniqueFileName = UUID.randomUUID() + "." + fileExtension;
            Path path = Path.of(absolutePath, uniqueFileName);

            try (InputStream input = part.getInputStream()) {
                Files.write(path, input.readAllBytes());
            }

            String photoUrl = path.toString();

            Product product = new Product(name, Double.parseDouble(price), Integer.parseInt(categoryId), uniqueFileName);
            DB.PRODUCTS.add(product);

            resp.sendRedirect("/addProduct.jsp");
        } else {
            req.setAttribute("errorMessage", "All fields are required and product photo must be uploaded.");
            req.getRequestDispatcher("/addProduct.jsp").forward(req, resp);
        }
    }
}