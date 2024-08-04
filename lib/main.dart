import 'package:flutter/material.dart';
import 'package:github_tmdb/movies/features/authentication/screens/login/login_screen.dart';
import 'package:github_tmdb/movies/features/authentication/screens/signup/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}
