import 'package:flutter/material.dart';
import 'package:github_tmdb/widgets/button/elevated_button.dart';
import 'package:github_tmdb/widgets/button/icon_button.dart';
import 'package:github_tmdb/widgets/container/bubble_container.dart';
import 'package:github_tmdb/widgets/textform/textform_widget.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/authentication/provider/login/login_provider.dart';
import 'package:github_tmdb/utils/validators/validation.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: -100,
            right: -100,
            child: TBubbleContainer(
              height: 230,
              width: 230,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: TIconButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              color: Colors.white,
              backgroundColor: TColors.colorPrimary,
            ),
          ),
          Center(
            child: Consumer<LoginProvider>(
              builder: (context, value, child) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 85,
                          width: 85,
                          child: Image(
                            image: AssetImage('assets/images/logo2.png'),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSection),
                        const Text(
                          'Forgot Your Password',
                          style: TextStyle(
                              fontSize: TSizes.mediumTextSize + 5,
                              color: TColors.colorPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItem),
                        const Text(
                          'Enter your email address and we will send you intructions to reset your password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: TSizes.smallTextSize + 1,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSection),
                        TTextFormField(
                          label: 'E-mail',
                          controller: value.email,
                          validator: (email) => TValidator.validateEmail(email),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItem),
                        TElevatedButton(
                          title: 'Send E-mail',
                          onPressed: () {
                            value.resetPassword(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
