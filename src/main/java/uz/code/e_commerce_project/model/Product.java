package uz.code.e_commerce_project.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {
    private Integer id = genId++;
    private String name;
    private double price;
    private Integer categoryId;
    private String path;
    private static Integer genId = 1;

    public Product(String name, double price, int categoryId, String path) {
        this.name = name;
        this.price = price;
        this.categoryId = categoryId;
        this.path = path;
    }
}
