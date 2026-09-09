import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../auth_colors.dart';

class RegisterHeader extends StatelessWidget {
  final VoidCallback onBack;

  const RegisterHeader({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            icon: Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? Icons.arrow_forward
                  : Icons.arrow_back,
              color: AuthColors.yellow,
              size: 36,
            ),
          ),
        ),
        Text(
          l10n.register,
          style: const TextStyle(
            color: AuthColors.yellow,
            fontSize: 28,
          ),
        ),
      ],
    );
  }
}