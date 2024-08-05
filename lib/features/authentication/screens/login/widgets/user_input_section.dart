import 'package:flutter/material.dart';
import 'package:github_tmdb/bindings/common/widgets/textform/textform_widget.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/authentication/provider/signup_provider.dart';
import 'package:github_tmdb/utils/validators/validation.dart';
import 'package:provider/provider.dart';

class UserInputSection extends StatelessWidget {
  const UserInputSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            Form(
              key: value.formKey,
              child: Column(
                children: [
                  TTextFormField(
                    label: 'E-mail',
                    controller: value.email,
                    validator: (email) => TValidator.validateEmail(email),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItem + 10),
                  TTextFormField(
                    label: 'Password',
                    password: true,
                    onPressed: () {},
                    controller: value.password,
                    validator: (password) =>
                        TValidator.validatePassword(password),
                  ),
                ],
              ),
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
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return TColors.colorPrimary;
                        } else {
                          return Colors.transparent;
                        }
                      }),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
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
      },
    );
  }
}
