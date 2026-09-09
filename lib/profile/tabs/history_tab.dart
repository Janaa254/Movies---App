import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../profile_colors.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      color: ProfileColors.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 45,
            ),
            decoration: BoxDecoration(
              color: ProfileColors.cardColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.history,
                  color: ProfileColors.yellow,
                  size: 70,
                ),

                const SizedBox(height: 20),

                Text(
                  l10n.noHistoryYet,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  l10n.moviesYouWatchAppearHere,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}