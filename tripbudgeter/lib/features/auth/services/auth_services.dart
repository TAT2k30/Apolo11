import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripbudgeter/core/network/api_urls.dart';
import 'package:tripbudgeter/core/storage/storage.dart';
import 'package:tripbudgeter/features/auth/models/account_model.dart';

const accountUri = '${ApiUrls.API_BASE_URL}/account';

class AuthServices {
  Future<ResultResponse<bool>> testConnection() async {
    try {
      final res = await http.get(Uri.parse('$accountUri/get-all-account'));

      if (res.statusCode == 200) {
        return ResultResponse<bool>.fromJson(
          jsonDecode(res.body),
          (body) => body as bool,
        );
      } else {
        throw Exception('Failed to connect to server: ${res.body}');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }

  Future<AccountModel?> handleLogin(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('$accountUri/login'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (res.statusCode == 200) {
        return AccountModel.fromMap(
            jsonDecode(res.body)); 
      } else {
        final errorResponse = jsonDecode(res.body);
        throw Exception(
            'Login failed: ${errorResponse['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  Future<ResultResponse<AccountModel>> handleRegister(
      String userName, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$accountUri/register'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(
            {'userName': userName, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final resultResponse = ResultResponse<AccountModel>.fromJson(
          jsonDecode(response.body),
          (body) => AccountModel.fromMap(body),
        );

        await Storage().saveUserInfo(email, resultResponse.body.avatarUrl,
            resultResponse.body.id, userName);
        return resultResponse;
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(
            'Registration failed: ${errorResponse['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  Future<ResultResponse<bool>> handleLogout() async {
    const secureStorage = FlutterSecureStorage();
    String? email = await secureStorage.read(key: 'email');

    try {
      final res = await http.post(
        Uri.parse('$accountUri/logout'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Account-Private-Token': '${email!}-USER',
        },
      );

      if (res.statusCode == 200) {
        final decodedResponse = jsonDecode(res.body);
        final resultResponse = ResultResponse<bool>.fromJson(
          decodedResponse,
          (json) => json['body'] as bool,
        );
        // Clear user data
        await Storage().deleteAllData();
        return resultResponse;
      } else {
        final errorResponse = jsonDecode(res.body);
        throw Exception(
            'Logout failed: ${errorResponse['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      throw Exception('Logout error: $e');
    }
  }
}
