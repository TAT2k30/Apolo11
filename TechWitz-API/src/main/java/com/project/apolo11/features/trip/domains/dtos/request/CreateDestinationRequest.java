package com.project.apolo11.features.trip.domains.dtos.request;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.File;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder

public class CreateDestinationRequest {
    private String name;
    private File image;
}
