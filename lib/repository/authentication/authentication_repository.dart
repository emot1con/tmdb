import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:github_tmdb/features/authentication/models/user_model.dart';

class AuthenticationRepository with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await _db
      //     .collection('Users')
      //     .doc(newUser.user!.uid)
      //     .set(userModel.toJson());
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}
