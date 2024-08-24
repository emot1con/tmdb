import 'package:flutter/material.dart';

class TDetailAbout extends StatelessWidget {
  const TDetailAbout({
    super.key,
    required this.title,
    required this.text,
    this.titleSize = 13,
    this.textSize = 15,
    this.titleColor = Colors.white54,
    this.textColor = Colors.white70,
  });
  final String title;
  final String text;
  final Color titleColor;
  final Color textColor;
  final double titleSize;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
          ),
        ),
      ],
    );
  }
}
