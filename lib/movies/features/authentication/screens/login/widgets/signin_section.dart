import 'package:flutter/material.dart';
import 'package:github_tmdb/movies/bindings/common/widgets/button/elevated_button.dart';
import 'package:github_tmdb/movies/bindings/common/widgets/images/rounded_image.dart';
import 'package:github_tmdb/movies/bindings/constant/colors.dart';
import 'package:github_tmdb/movies/bindings/constant/sizes.dart';

import '../../../../../bindings/common/widgets/divider/divder.dart';

class SignInSection extends StatelessWidget {
  const SignInSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TElevatedButton(
          title: 'Sign-In',
          onPressed: () {},
        ),
        const SizedBox(height: TSizes.spaceBtwItem),
        // TElevatedButton(
        //   title: 'Create Account',
        //   backgroundColor: Colors.white,
        //   border: true,
        //   textColor: Colors.black,
        //   onPressed: () {},
        // ),
        const SizedBox(height: TSizes.spaceBtwItem),
        const TDivider(title: 'Or',),
        const SizedBox(height: TSizes.spaceBtwItem),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              height: 40,
              width: 40,
              imageUrl: 'assets/icons/google-icon.png',
              onPressed: () {},
            ),
            const SizedBox(width: TSizes.spaceBtwItem),
            TRoundedImage(
              height: 40,
              width: 40,
              imageUrl: 'assets/icons/facebook-icon.png',
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
              onTap: () {},
              child: const Text(
                'Sign up',
                style: TextStyle(
                    color: TColors.colorPrimary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
