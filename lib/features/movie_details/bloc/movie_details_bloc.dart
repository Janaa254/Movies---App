import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/movie_repository.dart';

import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc
    extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieRepository movieRepository;

  MovieDetailsBloc({
    MovieRepository? movieRepository,
  })  : movieRepository = movieRepository ?? MovieRepository(),
        super(MovieDetailsInitial()) {
    on<GetMovieDetails>(_getMovieDetails);
  }

  Future<void> _getMovieDetails(
      GetMovieDetails event,
      Emitter<MovieDetailsState> emit,
      ) async {
    emit(MovieDetailsLoading());

    try {
      final movie = await movieRepository.getMovieDetails(
        event.movieId,
      );

      final suggestions =
      await movieRepository.getMovieSuggestions(
        event.movieId,
      );

      emit(
        MovieDetailsSuccess(
          movie: movie,
          suggestions: suggestions,
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