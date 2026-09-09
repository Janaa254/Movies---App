import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

import '../../data/services/watchlist_service.dart';
import '../../features/movie_details/screens/movie_details_screen.dart';

import '../profile_colors.dart';

class WatchlistTab extends StatelessWidget {
  const WatchlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final user = FirebaseAuth.instance.currentUser;
    final WatchlistService watchlistService = WatchlistService();

    if (user == null) {
      return _buildEmptyState(context);
    }

    return Container(
      width: double.infinity,
      color: ProfileColors.background,
      child: StreamBuilder<
          QuerySnapshot<Map<String, dynamic>>>(
        stream: watchlistService.getWatchlistStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: ProfileColors.yellow,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                l10n.couldNotLoadWatchList,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            );
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return _buildEmptyState(context);
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (context, index) {
              final data = docs[index].data();

              final int movieId =
                  (data['id'] as num?)?.toInt() ?? 0;

              final String title =
                  data['title']?.toString() ??
                      l10n.unknownMovie;

              final String image =
                  data['largeCoverImage']?.toString() ??
                      data['mediumCoverImage']
                          ?.toString() ??
                      '';

              final ratingValue = data['rating'];

              final String rating =
              ratingValue == null
                  ? l10n.notAvailable
                  : ratingValue.toString();

              return GestureDetector(
                onTap: movieId == 0
                    ? null
                    : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MovieDetailsScreen(
                            movieId: movieId,
                          ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ProfileColors.cardColor,
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (image.isNotEmpty)
                              Image.network(
                                image,
                                fit: BoxFit.cover,
                                errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                    ) {
                                  return _imageFallback();
                                },
                              )
                            else
                              _imageFallback(),

                            Positioned(
                              top: 6,
                              right: 6,
                              child: Material(
                                color:
                                Colors.black.withOpacity(
                                  0.65,
                                ),
                                shape:
                                const CircleBorder(),
                                child: IconButton(
                                  onPressed: movieId == 0
                                      ? null
                                      : () async {
                                    await watchlistService
                                        .removeFromWatchlist(
                                      movieId,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.bookmark,
                                    color:
                                    ProfileColors.yellow,
                                    size: 23,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(
                          10,
                          10,
                          10,
                          4,
                        ),
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(
                          10,
                          0,
                          10,
                          10,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color:
                              ProfileColors.yellow,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      color: ProfileColors.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 45,
            ),
            decoration: BoxDecoration(
              color: ProfileColors.cardColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.bookmark_border,
                  color: ProfileColors.yellow,
                  size: 70,
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.noMoviesWatchList,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.watchListDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageFallback() {
    return Container(
      color: const Color(0xff252525),
      child: const Center(
        child: Icon(
          Icons.movie,
          color: Colors.white38,
          size: 45,
        ),
      ),
    );
  }
}