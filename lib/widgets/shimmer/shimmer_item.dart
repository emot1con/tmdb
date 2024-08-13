
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TShimmer extends StatelessWidget {
  const TShimmer({
    super.key,
    this.radius = 12,
    this.height,
  });
  final double radius;
  final double ?height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.3),
        highlightColor: Colors.grey.withOpacity(0.5),
        child: Container(
          height: height,
          decoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
