import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:github_tmdb/repository/authentication/authentication_repository.dart';

class SignUpProvider with ChangeNotifier {
  SignUpProvider();

  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthenticationRepository authenticationRepository = AuthenticationRepository();

  bool _isVisible = true;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool get isVisible => _isVisible;
  bool get isLoading => _isLoading;

  TextEditingController get name => _name;
  TextEditingController get username => _username;
  TextEditingController get email => _email;
  TextEditingController get password => _password;

  void visiblePassword() {
    _isVisible = !isVisible;
    notifyListeners();
  }

  Future<void> saveUser() async {
    try {
      await _db.collection('Users').doc(_auth.currentUser!.uid).set({
        "Id": _auth.currentUser!.uid,
        "Name": _name.text,
        "Username": _username.text,
        "Email": _email.text,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  void createUser(BuildContext context, Widget widget) async {
    if (formKey.currentState!.validate()) {
      try {
        _isLoading = true;
        notifyListeners();
        await authenticationRepository.createUserWithEmailAndPassword(
          email.text,
          password.text,
        );
        await saveUser();
        if (context.mounted) {
          authenticationRepository.screenRedirect(context);
        }
      } catch (e) {
        throw e.toString();
      } finally {
        _isLoading = false;
        notifyListeners();
        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => widget),
          );
        }
      }
    } else {
      throw 'Error on create account';
    }
  }
}
