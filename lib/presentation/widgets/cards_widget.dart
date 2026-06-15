import 'package:flutter/material.dart';

class CardsWidget extends StatelessWidget {
  const CardsWidget({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.child,
    this.onTap,
    this.margin,
  });
  final double height;
  final double width;
  final Color color;
  final Widget child;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(child: child),
        ),
      ),
    );
  }
}
