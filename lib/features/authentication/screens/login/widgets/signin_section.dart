import 'package:flutter/material.dart';
import 'package:github_tmdb/bindings/common/widgets/button/elevated_button.dart';
import 'package:github_tmdb/bindings/common/widgets/images/rounded_image.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/authentication/provider/login/login_provider.dart';
import 'package:github_tmdb/features/authentication/screens/login/login.dart';
import 'package:github_tmdb/features/authentication/screens/signup/signup.dart';
import 'package:provider/provider.dart';

import '../../../../../bindings/common/widgets/divider/divder.dart';

class SignInSection extends StatelessWidget {
  const SignInSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            TElevatedButton(
              title: 'Sign-In',
              onPressed: (){
                value.login(context);
              },
            ),
            const SizedBox(height: TSizes.spaceBtwItem),
            const SizedBox(height: TSizes.spaceBtwItem),
            const TDivider(
              title: 'Or',
            ),
            const SizedBox(height: TSizes.spaceBtwItem),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TRoundedImage(
                  height: 40,
                  width: 40,
                  imageUrl: 'assets/logos/google-icon.png',
                  onPressed: () {},
                ),
                const SizedBox(width: TSizes.spaceBtwItem),
                TRoundedImage(
                  height: 40,
                  width: 40,
                  imageUrl: 'assets/logos/facebook-icon.png',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItem),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Dont have an account ?'),
                const SizedBox(width: TSizes.spaceBtwItem),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: TColors.colorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
