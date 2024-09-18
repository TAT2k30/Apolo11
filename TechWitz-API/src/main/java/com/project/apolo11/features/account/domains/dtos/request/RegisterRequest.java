package com.project.apolo11.features.account.domains.dtos.request;


import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class RegisterRequest {
    @NotNull(message = "User name can")
    private String userName;
    private String password;
    private String email;
    private String phoneNumber;
    private String gender;
}
