package uz.code.e_commerce_project.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uz.code.e_commerce_project.enumration.OrderStatus;

import java.util.Date;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private Integer id = idGen++;
    private OrderStatus status;
    Date dateTime;
    private Integer userId;
    private static Integer idGen = 1;

    private Map<Product, Integer> items;
    private double totalPrice;

    public Order(Basket basket) {
        System.out.println();
        this.items = basket.getMapBasket();
        this.totalPrice = calculateTotalPrice();
    }

    private double calculateTotalPrice() {
        return items.entrySet().stream()
                .mapToDouble(entry -> entry.getKey().getPrice() * entry.getValue())
                .sum();
    }
}
