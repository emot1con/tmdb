import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:github_tmdb/features/authentication/models/user_model.dart';
import 'package:github_tmdb/repository/authentication/authentication_repository.dart';

class SignUpProvider with ChangeNotifier {
  SignUpProvider(this.authenticationRepository);

  final AuthenticationRepository authenticationRepository;
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool get isLoading => _isLoading;

  TextEditingController get name => _name;
  TextEditingController get username => _username;
  TextEditingController get email => _email;
  TextEditingController get password => _password;

  void createUser(BuildContext context, Widget widget) async {
    if (formKey.currentState!.validate()) {
      try {
        _isLoading = true;
        notifyListeners();
        await authenticationRepository.createUserWithEmailAndPassword(
          email.text,
          password.text,
          // UserModel(
          //   id: _auth.currentUser!.uid,
          //   name: name.text,
          //   username: username.text,
          //   email: email.text,
          // ),
        );
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
