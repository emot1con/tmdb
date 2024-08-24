import 'package:flutter/material.dart';

import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/authentication/provider/signout/signout_provider.dart';
import 'package:github_tmdb/features/movie/screens/profile/widgets/user_detail.dart';
import 'package:github_tmdb/features/movie/screens/signout/signout.dart';
import 'package:github_tmdb/widgets/button/button_movie.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserDetail(),
              const SizedBox(height: TSizes.spaceBtwSection),
              Column(
                children: [
                  TButton(
                    width: double.infinity,
                    height: 55,
                    radius: 112,
                    title: 'LogOut',
                    icon: Icons.logout,
                    onTap: () {
                      SignOutProvider().signOutAccount(context);
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  TButton(
                    width: double.infinity,
                    height: 55,
                    radius: 112,
                    title: 'Delete Account',
                    color: Colors.red,
                    icon: Icons.delete_forever,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignOut(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

