package com.project.apolo11.features.trip.controllers;

import com.project.apolo11.common.ResultResponse;
import com.project.apolo11.features.trip.domains.dtos.request.CreateTripRequest;
import com.project.apolo11.features.trip.domains.entities.Trip;
import com.project.apolo11.features.trip.services.TripService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/v1/trip")
public class TripController {
    private final TripService tripService;

    public TripController(
            TripService tripService
    ) {
        this.tripService = tripService;
    }


    @PostMapping("/create-trip")
    public ResponseEntity<ResultResponse<?>> createTrip(
            @RequestHeader("Account-Private-Token") String token,
            @RequestBody CreateTripRequest tripRequest
    ) {
        if (token == null) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("No header token")
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        } else {
            try {
                Trip tripResponse = tripService.createTrip(tripRequest, token);
                return ResponseEntity.ok(
                        ResultResponse.<Trip>builder()
                                .timeStamp(LocalDateTime.now().toString())
                                .body(tripResponse)
                                .message("Create trip successfully")
                                .status(HttpStatus.OK)
                                .statusCode(HttpStatus.OK.value())
                                .build()
                );
            } catch (Exception e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(ResultResponse.<Boolean>builder()
                                .timeStamp(LocalDateTime.now().toString())
                                .body(false)
                                .message("Create Trip failed : " + e.getMessage())
                                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                                .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                                .build());
            }
        }
    }

    @GetMapping("/get-all-trips")
    public ResponseEntity<ResultResponse<?>> getAllTrips(
            @RequestHeader("Account-Private-Token") String token
    ) {
        if (token == null) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ResultResponse.<Boolean>builder()
                            .timeStamp(LocalDateTime.now().toString())
                            .body(false)
                            .message("No header token")
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                            .build());
        } else {
            try {
                List<Trip> tripResponse = tripService.getAllTrips(token);

                return ResponseEntity.ok(
                        ResultResponse.<List<Trip>>builder()
                                .timeStamp(LocalDateTime.now().toString())
                                .body(tripResponse)
                                .message("Create trip successfully")
                                .status(HttpStatus.OK)
                                .statusCode(HttpStatus.OK.value())
                                .build());
            } catch (Exception e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(ResultResponse.<Boolean>builder()
                                .timeStamp(LocalDateTime.now().toString())
                                .body(false)
                                .message("Get all trips failed " + e.getMessage())
                                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                                .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
                                .build());
            }
        }
    }
}
