import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/features/authentication/provider/login/login_provider.dart';
import 'package:github_tmdb/repository/authentication/authentication_repository.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TTextFormField extends StatelessWidget {
  const TTextFormField({
    super.key,
    required this.label,
    this.onPressed,
    this.password = false,
    this.searchIcon = false,
    this.visiblePassword = false,
    required this.controller,
    required this.validator,
    this.onTap,
  });
  final String label;
  final void Function()? onPressed;
  final bool password;
  final bool visiblePassword;
  final bool searchIcon;
  final TextEditingController controller;
  final void Function()? onTap;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, value, child) {
        return SizedBox(
          height: 70,
          child: TextFormField(
            controller: controller,
            validator: validator,
            obscureText: visiblePassword,
            decoration: InputDecoration(
              filled: true,
              label: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              suffixIcon: !password
                  ? null
                  : IconButton(
                      onPressed: onPressed,
                      icon: visiblePassword
                          ? const Icon(Iconsax.eye_slash)
                          : const Icon(Iconsax.eye),
                    ),
              prefixIcon: !searchIcon
                  ? const Icon(Iconsax.send_1)
                  : const Icon(Iconsax.search_normal),
              fillColor: const Color.fromARGB(255, 45, 45, 45),
              errorMaxLines: 3,
              prefixIconColor: const Color.fromARGB(255, 148, 145, 145),
              suffixIconColor: const Color.fromARGB(255, 68, 68, 68),
              floatingLabelStyle: const TextStyle()
                  .copyWith(color: Colors.grey.withOpacity(0.8)),
              border: const OutlineInputBorder().copyWith(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    width: 1, color: Color.fromARGB(255, 97, 95, 95)),
              ),
              enabledBorder: const OutlineInputBorder().copyWith(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder().copyWith(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(width: 1, color: Colors.grey.withOpacity(0.8)),
              ),
              errorBorder: const OutlineInputBorder().copyWith(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 1, color: TColors.colorPrimary),
              ),
              focusedErrorBorder: const OutlineInputBorder().copyWith(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 1, color: TColors.colorPrimary),
              ),
            ),
          ),
        );
      },
    );
  }
}
