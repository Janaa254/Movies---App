import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailerLauncher {
  const TrailerLauncher._();

  static Future<void> openTrailer({
    required BuildContext context,
    required String? trailerCode,
  }) async {
    // Check if the movie has a trailer.
    if (trailerCode == null || trailerCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Trailer is not available for this movie.',
          ),
        ),
      );

      return;
    }

    final uri = Uri.parse(
      'https://www.youtube.com/watch?v=$trailerCode',
    );

    // Open trailer using YouTube or the browser.
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not open the trailer.',
          ),
        ),
      );
    }
  }
}