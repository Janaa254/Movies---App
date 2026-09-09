import 'package:flutter/material.dart';

import '../auth_colors.dart';

class RegisterHeader extends StatelessWidget {
  final VoidCallback onBack;

  const RegisterHeader({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.arrow_back,
              color: AuthColors.yellow,
              size: 36,
            ),
          ),
        ),
        const Text(
          'Register',
          style: TextStyle(
            color: AuthColors.yellow,
            fontSize: 28,
          ),
        ),
      ],
    );
  }
}