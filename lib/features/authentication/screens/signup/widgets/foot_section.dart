
import 'package:flutter/material.dart';
import 'package:github_tmdb/bindings/common/widgets/button/button_with_text.dart';
import 'package:github_tmdb/bindings/common/widgets/button/elevated_button.dart';
import 'package:github_tmdb/bindings/common/widgets/divider/divder.dart';
import 'package:github_tmdb/constant/sizes.dart';

class FootSection extends StatelessWidget {
  const FootSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
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
    );
  }
}
