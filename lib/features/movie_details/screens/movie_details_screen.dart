import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/movie_details_model.dart';

import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_event.dart';
import '../bloc/movie_details_state.dart';

import '../widgets/cast_section.dart';
import '../widgets/similar_movies.dart';


class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieDetailsBloc()
        ..add(
          GetMovieDetails(movieId),
        ),
      child: const _MovieDetailsView(),
    );
  }
}

class _MovieDetailsView extends StatelessWidget {
  const _MovieDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff101010),
      body: SafeArea(
        child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xffffc107),
                ),
              );
            }

            if (state is MovieDetailsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }

            if (state is MovieDetailsSuccess) {
              return _MovieDetailsContent(
                movie: state.movie,
                suggestions: state.suggestions,
                isFavorite: state.isFavorite,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _MovieDetailsContent extends StatelessWidget {
  final MovieDetailsModel movie;
  final List<MovieDetailsModel> suggestions;
  final bool isFavorite;

  const _MovieDetailsContent({
    required this.movie,
    required this.suggestions,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MoviePoster(
            movie: movie,
            isFavorite: isFavorite,
          ),

          const SizedBox(height: 16),

          _WatchButton(
            movie: movie,
          ),

          const SizedBox(height: 12),

          _MovieStats(
            movie: movie,
          ),

          const SizedBox(height: 20),

          if (movie.screenshots.isNotEmpty) ...[
            const _SectionTitle(
              title: 'Screen Shots',
            ),
            const SizedBox(height: 10),
            _Screenshots(
              screenshots: movie.screenshots,
            ),
            const SizedBox(height: 20),
          ],

          if (suggestions.isNotEmpty) ...[
            SimilarMovies(
              movies: suggestions,
              onMovieTap: (id) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailsScreen(
                      movieId: id,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
          ],

          const _SectionTitle(
            title: 'Summary',
          ),

          const SizedBox(height: 10),

          Text(
            movie.summary ??
                movie.description ??
                'No summary available.',
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
            const _SectionTitle(
              title: 'Genres',
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

class _MoviePoster extends StatelessWidget {
  final MovieDetailsModel movie;
  final bool isFavorite;

  const _MoviePoster({
    required this.movie,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 0.68,
            child: Image.network(
              movie.largeCoverImage ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
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

        // Trailer button
        Positioned.fill(
          child: Center(
            child: GestureDetector(
              onTap: () async {
                final code = movie.trailerCode;

                if (code == null || code.isEmpty) {
                  return;
                }

                final uri = Uri.parse(
                  'https://www.youtube.com/watch?v=$code',
                );

                if (await canLaunchUrl(uri)) {
                  await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                }
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

        //  title
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

class _WatchButton extends StatelessWidget {
  final MovieDetailsModel movie;

  const _WatchButton({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          final code = movie.trailerCode;

          if (code == null || code.isEmpty) {
            return;
          }

          final uri = Uri.parse(
            'https://www.youtube.com/watch?v=$code',
          );

          if (await canLaunchUrl(uri)) {
            await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xfff5222d),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: const Text(
          'Watch',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _MovieStats extends StatelessWidget {
  final MovieDetailsModel movie;

  const _MovieStats({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatItem(
            icon: Icons.favorite,
            value: movie.likeCount?.toString() ?? '0',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatItem(
            icon: Icons.access_time,
            value: '${movie.runtime ?? 0}',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatItem(
            icon: Icons.star,
            value: '${movie.rating ?? 0}',
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _StatItem({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xff292929),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xffffc107),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _Screenshots extends StatelessWidget {
  final List<String> screenshots;

  const _Screenshots({
    required this.screenshots,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: screenshots.map(
            (image) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: const Color(0xff292929),
                  );
                },
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}