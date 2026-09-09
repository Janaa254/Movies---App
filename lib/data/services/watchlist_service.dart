import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/movie_details_model.dart';

class WatchlistService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  WatchlistService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // ============================================================
  // CURRENT USER
  // ============================================================

  User? get currentUser => _auth.currentUser;

  // ============================================================
  // WATCHLIST COLLECTION
  // ============================================================

  CollectionReference<Map<String, dynamic>>? _getWatchlistCollection() {
    final user = currentUser;

    if (user == null) {
      return null;
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('watchlist');
  }

  // ============================================================
  // CHECK IF MOVIE IS IN WATCHLIST
  // ============================================================

  Future<bool> isInWatchlist(int movieId) async {
    final collection = _getWatchlistCollection();

    if (collection == null) {
      return false;
    }

    final doc = await collection
        .doc(movieId.toString())
        .get();

    return doc.exists;
  }

  // ============================================================
  // ADD MOVIE TO WATCHLIST
  // ============================================================

  Future<void> addToWatchlist(
      MovieDetailsModel movie,
      ) async {
    final collection = _getWatchlistCollection();

    if (collection == null) {
      throw Exception(
        'You must be logged in to add movies to your watch list.',
      );
    }

    await collection.doc(movie.id.toString()).set({
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
  // REMOVE MOVIE FROM WATCHLIST
  // ============================================================

  Future<void> removeFromWatchlist(
      int movieId,
      ) async {
    final collection = _getWatchlistCollection();

    if (collection == null) {
      throw Exception(
        'You must be logged in.',
      );
    }

    await collection
        .doc(movieId.toString())
        .delete();
  }

  // ============================================================
  // TOGGLE WATCHLIST
  // ============================================================

  Future<bool> toggleWatchlist(
      MovieDetailsModel movie,
      ) async {
    final isAdded = await isInWatchlist(
      movie.id,
    );

    if (isAdded) {
      await removeFromWatchlist(
        movie.id,
      );

      return false;
    }

    await addToWatchlist(
      movie,
    );

    return true;
  }

  // ============================================================
  // WATCHLIST STREAM
  // ============================================================

  Stream<QuerySnapshot<Map<String, dynamic>>>
  getWatchlistStream() {
    final collection = _getWatchlistCollection();

    if (collection == null) {
      return const Stream.empty();
    }

    return collection
        .orderBy(
      'addedAt',
      descending: true,
    )
        .snapshots();
  }

  // ============================================================
  // WATCHLIST COUNT STREAM
  // ============================================================

  Stream<int> getWatchlistCountStream() {
    final collection = _getWatchlistCollection();

    if (collection == null) {
      return Stream.value(0);
    }

    return collection.snapshots().map(
          (snapshot) => snapshot.docs.length,
    );
  }
}