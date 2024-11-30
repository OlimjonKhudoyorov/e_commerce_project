package uz.code.e_commerce_project.db;

import uz.code.e_commerce_project.model.Category;
import uz.code.e_commerce_project.model.Product;
import uz.code.e_commerce_project.model.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface DB {
    List<User> USERS = new ArrayList<>(List.of(
            new User("User1", "+998942111011", "111", "user"),
            new User("User2", "+998975770277", "555", "user"),
            new User("Admin1", "+998777777777", "777", "admin")
    ));

    List<Category> CATEGORIES = new ArrayList<>(List.of(
            new Category("Drinks"),
            new Category("Edibles"),
            new Category("Clothes")
    ));
    List<Product> PRODUCTS = new ArrayList<>(List.of(
            new Product("Water", 1.0, 1, "water.jpg"),
            new Product("Tea", 1.1, 1, "greenTea.jpg"),
            new Product("Sok", 1.2, 1, "sok.jpg"),

            new Product("Osh", 3.0, 2, "osh.jpg"),
            new Product("Shorva", 3.5, 2, "shorva.jpg"),
            new Product("Tandir meat", 10.0, 2, "tandirMeat.jpg"),

            new Product("Sweater", 20.0, 3, "sweater.jpg"),
            new Product("Pant", 15.0, 3, "pant.jpg"),
            new Product("Black dress", 12.0, 3, "blackDress.jpg")
    ));

    static Product getProductById(int id) {
        return PRODUCTS.stream().filter(product -> product.getId() == id).findFirst().orElse(null);
    }

    Map<Product, Integer> map = new HashMap<>();
}
