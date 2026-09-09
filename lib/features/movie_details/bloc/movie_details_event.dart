import '../../../data/models/movie_details_model.dart';

abstract class MovieDetailsEvent {}

class GetMovieDetails extends MovieDetailsEvent {
  final int movieId;

  GetMovieDetails(this.movieId);
}

class ToggleFavorite extends MovieDetailsEvent {
  final MovieDetailsModel movie;

  ToggleFavorite(this.movie);
}