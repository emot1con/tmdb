import 'package:flutter/material.dart';

class TButtonWithText extends StatelessWidget {
  const TButtonWithText({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    this.radius,
  });
  final String title;
  final String image;
  final double? radius;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius != null ? BorderRadius.circular(radius!) : null,
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 0.2),
          ],
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(image),
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
