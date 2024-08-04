
import 'package:flutter/material.dart';

class TDivider extends StatelessWidget {
  const TDivider({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(endIndent: 10.0)),
        Text(title),
        const Expanded(child: Divider(indent: 10.0)),
      ],
    );
  }
}
