import '../../../data/models/movie_model.dart';

abstract class BrowseState {}

class BrowseInitial extends BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowseSuccess extends BrowseState {
  final List<MovieModel> movies;
  final String selectedGenre;
  final bool hasMore;
  final bool isLoadingMore;

  BrowseSuccess({
    required this.movies,
    required this.selectedGenre,
    required this.hasMore,
    this.isLoadingMore = false,
  });
}

class BrowseError extends BrowseState {
  final String message;

  BrowseError(this.message);
}