import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String userName;
  final String email;

  UserModel({required this.name, required this.userName, required this.email});

  factory UserModel.fromJson(DocumentSnapshot snapshot) => UserModel(
        name: snapshot['Name'],
        userName: snapshot['Username'],
        email: snapshot['Email'],
      );
}
