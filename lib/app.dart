import 'package:flutter/material.dart';
import 'package:github_tmdb/repository/authentication/authentication_repository.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authenticationRepository.screenRedirect(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
