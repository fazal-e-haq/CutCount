import 'package:flutter/material.dart';

class CardIcon extends StatelessWidget {
  const CardIcon({super.key, required this.icon, this.backgroundColor});
  final Icon icon;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
      ),
      child: Center(child: icon),
    );
  }
}
