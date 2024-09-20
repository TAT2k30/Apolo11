import 'dart:convert';

import 'package:tripbudgeter/core/network/api_urls.dart';
import 'package:tripbudgeter/features/trips/models/trip_model.dart';
import 'package:http/http.dart' as http;

const uri = '${ApiUrls.API_BASE_URL}/trips';

class TripService {
  Future<List<TripModel>> getTrips() async {
    try {
      http.Response res = await http.get(Uri.parse(uri));
      List body = jsonEncode(res.body) as List;
      List<TripModel> trips =
          body.map((dynamic item) => TripModel.fromMap(item)).toList();
      return trips;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<TripModel> createTrip(TripModel trip) async {
    try {
      http.Response res = await http.post(
        Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(trip.toMap()),
      );
      return TripModel.fromMap(jsonDecode(res.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<TripModel> updateTrip(TripModel trip) async {
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/${trip.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(trip.toMap()),
      );
      return TripModel.fromMap(jsonDecode(res.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteTrip(String id) async {
    try {
      await http.delete(Uri.parse('$uri/$id'));
    } catch (e) {
      throw Exception(e);
    }
  }
}