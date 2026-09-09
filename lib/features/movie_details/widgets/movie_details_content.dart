import 'package:flutter/material.dart';

import '../../../data/models/movie_details_model.dart';
import '../../../l10n/app_localizations.dart';

import 'cast_section.dart';
import 'similar_movies.dart';
import 'movie_poster.dart';
import 'watch_buttons.dart';
import 'movie_stats.dart';
import 'movie_screenshots.dart';
import 'section_title.dart';

class MovieDetailsContent extends StatelessWidget {
  final MovieDetailsModel movie;
  final List<MovieDetailsModel> suggestions;

  final bool isFavorite;
  final bool isInWatchlist;

  final VoidCallback onFavoriteTap;
  final VoidCallback onWatchlistTap;

  final ValueChanged<int> onMovieTap;

  const MovieDetailsContent({
    super.key,
    required this.movie,
    required this.suggestions,
    required this.isFavorite,
    required this.isInWatchlist,
    required this.onFavoriteTap,
    required this.onWatchlistTap,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoviePoster(
            movie: movie,
            isFavorite: isFavorite,
            isInWatchlist: isInWatchlist,
            onFavoriteTap: onFavoriteTap,
            onWatchlistTap: onWatchlistTap,
          ),

          const SizedBox(height: 16),

          WatchButtons(
            movie: movie,
          ),

          const SizedBox(height: 12),

          MovieStats(
            movie: movie,
          ),

          const SizedBox(height: 20),

          if (movie.screenshots.isNotEmpty) ...[
            SectionTitle(
              title: l10n.screenShots,
            ),

            const SizedBox(height: 10),

            MovieScreenshots(
              screenshots: movie.screenshots,
            ),

            const SizedBox(height: 20),
          ],

          if (suggestions.isNotEmpty) ...[
            SimilarMovies(
              movies: suggestions,
              onMovieTap: onMovieTap,
            ),

            const SizedBox(height: 25),
          ],

          SectionTitle(
            title: l10n.summary,
          ),

          const SizedBox(height: 10),

          Text(
            movie.summary ??
                movie.description ??
                l10n.noSummaryAvailable,
            style: const TextStyle(
              color: Colors.white70,
              height: 1.5,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 25),

          CastSection(
            cast: movie.cast,
          ),

          const SizedBox(height: 25),

          if (movie.genres.isNotEmpty) ...[
            SectionTitle(
              title: l10n.genres,
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: movie.genres.map(
                    (genre) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff292929),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      genre,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ],
      ),
    );
  }
}