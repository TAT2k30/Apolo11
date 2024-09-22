package com.project.apolo11.features.tours.domains;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.time.Instant;

@Data
public class Tours {
    private String id;
    private String name;
    private String departure;
    private String destination;
    private String imageUrl;
    private String description;
    private Instant createdAt; // Store timestamp as long (milliseconds since epoch)
}