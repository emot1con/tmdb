import 'package:flutter/material.dart';
import 'package:github_tmdb/bindings/common/widgets/button/button_with_text.dart';
import 'package:github_tmdb/bindings/common/widgets/button/elevated_button.dart';
import 'package:github_tmdb/bindings/common/widgets/divider/divder.dart';
import 'package:github_tmdb/bindings/common/widgets/textform/textform_widget.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/authentication/provider/signup/signup_provider.dart';
import 'package:github_tmdb/features/authentication/screens/signup/widgets/foot_section.dart';
import 'package:github_tmdb/features/movie/screens/home/home.dart';
import 'package:github_tmdb/utils/validators/validation.dart';
import 'package:provider/provider.dart';

class InputSignInSection extends StatelessWidget {
  const InputSignInSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<SignUpProvider>(
          builder: (context, value, child) {
            return Form(
              key: value.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  TTextFormField(
                    label: 'Name',
                    controller: value.name,
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  TTextFormField(
                    label: 'Username',
                    controller: value.username,
                    validator: (username) {
                      if (username!.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  TTextFormField(
                    label: 'E-Mail',
                    controller: value.email,
                    validator: (email) => TValidator.validateEmail(email),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItem),
                  TTextFormField(
                    label: 'Password',
                    visiblePassword: value.isVisible,
                    password: true,
                    onPressed: value.visiblePassword,
                    controller: value.password,
                    validator: (password) =>
                        TValidator.validatePassword(password),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSection - 20),
                  TElevatedButton(
                    title: 'Create Account',
                    onPressed: () {
                      value.createUser(context, const HomeScreen());
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
