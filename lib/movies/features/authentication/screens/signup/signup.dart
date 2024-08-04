import 'package:flutter/material.dart';
import 'package:github_tmdb/movies/bindings/common/widgets/button/elevated_button.dart';
import 'package:github_tmdb/movies/bindings/common/widgets/divider/divder.dart';
import 'package:github_tmdb/movies/bindings/common/widgets/images/rounded_image.dart';
import 'package:github_tmdb/movies/bindings/common/widgets/textform/textform_widget.dart';
import 'package:github_tmdb/movies/bindings/constant/colors.dart';
import 'package:github_tmdb/movies/bindings/constant/sizes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.colorPrimary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 60, left: TSizes.defaultSpace),
              height: 250,
              width: double.infinity,
              child: const Text(
                'Create Your\nAccount',
                style: TextStyle(
                  fontSize: TSizes.labelSize - 5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
              child: Column(
                children: [
                  const SizedBox(height: TSizes.spaceBtwItem),
                  const TTextFormField(label: 'Username'),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  const TTextFormField(label: 'E-Mail'),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  const TTextFormField(label: 'Password'),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  TElevatedButton(
                    title: 'Create Account',
                    onPressed: () {},
                  ),
                  const SizedBox(height: TSizes.spaceBtwSection),
                  const TDivider(title: 'Or'),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/logos/google-icon.png'),
                        ),
                        Text('Google')
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
