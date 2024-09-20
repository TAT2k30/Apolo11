package com.project.apolo11.features.trip.domains.dtos.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.Instant;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class CreateTripRequest {
    private String tripName;
    private int totalBudget;
    private Instant startDate;
    private Instant endDate;
    private String description;

    private String destinationId;
}
