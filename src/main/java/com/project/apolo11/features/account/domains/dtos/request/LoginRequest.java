package com.project.apolo11.features.account.domains.dtos.request;


import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class LoginRequest {
    @NotNull(message = "Email can not be left empty")
    @NotBlank(message = "Email can not be blank")
    private String email;

    @NotNull(message = "Password can not be left empty")
    @NotBlank(message = "Password can not be blank")
    private String password;
}
