import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.color,
    required this.title,
    required this.subTitle,
    required this.icon,
  });
  final Color color;
  final String title;
  final String subTitle;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 120,
      padding: EdgeInsetsGeometry.all(10),
      margin: EdgeInsetsGeometry.all(3),
      decoration: BoxDecoration(color: color, borderRadius: .circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          Text(subTitle, style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}
