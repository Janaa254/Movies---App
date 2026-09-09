import 'package:flutter/material.dart';

import '../../../data/models/movie_details_model.dart';

import 'trailer_launcher.dart';

class MoviePoster extends StatelessWidget {
  final MovieDetailsModel movie;

  final bool isFavorite;
  final bool isInWatchlist;

  final VoidCallback onFavoriteTap;
  final VoidCallback onWatchlistTap;

  const MoviePoster({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.isInWatchlist,
    required this.onFavoriteTap,
    required this.onWatchlistTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl =
        Directionality.of(context) == TextDirection.rtl;

    return Stack(
      children: [
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

        PositionedDirectional(
          top: 12,
          start: 12,
          child: _CircleButton(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              isRtl
                  ? Icons.arrow_forward_ios
                  : Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 21,
            ),
          ),
        ),

        PositionedDirectional(
          top: 12,
          end: 12,
          child: Row(
            children: [
              _CircleButton(
                onTap: onFavoriteTap,
                child: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: isFavorite
                      ? const Color(0xffffc107)
                      : Colors.white,
                  size: 25,
                ),
              ),

              const SizedBox(width: 8),

              _CircleButton(
                onTap: onWatchlistTap,
                child: Icon(
                  isInWatchlist
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: isInWatchlist
                      ? const Color(0xffffc107)
                      : Colors.white,
                  size: 27,
                ),
              ),
            ],
          ),
        ),

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

        PositionedDirectional(
          bottom: 75,
          start: 20,
          end: 20,
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

class _CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _CircleButton({
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.55),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}