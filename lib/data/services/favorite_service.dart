import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/movie_details_model.dart';

class FavoriteService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FavoriteService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  CollectionReference<Map<String, dynamic>> _favoritesCollection(
      String userId,
      ) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites');
  }

  // ============================================================
  // CHECK IF MOVIE IS FAVORITE
  // ============================================================

  Future<bool> isFavorite(int movieId) async {
    final user = currentUser;

    if (user == null) {
      return false;
    }

    final doc = await _favoritesCollection(
      user.uid,
    ).doc(
      movieId.toString(),
    ).get();

    return doc.exists;
  }

  // ============================================================
  // ADD FAVORITE
  // ============================================================

  Future<void> addFavorite(
      MovieDetailsModel movie,
      ) async {
    final user = currentUser;

    if (user == null) {
      throw Exception(
        'You must be logged in to add favorites.',
      );
    }

    await _favoritesCollection(
      user.uid,
    ).doc(
      movie.id.toString(),
    ).set({
      'id': movie.id,
      'title': movie.title,
      'titleLong': movie.titleLong,
      'year': movie.year,
      'rating': movie.rating,
      'runtime': movie.runtime,
      'likeCount': movie.likeCount,
      'genres': movie.genres,
      'description': movie.description,
      'summary': movie.summary,
      'largeCoverImage': movie.largeCoverImage,
      'mediumCoverImage': movie.mediumCoverImage,
      'backgroundImage': movie.backgroundImage,
      'trailerCode': movie.trailerCode,
      'screenshots': movie.screenshots,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  // ============================================================
  // REMOVE FAVORITE
  // ============================================================

  Future<void> removeFavorite(
      int movieId,
      ) async {
    final user = currentUser;

    if (user == null) {
      throw Exception(
        'You must be logged in to remove favorites.',
      );
    }

    await _favoritesCollection(
      user.uid,
    ).doc(
      movieId.toString(),
    ).delete();
  }

  // ============================================================
  // TOGGLE FAVORITE
  // ============================================================

  Future<bool> toggleFavorite(
      MovieDetailsModel movie,
      ) async {
    final user = currentUser;

    if (user == null) {
      throw Exception(
        'You must be logged in to use favorites.',
      );
    }

    final favorite = await isFavorite(
      movie.id,
    );

    if (favorite) {
      await removeFavorite(
        movie.id,
      );

      return false;
    }

    await addFavorite(
      movie,
    );

    return true;
  }

  // ============================================================
  // FAVORITES STREAM
  // ============================================================

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavoritesStream() {
    final user = currentUser;

    if (user == null) {
      return const Stream.empty();
    }

    return _favoritesCollection(
      user.uid,
    )
        .orderBy(
      'addedAt',
      descending: true,
    )
        .snapshots();
  }

  // ============================================================
  // FAVORITES COUNT
  // ============================================================

  Stream<int> getFavoritesCountStream() {
    final user = currentUser;

    if (user == null) {
      return Stream.value(0);
    }

    return _favoritesCollection(
      user.uid,
    ).snapshots().map(
          (snapshot) => snapshot.docs.length,
    );
  }
}