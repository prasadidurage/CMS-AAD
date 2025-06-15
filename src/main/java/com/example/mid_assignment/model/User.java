package com.example.mid_assignment.model;

import lombok.*;

import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class User  implements Serializable {
    private String id;
    private String username;
    private String password;
    private String fullname;
    private String email;
    private String role;

    public User(String username, String password, String fullname, String email, String role) {
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.role = role;
    }



}
