import 'dart:convert';
import 'dart:math';

import 'package:tripbudgeter/core/network/api_urls.dart';
import 'package:tripbudgeter/features/auth/models/account_model.dart';
import 'package:http/http.dart' as http;

const uri = '${ApiUrls.API_BASE_URL}/auth';

class AuthServices {
  Future<AccountModel> handleLogin(String email, String password) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      return AccountModel.fromMap(jsonDecode(res.body));
    } catch (e) {
      throw Exception(e);
    }
  }
}
