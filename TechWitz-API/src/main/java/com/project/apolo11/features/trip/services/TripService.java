package com.project.apolo11.features.trip.services;

import com.project.apolo11.features.trip.domains.dtos.request.CreateTripRequest;
import com.project.apolo11.features.trip.domains.entities.Trip;

import java.util.List;

public interface TripService {
    Trip createTrip(CreateTripRequest trip, String token);
    void deleteTrip();
    Trip updateTrip();
    Trip getTrip();
    List<Trip> getAllTrips(String token);
}
