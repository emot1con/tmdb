import 'package:flutter/material.dart';
import 'package:github_tmdb/movies/bindings/common/widgets/textform/textform_widget.dart';
import 'package:github_tmdb/movies/bindings/constant/colors.dart';
import 'package:github_tmdb/movies/bindings/constant/sizes.dart';

class UserInputSection extends StatelessWidget {
  const UserInputSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TTextFormField(
          label: 'E-mail',
        ),
        const SizedBox(height: TSizes.spaceBtwItem + 10),
        TTextFormField(
          label: 'Password',
          password: true,
          onPressed: () {},
        ),
        const SizedBox(height: TSizes.spaceBtwItem - 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  checkColor: Colors.white,
                  fillColor:
                      MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return TColors.colorPrimary;
                    } else {
                      return Colors.transparent;
                    }
                  }),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                const Text(
                  'Remember me',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Forget password ?',
                style: TextStyle(
                    color: TColors.colorPrimary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}