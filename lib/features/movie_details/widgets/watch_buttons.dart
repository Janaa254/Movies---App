import 'package:flutter/material.dart';

import '../../../data/models/movie_details_model.dart';

import 'trailer_launcher.dart';

class WatchButtons extends StatelessWidget {
  final MovieDetailsModel movie;

  const WatchButtons({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Watch Movie button
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                // Movie playback will be implemented later.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Movie playback will be available soon.',
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
              label: const Text(
                'Watch Movie',
                style: TextStyle(
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
              label: const Text(
                'Watch Trailer',
                style: TextStyle(
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