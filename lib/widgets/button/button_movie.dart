import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/colors.dart';

class TButton extends StatelessWidget {
  const TButton({
    super.key,
    required this.title,
    this.icon = Icons.play_arrow_rounded,
    this.height = 40,
    this.width = 170,
    required this.onTap,
    this.radius = 50,
    this.color = TColors.colorPrimary,
  });
  final String title;
  final IconData icon;
  final double height;
  final double radius;
  final Color color;
  final double width;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 2),
            Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
