import 'package:flutter/material.dart';

import 'package:github_tmdb/widgets/button/icon_button.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/authentication/screens/signup/widgets/foot_section.dart';
import 'package:github_tmdb/features/authentication/screens/signup/widgets/input_signin_section.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.colorPrimary,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 60,
              right: 20,
              child: TIconButton(
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(top: 60, left: TSizes.defaultSpace),
                  height: 250,
                  width: double.infinity,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: Image(
                          image: AssetImage('assets/images/logo2.png'),
                        ),
                      ),
                      SizedBox(height: TSizes.spaceBtwItem),
                      Text(
                        'Create Your\nAccount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: TSizes.labelTextSize - 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded widget to take the remaining space
                Container(
                  height: MediaQuery.of(context).size.height -
                      200, // Subtract the height of the first container
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: const Column(
                    children: [
                      InputSignInSection(),
                      SizedBox(height: TSizes.spaceBtwSection - 10),
                      FootSection(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
