import 'package:flutter/material.dart';

// Shared elevated button for primary actions like save, add, and continue.
class ReusableButton extends StatelessWidget {
  const ReusableButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isExpanded = true,
    this.style,
  });

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isExpanded;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: icon == null
          ? Text(text)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18),
                const SizedBox(width: 8),
                Text(text),
              ],
            ),
    );

    return isExpanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
