import 'package:flutter/material.dart';
import 'package:tripbudgeter/features/trips/models/trip_model.dart';
import 'package:tripbudgeter/features/trips/services/trip_service.dart';

class TripViewModel extends ChangeNotifier {
  final List<TripModel> trips = [];
  final TripService _tripService = TripService();

  Future<void> getTrips() async {
    try {
      this.trips.clear();
      List<TripModel> trips = await _tripService.getTrips();
      this.trips.addAll(trips);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createTrip(TripModel trip) async {
    try {
      await _tripService.createTrip(trip);
      trips.add(trip);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateTrip(TripModel trip) async {
    try {
      await _tripService.updateTrip(trip);
      int index = trips.indexWhere((element) => element.id == trip.id);
      trips[index] = trip;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteTrip(String id) async {
    try {
      await _tripService.deleteTrip(id);
      trips.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}