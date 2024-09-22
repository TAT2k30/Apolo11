package com.project.apolo11.features.tours.domains;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;


@Data
public class TourRequest {
    private String id;
    private String name;
    private String departure;
    private String destination;
    private MultipartFile image;
    private String description;
}
