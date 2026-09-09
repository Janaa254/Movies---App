import '../../../data/models/movie_details_model.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsModel movie;
  final List<MovieDetailsModel> suggestions;
  final bool isFavorite;

  MovieDetailsSuccess({
    required this.movie,
    required this.suggestions,
    this.isFavorite = false,
  });

  MovieDetailsSuccess copyWith({
    MovieDetailsModel? movie,
    List<MovieDetailsModel>? suggestions,
    bool? isFavorite,
  }) {
    return MovieDetailsSuccess(
      movie: movie ?? this.movie,
      suggestions: suggestions ?? this.suggestions,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}