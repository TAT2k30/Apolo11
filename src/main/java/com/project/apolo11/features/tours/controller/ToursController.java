package com.project.apolo11.features.tours.controller;

import com.project.apolo11.common.ResultResponse;
import com.project.apolo11.features.tours.domains.TourRequest;
import com.project.apolo11.features.tours.domains.Tours;
import com.project.apolo11.features.tours.service.ToursService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/v1/tour")
public class ToursController {
    @Autowired
    private ToursService toursService;

    @GetMapping
    public ResponseEntity<ResultResponse<?>> getAllTour() {
        try {
            List<Tours> tours= toursService.findAllTour();
            return ResponseEntity.ok(
                    ResultResponse.<List<Tours>>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(tours)
                            .message("Get tours successFully.")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build()
            );
        } catch (Exception e) {
            return ResponseEntity.ok(
                    ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(true)
                            .message("Account registered successfully.")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build()
            );
        }
    }
    @PostMapping
    public ResponseEntity<ResultResponse<?>> createTour(
            @RequestHeader("Account-Private-Token") String token,
            @ModelAttribute TourRequest tourRequest
    ) {
        if (token == null) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("Update account failed : Token is missing")
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        }
        try {
        Tours createdTour = toursService.saveTour(tourRequest,token);

            return ResponseEntity.ok(
                    ResultResponse.<Tours>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(createdTour)
                            .message("Account updated successfully.")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build()
            );
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("Update account failed : " + e.getMessage())
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        }
    }
    @PutMapping("/{id}")
    public ResponseEntity<ResultResponse<?>> updateTour(
            @RequestHeader("Account-Private-Token") String token,
           @PathVariable String id, @ModelAttribute TourRequest tourRequest
    ) {
        if (token == null) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("Update account failed : Token is missing")
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        }
        try {
            Tours findTour = toursService.getTourById(id);
            if(findTour == null){
                return ResponseEntity.ok(
                        ResultResponse.<Tours>builder()
                                .timeStamp(LocalDateTime.now().toString())
                                .body(null)
                                .message("Tour not found.")
                                .status(HttpStatus.NOT_FOUND)
                                .statusCode(HttpStatus.NOT_FOUND.value())
                                .build()
                );
            }
            tourRequest.setId(id);
            Tours createdTour = toursService.saveTour(tourRequest,token);
            return ResponseEntity.ok(
                    ResultResponse.<Tours>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(createdTour)
                            .message("Account updated successfully.")
                            .status(HttpStatus.OK)
                            .statusCode(HttpStatus.OK.value())
                            .build()
            );
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("Update account failed : " + e.getMessage())
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        }
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTour(@PathVariable String id) {
        try {
            toursService.deleteTourById(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.status(500).build();
        }
    }

}
