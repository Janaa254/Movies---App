import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/movie_repository.dart';
import '../../../data/services/favorite_service.dart';
import '../../../data/services/watchlist_service.dart';

import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc
    extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieRepository movieRepository;
  final FavoriteService favoriteService;
  final WatchlistService watchlistService;

  MovieDetailsBloc({
    MovieRepository? movieRepository,
    FavoriteService? favoriteService,
    WatchlistService? watchlistService,
  })  : movieRepository =
      movieRepository ?? MovieRepository(),
        favoriteService =
            favoriteService ?? FavoriteService(),
        watchlistService =
            watchlistService ?? WatchlistService(),
        super(MovieDetailsInitial()) {
    on<GetMovieDetails>(_getMovieDetails);
    on<ToggleFavorite>(_toggleFavorite);
    on<ToggleWatchlist>(_toggleWatchlist);
  }

  // ============================================================
  // GET MOVIE DETAILS
  // ============================================================

  Future<void> _getMovieDetails(
      GetMovieDetails event,
      Emitter<MovieDetailsState> emit,
      ) async {
    emit(MovieDetailsLoading());

    try {
      final movie =
      await movieRepository.getMovieDetails(
        event.movieId,
      );

      final suggestions =
      await movieRepository.getMovieSuggestions(
        event.movieId,
      );

      final isFavorite =
      await favoriteService.isFavorite(
        event.movieId,
      );

      final isInWatchlist =
      await watchlistService.isInWatchlist(
        event.movieId,
      );

      emit(
        MovieDetailsSuccess(
          movie: movie,
          suggestions: suggestions,
          isFavorite: isFavorite,
          isInWatchlist: isInWatchlist,
        ),
      );
    } catch (e) {
      emit(
        MovieDetailsError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // TOGGLE FAVORITE
  // ============================================================

  Future<void> _toggleFavorite(
      ToggleFavorite event,
      Emitter<MovieDetailsState> emit,
      ) async {
    final currentState = state;

    if (currentState is! MovieDetailsSuccess) {
      return;
    }

    try {
      final newFavoriteState =
      await favoriteService.toggleFavorite(
        event.movie,
      );

      emit(
        currentState.copyWith(
          isFavorite: newFavoriteState,
        ),
      );
    } catch (e) {
      emit(
        MovieDetailsError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // TOGGLE WATCHLIST
  // ============================================================

  Future<void> _toggleWatchlist(
      ToggleWatchlist event,
      Emitter<MovieDetailsState> emit,
      ) async {
    final currentState = state;

    if (currentState is! MovieDetailsSuccess) {
      return;
    }

    try {
      final newWatchlistState =
      await watchlistService.toggleWatchlist(
        event.movie,
      );

      emit(
        currentState.copyWith(
          isInWatchlist: newWatchlistState,
        ),
      );
    } catch (e) {
      emit(
        MovieDetailsError(
          e.toString(),
        ),
      );
    }
  }
}