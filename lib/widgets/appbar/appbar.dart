import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:iconsax/iconsax.dart';

class TAppBar extends StatelessWidget {
  const TAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const  Row(
      children: [
        CircleAvatar(
          child: Icon(
            Iconsax.user,
          ),
        ),
        SizedBox(width: TSizes.spaceBtwItem),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Michael',
              style: TextStyle(
                  fontSize: TSizes.mediumTextSize,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Explore your favorite movies',
              style: TextStyle(fontSize: TSizes.smallTextSize),
            ),
          ],
        ),
      ],
    );
  }
}
