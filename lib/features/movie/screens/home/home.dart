import 'package:flutter/material.dart';
import 'package:github_tmdb/features/authentication/provider/login/login_provider.dart';
import 'package:iconsax/iconsax.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

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
