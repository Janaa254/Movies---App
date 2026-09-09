import 'package:flutter/material.dart';

import '../../../data/models/movie_model.dart';

class BrowseMovieCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback? onTap;

  const BrowseMovieCard({
    super.key,
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 0.68,
        child: Stack(
          children: [
            // Movie Poster
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.mediumCoverImage ??
                      movie.largeCoverImage ??
                      '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: const Color(0xFF242424),
                      child: const Center(
                        child: Icon(
                          Icons.movie,
                          color: Colors.white54,
                          size: 40,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                      ) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Container(
                      color: const Color(0xFF242424),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Rating
            Positioned(
              top: 7,
              left: 7,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xDD202020),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movie.rating?.toStringAsFixed(1) ??
                          '0.0',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}