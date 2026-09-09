import 'package:flutter/material.dart';

import '../auth_colors.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 2,
            color: AuthColors.yellow,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 13),
          child: Text(
            'OR',
            style: TextStyle(
              color: AuthColors.yellow,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 2,
            color: AuthColors.yellow,
          ),
        ),
      ],
    );
  }
}