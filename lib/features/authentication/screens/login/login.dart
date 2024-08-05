import 'package:flutter/material.dart';
import 'package:github_tmdb/bindings/common/widgets/container/bubble_container.dart';

import 'package:github_tmdb/features/authentication/screens/login/widgets/foot_section.dart';
import 'package:github_tmdb/features/authentication/screens/login/widgets/signin_section.dart';
import 'package:github_tmdb/features/authentication/screens/login/widgets/user_input_section.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: TBubbleContainer(),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace + 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'TMDB',
                      style: TextStyle(
                        color: TColors.colorPrimary,
                        fontSize: TSizes.labelSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Watch anywhere anytime',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: TSizes.spaceBtwSection),
                    UserInputSection(),
                    SizedBox(height: TSizes.spaceBtwSection - 20),
                    SignInSection(),
                    FootSectionLogin(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
