package com.project.apolo11.features.account.domains.dtos.request;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class CreateAccountRequest {
    private String userName;
    private String password;
    private String avatarUrl;
    private String gender;
    private String phoneNumber;
    private String email;
}
