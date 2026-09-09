import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';

class TrailerLauncher {
  const TrailerLauncher._();

  static Future<void> openTrailer({
    required BuildContext context,
    required String? trailerCode,
  }) async {
    final l10n =
    AppLocalizations.of(context)!;

    if (trailerCode == null ||
        trailerCode.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            l10n.trailerNotAvailable,
          ),
        ),
      );

      return;
    }

    final uri = Uri.parse(
      'https://www.youtube.com/watch?v=$trailerCode',
    );

    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            l10n.couldNotOpenTrailer,
          ),
        ),
      );
    }
  }
}