import 'package:flutter/material.dart';

class TDetailSubTitle extends StatelessWidget {
  const TDetailSubTitle({
    super.key,
    required this.subTitle,
  });
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: const TextStyle(
        color: Colors.white54,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
