class AccountModel {
  late int? id;
  final String username;
  final String email;
  final String password;
  late String? avatar;

  AccountModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.avatar,
  });

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      avatar: map['avatar'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'avatar': avatar,
    };
  }
}
