import '../../../data/models/movie_details_model.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsModel movie;
  final List<MovieDetailsModel> suggestions;

  final bool isFavorite;
  final bool isInWatchlist;

  MovieDetailsSuccess({
    required this.movie,
    required this.suggestions,
    this.isFavorite = false,
    this.isInWatchlist = false,
  });

  MovieDetailsSuccess copyWith({
    MovieDetailsModel? movie,
    List<MovieDetailsModel>? suggestions,
    bool? isFavorite,
    bool? isInWatchlist,
  }) {
    return MovieDetailsSuccess(
      movie: movie ?? this.movie,
      suggestions: suggestions ?? this.suggestions,
      isFavorite: isFavorite ?? this.isFavorite,
      isInWatchlist:
      isInWatchlist ?? this.isInWatchlist,
    );
  }
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}