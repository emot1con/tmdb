import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationRepository with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      print('$email $password');
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('$email $password error');
      throw 'Error when login';
    }
  }
}
