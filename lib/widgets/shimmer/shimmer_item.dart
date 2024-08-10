
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TShimmer extends StatelessWidget {
  const TShimmer({
    super.key,
    this.radius = 12,
  });
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade200,
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
        ),
      ),
    );
  }
}
