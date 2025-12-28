import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, required this.onTap});
  String text;
  GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffE95401),
          borderRadius: .circular(10),
        ),
        child: Center(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }
}
