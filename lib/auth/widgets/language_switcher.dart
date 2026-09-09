import 'package:flutter/material.dart';

import '../auth_colors.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 43,
      decoration: BoxDecoration(
        color: AuthColors.background,
        border: Border.all(
          color: AuthColors.yellow,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            '🇺🇸',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          Container(
            width: 2,
            height: 25,
            color: AuthColors.yellow,
          ),
          const Text(
            '🇪🇬',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
        ],
      ),
    );
  }
}