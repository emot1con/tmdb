import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';

class THeadingTitle extends StatelessWidget {
  const THeadingTitle({
    super.key,
    required this.title,
    this.textButton = true,
  });
  final String title;
  final bool textButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: TSizes.mediumTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (textButton)
          TextButton(
            onPressed: () {},
            child: const Text(
              'See all',
              style: TextStyle(color: TColors.colorPrimary),
            ),
          ),
      ],
    );
  }
}
