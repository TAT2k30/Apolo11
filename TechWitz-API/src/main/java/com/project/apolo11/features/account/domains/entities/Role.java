package com.project.apolo11.features.account.domains.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;


@NoArgsConstructor
@AllArgsConstructor
@Data
@SuperBuilder
public class Role {
    private String id;
    private Role roleName;
    private String description;
    private List<String> accounts;
    private Instant createdAt = Instant.now();
    private Instant updatedAt = Instant.now();
}
