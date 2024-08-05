import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:github_tmdb/repository/authentication/authentication_repository.dart';

class LoginProvider with ChangeNotifier {
  LoginProvider(this.authenticationRepository);

  final AuthenticationRepository authenticationRepository;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _rememberMe = false;
  bool _isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool get rememberMe => _rememberMe;
  bool get isLoading => _isLoading;
  TextEditingController get email => _email;
  TextEditingController get password => _password;

  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      _isLoading = true;
      notifyListeners();
      try {
        await authenticationRepository.loginWithEmailAndPassword(email.text, password.text);
       
      } catch (e) {
        if (context.mounted) {
          _showSnackbar(context, e.toString());
        }
      } finally {
        _isLoading = false;
        notifyListeners();
        
      }
    } else {
      _showSnackbar(context, 'Error Login');
    }
  }

  void checkBoxRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
