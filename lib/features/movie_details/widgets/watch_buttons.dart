import 'package:flutter/material.dart';

import '../../../data/models/movie_details_model.dart';
import '../../../l10n/app_localizations.dart';

import 'trailer_launcher.dart';

class WatchButtons extends StatelessWidget {
  final MovieDetailsModel movie;

  const WatchButtons({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        // Watch Movie button
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      l10n.moviePlaybackComingSoon,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xfff5222d),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              icon: const Icon(
                Icons.play_circle_fill,
                size: 20,
              ),
              label: Text(
                l10n.watchMovie,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Watch Trailer button
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                TrailerLauncher.openTrailer(
                  context: context,
                  trailerCode: movie.trailerCode,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffffc107),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              icon: const Icon(
                Icons.video_library_rounded,
                size: 20,
              ),
              label: Text(
                l10n.watchTrailer,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}