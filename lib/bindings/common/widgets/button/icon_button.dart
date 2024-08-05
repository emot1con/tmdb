
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TIconButton extends StatelessWidget {
  const TIconButton({
    super.key,
    required this.onTap,
    this.icon = Iconsax.arrow_left,
    this.padding = 10,
  });
  final void Function() onTap;
  final IconData icon;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
