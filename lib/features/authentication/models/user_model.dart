import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String username;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });
  static UserModel empty() {
    return UserModel(
      id: '',
      name: '',
      username: '',
      email: '',
    );
  }

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> user) {
    if (user.data() != null) {
      return UserModel(
        id: user.id,
        name: user["Name"] ?? '',
        username: user["Username"] ?? '',
        email: user["Email"] ?? '',
      );
    }
    return empty();
  }

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Username": username,
        "Email": email,
      };
}
