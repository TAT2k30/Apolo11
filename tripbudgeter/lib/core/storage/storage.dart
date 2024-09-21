import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final Storage _instance = Storage._internal();

  factory Storage() => _instance;

  Storage._internal();

  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String email = '';
  String avatarUrl = '';
  String userName = '';
  String accountId = '';

  Future<void> saveUserInfo(
      String email, String avatarUrl, String accountId, String userName) async {
    await secureStorage.write(key: 'email', value: email);
    await secureStorage.write(key: 'avatarUrl', value: avatarUrl);
    await secureStorage.write(key: 'accountId', value: accountId);
    await secureStorage.write(key: "userName", value: userName);
  }

  Future<Map<String, String?>> getUserInfo() async {
    String? email = await secureStorage.read(key: 'email');
    String? avatarUrl = await secureStorage.read(key: 'avatarUrl');
    String? accountId = await secureStorage.read(key: 'accountId');
    return {'email': email, 'avatarUrl': avatarUrl, 'accountId': accountId};
  }

  
}
