import 'package:flutter/material.dart';

class AppUi extends StatelessWidget {
  const AppUi({super.key, required this.children, required this.topCard});
  final List<Widget> children;
  final Widget topCard;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          addRepaintBoundaries: true,
          physics: const ClampingScrollPhysics(),
          children: [
            topCard,
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Top card that show important details first
class TopCard extends StatelessWidget {
  const TopCard({
    super.key,
    this.borderRadius,
    this.margin,
    required this.child,
    this.padding,
    this.heightFactor = 0.3,
  });
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double heightFactor;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      height: (screenHeight * heightFactor).clamp(180.0, 320.0),
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
