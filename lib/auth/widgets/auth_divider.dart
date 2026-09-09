import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../auth_colors.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 2,
            color: AuthColors.yellow,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
          ),
          child: Text(
            l10n.or,
            style: const TextStyle(
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