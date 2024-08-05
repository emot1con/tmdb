import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_tmdb/repository/authentication/authentication_repository.dart';

class LoginProvider with ChangeNotifier {
  final AuthenticationRepository authRepo;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginProvider(this.authRepo);

  bool _isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool get isLoading => _isLoading;
  TextEditingController get email => _email;
  TextEditingController get password => _password;

  void login() async {
    if (formKey.currentState!.validate()) {
    print(_email);
    print('password : ${_password}');
      _isLoading = true;
      notifyListeners();

      try {
        await authRepo.loginWithEmailAndPassword(email.text, password.text);
      }
      on FirebaseAuthException catch (e){
        throw e.message.toString();
      }
       catch (e) {
        throw 'error when login';
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}
