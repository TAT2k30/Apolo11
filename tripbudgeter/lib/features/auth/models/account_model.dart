class AccountModel {
  final String username;
  final String email;
  final String password;
  late String? avatarUrl;

  AccountModel({
    required this.username,
    required this.email,
    required this.password,
    this.avatarUrl,
  });

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      username: map['username'],
      email: map['email'],
      password: map['password'],
      avatarUrl: map['avatarUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'avatarUrl': avatarUrl,
    };
  }
}