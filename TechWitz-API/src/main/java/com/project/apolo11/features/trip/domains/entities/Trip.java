package com.project.apolo11.features.trip.domains.entities;

import com.project.apolo11.features.trip.utils.Status;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.File;
import java.time.Instant;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Trip {
    private String id;
    private String name;
    private Instant startDate;
    private Instant endDate;
    private int totalBudget;
    private Status status;
    private String description;

    private File reportFile;
    private List<String> accounts;
    private String destinationId;

    private String createdBy;
    private Instant createdAt = Instant.now();
    private Instant updatedAt = Instant.now();
}
