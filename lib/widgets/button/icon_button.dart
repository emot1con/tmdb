import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TIconButton extends StatelessWidget {
  const TIconButton({
    super.key,
    required this.onTap,
    this.icon = Iconsax.arrow_left,
    this.padding = 10,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
  });
  final void Function() onTap;
  final IconData icon;
  final double padding;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
