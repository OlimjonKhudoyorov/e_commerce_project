package uz.code.e_commerce_project.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private Integer id = genId++;
    private String username;
    private String phoneNumber;
    private String password;
    private String role;
    private static Integer genId = 1;

    public User(String username, String phoneNumber, String password, String role) {
        this.username = username;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
    }
}
