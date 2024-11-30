package uz.code.e_commerce_project.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.LinkedHashMap;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Basket {
    private Map<Product, Integer> mapBasket = new LinkedHashMap<>();
}
