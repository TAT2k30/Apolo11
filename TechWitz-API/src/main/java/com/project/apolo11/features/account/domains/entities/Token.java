package com.project.apolo11.features.account.domains.entities;


import com.google.cloud.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.Instant;

@NoArgsConstructor
@AllArgsConstructor
@Data
@SuperBuilder
public class Token {
    private String token;
    private Timestamp createdAt = Timestamp.now();
    private Timestamp updatedAt = Timestamp.now();
}
