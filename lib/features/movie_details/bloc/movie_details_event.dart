
abstract class MovieDetailsEvent {}

class GetMovieDetails extends MovieDetailsEvent {
  final int movieId;

  GetMovieDetails(this.movieId);
}