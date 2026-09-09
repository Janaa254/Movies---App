import 'package:flutter/material.dart';

import '../../../data/models/movie_details_model.dart';

import 'trailer_launcher.dart';

class MoviePoster extends StatelessWidget {
  final MovieDetailsModel movie;
  final bool isFavorite;

  const MoviePoster({
    super.key,
    required this.movie,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Movie cover image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 0.68,
            child: Image.network(
              movie.largeCoverImage ?? '',
              fit: BoxFit.cover,
              errorBuilder: (
                  context,
                  error,
                  stackTrace,
                  ) {
                return Container(
                  color: const Color(0xff252525),
                  child: const Icon(
                    Icons.movie,
                    color: Colors.grey,
                    size: 50,
                  ),
                );
              },
            ),
          ),
        ),

        // Back button
        Positioned(
          top: 12,
          left: 12,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),

        // Favorite / Watchlist button
        Positioned(
          top: 12,
          right: 12,
          child: IconButton(
            onPressed: () {
              // Watchlist feature.
            },
            icon: Icon(
              isFavorite
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              color: isFavorite
                  ? const Color(0xffffc107)
                  : Colors.white,
              size: 28,
            ),
          ),
        ),

        // Trailer play button
        Positioned.fill(
          child: Center(
            child: GestureDetector(
              onTap: () {
                TrailerLauncher.openTrailer(
                  context: context,
                  trailerCode: movie.trailerCode,
                );
              },
              child: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffffc107),
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ),
          ),
        ),

        // Movie title and year
        Positioned(
          bottom: 75,
          left: 20,
          right: 20,
          child: Column(
            children: [
              Text(
                movie.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                '${movie.year ?? ''}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}