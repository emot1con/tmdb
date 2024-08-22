import 'package:flutter/material.dart';

class TDetailTitle extends StatelessWidget {
  const TDetailTitle({
    super.key,
    required this.title,
    this.titleSize = 13,
  });
  final String title;
  final double ?titleSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white54,
        fontSize: titleSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
