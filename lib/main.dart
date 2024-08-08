import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:github_tmdb/app.dart';
import 'package:github_tmdb/features/movie/provider/navigations/navigations.dart';
import 'package:github_tmdb/firebase_options.dart';
import 'package:provider/provider.dart';

import 'package:github_tmdb/features/authentication/provider/signup/signup_provider.dart';
import 'package:github_tmdb/features/authentication/provider/login/login_provider.dart';

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
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create:(context) => NavigationsProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppScreen(),
      ),
    );
  }
}
