import 'package:flutter/material.dart';
import 'package:tripbudgeter/features/auth/models/account_model.dart';
import 'package:tripbudgeter/features/auth/services/auth_services.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  late AccountModel _accountModel;

  Future<bool> login({required String email, required String password}) async {
    try {
      _accountModel = await _authServices.handleLogin(email, password);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    _accountModel =
        AccountModel(id: null, username: '', email: '', password: '');
    notifyListeners();
  }
}
