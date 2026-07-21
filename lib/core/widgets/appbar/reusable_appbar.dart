import 'package:flutter/material.dart';

// Shared app bar keeps the top action row and title styling identical on every screen.
class ReusableAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ReusableAppbar({super.key, this.title, this.actions});
  final Widget? title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title == null
          ? null
          : DefaultTextStyle.merge(
              style: const TextStyle(
                fontFamily: 'Unbounded',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              child: title!,
            ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
