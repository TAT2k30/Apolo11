class AccountModel {
  final String id;
  final String username;
  final String email;
  final String avatarUrl;
  final String gender;
  final String role;

  AccountModel({
    required this.id,
    required this.username,
    required this.email,
    required this.avatarUrl,
    required this.gender,
    required this.role,
  });

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'], 
      username: map['userName'], 
      email: map['email'],
      avatarUrl: map['avatarUrl'],
      gender: map['gender'], 
      role: map['role'], 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'userName': username,
      'email': email,
      'avatarUrl': avatarUrl,
      'gender': gender, 
      'role': role, 
    };
  }
}
