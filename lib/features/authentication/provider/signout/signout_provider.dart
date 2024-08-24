import 'package:flutter/material.dart';
import 'package:github_tmdb/features/authentication/models/user_model.dart';
import 'package:github_tmdb/repository/authentication/authentication_repository.dart';

class SignOutProvider with ChangeNotifier {
  SignOutProvider();

  UserModel? _userModel;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  void getUserData() async {
    _isLoading = true;
    notifyListeners();
    try {
      final user = await authenticationRepository.getUser();
      _userModel = user;
      notifyListeners();
    } catch (e) {
      throw e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void signOutAccount(BuildContext context) async {
    try {
      await authenticationRepository.signoutAccount();
    } catch (e) {
      throw e.toString();
    } finally {
      if (context.mounted) {
        authenticationRepository.screenRedirect(context);
      }
    }
  }

  void deleteAccount(BuildContext context) async {
    try {
      await authenticationRepository.deleteAccount();
    } catch (e) {
      throw e.toString();
    } finally {
      if (context.mounted) {
        authenticationRepository.screenRedirect(context);
      }
    }
  }
}
