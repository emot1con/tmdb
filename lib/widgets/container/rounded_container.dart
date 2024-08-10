import 'package:flutter/material.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.color = Colors.black54,
    this.radius = 20,
    this.padding = 5
  });
  final Widget child;
  final double? height;
  final double? width;
  final double radius;
  final double padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
