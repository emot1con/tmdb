import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';

class FootSectionLogin extends StatelessWidget {
  const FootSectionLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: TSizes.spaceBtwSection),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'I agree to'),
                TextSpan(
                  text: ' Privacy Policy',
                  style: TextStyle(
                      color: TColors.colorPrimary, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Terms of use',
                  style: TextStyle(
                    color: TColors.colorPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
