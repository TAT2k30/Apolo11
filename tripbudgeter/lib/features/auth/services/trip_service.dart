import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripbudgeter/core/network/api_urls.dart';
import 'package:tripbudgeter/core/storage/storage.dart';
import 'package:tripbudgeter/features/auth/models/account_model.dart';
import 'package:tripbudgeter/features/trips/models/trip_model.dart';

const tripUri = '${ApiUrls.API_BASE_URL}/trip';

class TripService {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<ResultResponse<List<TripModel>>> getAllTripPlanner() async {
    String? email = await secureStorage.read(key: 'email');
    String accessToken = "${email!}-USER";

    try {
      final res = await http.post(
        Uri.parse('$tripUri/get-all-trips'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Account-Private-Token': accessToken,
        },
      );

      if (res.statusCode == 200) {
        return ResultResponse<List<TripModel>>.fromJson(
          jsonDecode(res.body),
          (body) =>
              (body as List).map((trip) => TripModel.fromMap(trip)).toList(),
        );
      } else {
        final errorResponse = jsonDecode(res.body);
        throw Exception(
            'Failed to get trips: ${errorResponse['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Error during fetching trips: $e');
    }
  }
}
