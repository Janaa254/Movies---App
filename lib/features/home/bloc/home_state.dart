import '../../../data/models/movie_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<MovieModel> movies;
  final bool hasMore;
  final bool isLoadingMore;

  HomeSuccess({
    required this.movies,
    required this.hasMore,
    this.isLoadingMore = false,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}