package com.example.mid_assignment.model;

import com.fasterxml.jackson.annotation.JsonAnyGetter;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@Data
public class User  implements Serializable {
    private String id;
    private String username;
    private String password;
    private String fullname;
    private String email;
    private String role;


}
