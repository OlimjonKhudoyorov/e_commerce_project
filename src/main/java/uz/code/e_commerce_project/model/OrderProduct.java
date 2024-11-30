package uz.code.e_commerce_project.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderProduct {
    private Integer id = idGen++;
    private Integer orderId;
    private Integer productId;
    private Integer quantity;
    private static Integer idGen = 1;

    public OrderProduct(Integer orderId, Integer productId) {
        this.orderId = orderId;
        this.productId = productId;
    }
}


