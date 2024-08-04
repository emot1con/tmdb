import 'package:flutter/material.dart';
import 'package:github_tmdb/movies/bindings/constant/colors.dart';
import 'package:iconsax/iconsax.dart';

class TTextFormField extends StatelessWidget {
  const TTextFormField({
    super.key,
    required this.label,
    this.onPressed,
    this.password = false,
    this.icon,
  });
  final String label;
  final void Function()? onPressed;
  final bool password;
  final Iconsax? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        obscureText: password ? true : false,
        decoration: InputDecoration(
          label: Text(
            label,
            style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
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
            borderSide: const BorderSide(width: 2, color: TColors.colorPrimary),
          ),
        ),
      ),
    );
  }
}
