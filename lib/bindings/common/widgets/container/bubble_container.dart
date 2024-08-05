import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/colors.dart';

class TBubbleContainer extends StatelessWidget {
  const TBubbleContainer({
    super.key,
    this.height = 220,
    this.width = 220,
    this.color = TColors.colorPrimary,
  });
  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
