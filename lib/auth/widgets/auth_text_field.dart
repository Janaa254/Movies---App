import 'package:flutter/material.dart';

import '../auth_colors.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  final double height;
  final double borderRadius;
  final double fontSize;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.height = 63,
    this.borderRadius = 15,
    this.fontSize = 17,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
        cursorColor: AuthColors.yellow,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor:
          AuthColors.fieldColor,
          contentPadding:
          const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          border:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              borderRadius,
            ),
            borderSide:
            BorderSide.none,
          ),
          enabledBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              borderRadius,
            ),
            borderSide:
            BorderSide.none,
          ),
          focusedBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
              borderRadius,
            ),
            borderSide:
            const BorderSide(
              color:
              AuthColors.yellow,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}