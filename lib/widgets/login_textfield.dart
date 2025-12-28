import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  LoginTextfield({
    super.key,
    required this.isObsure,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
  });

  String hintText;
  Icon prefixIcon;
  TextEditingController controller;
  bool isObsure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.grey),
      controller: controller,
      obscureText: isObsure,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xff1A1A1A),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE95401), width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
