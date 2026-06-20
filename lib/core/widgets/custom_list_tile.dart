import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.trailing,
  });
  final Widget title;
  final Widget subTitle;
  final Widget trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(title: title, trailing: trailing, subtitle: subTitle);
  }
}
