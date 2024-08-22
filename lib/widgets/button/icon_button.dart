import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TIconBackButton extends StatelessWidget {
  const TIconBackButton({
    super.key,
    this.icon = Iconsax.arrow_left,
    this.padding = 10,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
    this.size,
  });
  final IconData icon;
  final double padding;
  final double? size;
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
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          
          icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
