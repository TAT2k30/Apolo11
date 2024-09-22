import 'package:flutter/material.dart';
import 'package:tripbudgeter/core/storage/storage.dart';
import 'package:tripbudgeter/features/auth/models/account_model.dart';
import 'package:tripbudgeter/features/auth/services/auth_services.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  AccountModel? _accountModel; // Make this nullable

  Future<AccountModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      _accountModel = await _authServices.handleLogin(email, password);
      if (_accountModel != null) {
        await _saveCurrentUser(_accountModel!.email); // Use null safety
      }
      notifyListeners();
      return _accountModel; // Return the AccountModel or null
    } catch (e) {
      // Optionally, log the error for debugging
      print('Login failed: $e');
      return null; // Return null on failure
    }
  }

  Future<void> logout() async {
    try {
      await _authServices.handleLogout();
      _accountModel = null;
      await Storage().secureStorage.delete(key: 'userId');
      notifyListeners();
    } catch (e) {
      // Handle logout errors if needed
      print('Logout failed: $e');
    }
  }

  Future<void> _saveCurrentUser(String email) async {
    await Storage().secureStorage.write(key: 'userId', value: email);
  }

  Future<void> _saveAvatar(String avatar) async {
    await Storage().secureStorage.write(key: 'avatarUrl', value: avatar);
  }
}
