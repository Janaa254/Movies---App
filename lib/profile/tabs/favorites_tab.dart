import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

import '../../features/movie_details/screens/movie_details_screen.dart';
import '../../data/services/favorite_service.dart';

import '../profile_colors.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return _buildEmptyState(context);
    }

    final favoriteService = FavoriteService();

    return Container(
      width: double.infinity,
      color: ProfileColors.background,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: favoriteService.getFavoritesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: ProfileColors.yellow,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Text(
                  l10n.couldNotLoadFavorites,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            );
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return _buildEmptyState(context);
          }

          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(
              14,
              14,
              14,
              25,
            ),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data();

              final int movieId = data['id'] is int
                  ? data['id'] as int
                  : int.tryParse(
                data['id']?.toString() ?? '',
              ) ??
                  0;

              final String title =
                  data['title']?.toString() ?? l10n.movie;

              final String image =
                  data['mediumCoverImage']?.toString() ??
                      data['largeCoverImage']?.toString() ??
                      '';

              final dynamic ratingValue = data['rating'];

              final double rating = ratingValue is num
                  ? ratingValue.toDouble()
                  : 0.0;

              return GestureDetector(
                onTap: () {
                  if (movieId == 0) {
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailsScreen(
                        movieId: movieId,
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (
                              context,
                              error,
                              stackTrace,
                              ) {
                            return Container(
                              color: ProfileColors.cardColor,
                              child: const Center(
                                child: Icon(
                                  Icons.movie,
                                  color: Colors.white54,
                                  size: 45,
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
                              color: ProfileColors.cardColor,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: ProfileColors.yellow,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Color(0x11000000),
                              Color(0xDD000000),
                            ],
                            stops: [
                              0.45,
                              0.65,
                              1.0,
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 8,
                      left: 8,
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
                              rating.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Icon(
                              Icons.star,
                              color: ProfileColors.yellow,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        onPressed: () async {
                          if (movieId == 0) {
                            return;
                          }

                          try {
                            await favoriteService.removeFavorite(
                              movieId,
                            );
                          } catch (e) {
                            if (!context.mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString(),
                                ),
                              ),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: ProfileColors.yellow,
                          size: 27,
                        ),
                      ),
                    ),

                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 12,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
                  Icons.favorite_border,
                  color: ProfileColors.yellow,
                  size: 70,
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.noFavoritesYet,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.moviesYouLikeAppearHere,
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
}