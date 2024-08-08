import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/features/authentication/provider/login/login_provider.dart';
import 'package:github_tmdb/features/movie/screens/navigations/bottom_navigation_bar.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = LoginProvider();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              loginProvider.logout(context);
            },
            icon: const Icon(
              Iconsax.logout,
            ),
          ),
        ],
      ),
      
    );
  }
}
