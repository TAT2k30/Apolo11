import 'package:flutter/material.dart';
import 'package:tripbudgeter/core/storage/storage.dart';
import 'package:tripbudgeter/features/auth/models/account_model.dart';
import 'package:tripbudgeter/features/auth/services/auth_services.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  late AccountModel _accountModel;

  Future<bool> login({required String email, required String password}) async {
    try {
      _accountModel = await _authServices.handleLogin(email, password);
      _saveCurrentUser(_accountModel.email);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    // _accountModel = AccountModel(username: '', email: '', password: '');
    notifyListeners();
  }

  Future<void> _saveCurrentUser(String email) async {
    await Storage().secureStorage.write(key: 'userId', value: email);
  }

  Future<void> _saveAvatar(String avatar) async {
    await Storage().secureStorage.write(key: 'avatarUrl', value: avatar);
  }
}