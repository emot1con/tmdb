import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:github_tmdb/features/authentication/provider/signup_provider.dart';
import 'package:github_tmdb/features/authentication/screens/login/login.dart';
import 'package:github_tmdb/features/authentication/screens/signup/signup.dart';
import 'package:github_tmdb/firebase_options.dart';
import 'package:github_tmdb/repository/authentication/authentication_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(
            AuthenticationRepository(),
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
