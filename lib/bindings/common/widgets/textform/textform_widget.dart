import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/features/authentication/provider/signup_provider.dart';
import 'package:github_tmdb/repository/authentication/authentication_repository.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TTextFormField extends StatelessWidget {
  const TTextFormField({
    super.key,
    required this.label,
    this.onPressed,
    this.password = false,
    this.icon,
    required this.controller,
    required this.validator, 
  });
  final String label;
  final void Function()? onPressed;
  final bool password;
  final Iconsax? icon;
  final TextEditingController controller;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder:(context, value, child) {
      return  SizedBox(
      height: 70,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: password ? true : false,
        decoration: InputDecoration(
          label: Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
          ),
          suffixIcon: !password
              ? null
              : IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Iconsax.eye_slash),
                ),
          prefixIcon: icon == null
              ? const Icon(Iconsax.send_1)
              : Icon(icon as IconData),
          errorMaxLines: 3,
          prefixIconColor: const Color.fromARGB(255, 148, 145, 145),
          suffixIconColor: const Color.fromARGB(255, 68, 68, 68),
          floatingLabelStyle:
              const TextStyle().copyWith(color: Colors.grey.withOpacity(0.8)),
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
            borderSide: const BorderSide(width: 1, color: TColors.colorPrimary),
          ),
          errorBorder: const OutlineInputBorder().copyWith(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: TColors.colorPrimary),
          ),
          focusedErrorBorder: const OutlineInputBorder().copyWith(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: TColors.colorPrimary),
          ),
        ),
      ),
    );
    },);
  }
}
