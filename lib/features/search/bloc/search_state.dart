import '../../../data/models/movie_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<MovieModel> movies;
  final String query;
  final bool hasMore;
  final bool isLoadingMore;

  SearchSuccess({
    required this.movies,
    required this.query,
    required this.hasMore,
    this.isLoadingMore = false,
  });
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}