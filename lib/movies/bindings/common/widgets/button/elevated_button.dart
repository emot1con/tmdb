import 'package:flutter/material.dart';
import 'package:github_tmdb/movies/bindings/constant/colors.dart';

class TElevatedButton extends StatelessWidget {
  const TElevatedButton({
    super.key,
    required this.title,
    this.height = 50,
    this.width = double.infinity,
    this.radius = 15,
    required this.onPressed,
    this.backgroundColor = TColors.colorPrimary,
    this.textColor = Colors.white,
    this.border = false,
  });
  final String title;
  final double height;
  final double width;
  final double radius;
  final Color backgroundColor;
  final bool border;
  final Color textColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border ? Border.all(color: Colors.black.withOpacity(0.3)) : null,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
