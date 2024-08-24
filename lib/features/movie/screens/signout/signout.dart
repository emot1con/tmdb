import 'package:flutter/material.dart';
import 'package:github_tmdb/features/authentication/provider/signout/signout_provider.dart';
import 'package:github_tmdb/utils/validators/validation.dart';
import 'package:github_tmdb/widgets/button/button_movie.dart';
import 'package:github_tmdb/widgets/textform/textform_widget.dart';
import 'package:provider/provider.dart';

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re-Authenticated Your Account'),
      ),
      body: Consumer<SignOutProvider>(
        builder: (context, value, child) {
          return Form(
            key: value.formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TTextFormField(
                    label: 'Email',
                    controller: value.email,
                    validator: (email) => TValidator.validateEmail(email),
                  ),
                  const SizedBox(height: 16),
                  TTextFormField(
                    label: 'Password',
                    controller: value.password,
                    validator: (password) =>
                        TValidator.validatePassword(password),
                  ),
                  const SizedBox(height: 24),
                  TButton(
                    width: double.infinity,
                    height: 55,
                    radius: 112,
                    title: 'Delete Account',
                    color: Colors.red,
                    icon: Icons.delete_forever,
                    onTap: () {
                      value.deleteAccount(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
