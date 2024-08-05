import 'package:flutter/material.dart';

import 'package:github_tmdb/bindings/common/widgets/button/button_with_text.dart';
import 'package:github_tmdb/bindings/common/widgets/button/elevated_button.dart';
import 'package:github_tmdb/bindings/common/widgets/button/icon_button.dart';
import 'package:github_tmdb/bindings/common/widgets/divider/divder.dart';
import 'package:github_tmdb/bindings/common/widgets/textform/textform_widget.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';

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
                    padding: const EdgeInsets.only(
                        top: 60, left: TSizes.defaultSpace),
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
                            fontSize: TSizes.labelSize - 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
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
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      // const TTextFormField(label: 'Name'),
                      const SizedBox(height: TSizes.spaceBtwItem),
                      // const TTextFormField(label: 'Username'),
                      const SizedBox(height: TSizes.spaceBtwItem),
                      // const TTextFormField(label: 'E-Mail'),
                      const SizedBox(height: TSizes.spaceBtwItem),
                      // const TTextFormField(
                      //   label: 'Password',
                      //   password: true,
                      // ),
                      const SizedBox(height: TSizes.spaceBtwSection - 10),
                      TElevatedButton(
                        title: 'Create Account',
                        onPressed: () {},
                      ),
                      const SizedBox(height: TSizes.spaceBtwSection - 20),
                      const TDivider(title: 'Or'),
                      const SizedBox(height: TSizes.spaceBtwSection - 20),
                      TButtonWithText(
                        title: 'Continue With Google',
                        image: 'assets/logos/google-icon.png',
                        onTap: () {},
                      ),
                      const SizedBox(height: TSizes.spaceBtwItem),
                      TButtonWithText(
                        title: 'Continue With Facebook',
                        image: 'assets/logos/facebook-icon.png',
                        onTap: () {},
                      ),
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
