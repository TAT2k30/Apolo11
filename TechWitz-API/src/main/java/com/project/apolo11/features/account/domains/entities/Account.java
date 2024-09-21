package com.project.apolo11.features.account.domains.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Generated;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.springframework.aot.generate.GeneratedTypeReference;
import org.springframework.data.annotation.Id;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.OffsetTime;
import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Account {
    private String id;
    private String userName;
    private String password;
    private String avatarUrl;
    private String gender;
    private String email;
    private String role;
//    private List<String> roles;
    private Instant createdAt = Instant.now();
    private Instant updatedAt = Instant.now();
}
