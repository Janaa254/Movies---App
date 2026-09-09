import 'package:flutter/material.dart';

import '../../../data/models/movie_details_model.dart';
import '../../../l10n/app_localizations.dart';

class SimilarMovies extends StatelessWidget {
  final List<MovieDetailsModel> movies;
  final void Function(int movieId)? onMovieTap;

  const SimilarMovies({
    super.key,
    required this.movies,
    this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.similar,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movies.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];

            return GestureDetector(
              onTap: () => onMovieTap?.call(movie.id),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.mediumCoverImage ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: const Color(0xff252525),
                      child: const Icon(
                        Icons.movie,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}