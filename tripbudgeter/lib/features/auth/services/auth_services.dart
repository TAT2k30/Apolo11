import 'dart:convert';
import 'dart:math';

import 'package:tripbudgeter/core/network/api_urls.dart';
import 'package:tripbudgeter/core/storage/storage.dart';
import 'package:tripbudgeter/features/auth/models/account_model.dart';
import 'package:http/http.dart' as http;

const accountUri = '${ApiUrls.API_BASE_URL}/account';

class AuthServices {
  Future<ResultResponse<bool>> testConnection() async {
    try {
      http.Response res = await http.get(
        Uri.parse('$accountUri/get-all-account'),
      );

      if (res.statusCode == 200) {
        return ResultResponse<bool>.fromJson(
          jsonDecode(res.body),
          (body) => body as bool,
        );
      } else {
        throw Exception('Failed to connect to server');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<AccountModel> handleLogin(String email, String password) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$accountUri/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (res.statusCode == 200) {
        final resultResponse = ResultResponse<AccountModel>.fromJson(
          jsonDecode(res.body),
          (body) => AccountModel.fromMap(body),
        );

        return resultResponse.body;
      } else {
        final errorResponse = jsonDecode(res.body);
        throw Exception(errorResponse['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<ResultResponse<AccountModel>> handleRegister(
      String userName, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$accountUri/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userName': userName,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final resultResponse = ResultResponse<AccountModel>.fromJson(
          jsonDecode(response.body),
          (body) => AccountModel.fromMap(body),
        );

        await Storage().saveUserInfo(
            email, resultResponse.body.avatarUrl, resultResponse.body.id, userName);

        return resultResponse;
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message'] ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
