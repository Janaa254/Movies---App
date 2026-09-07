import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/movie_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository _repository;

  int _currentPage = 1;
  final int _limit = 20;
  bool _isLoadingMore = false;

  HomeBloc({
    MovieRepository? repository,
  })  : _repository = repository ?? MovieRepository(),
        super(HomeInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
  }

  Future<void> _onLoadMovies(
      LoadMovies event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading());

    try {
      _currentPage = 1;

      final movies = await _repository.getMovies(
        page: _currentPage,
        limit: _limit,
      );

      emit(
        HomeSuccess(
          movies: movies,
          hasMore: movies.length == _limit,
        ),
      );
    } catch (e) {
      emit(
        HomeError(e.toString()),
      );
    }
  }

  Future<void> _onLoadMoreMovies(
      LoadMoreMovies event,
      Emitter<HomeState> emit,
      ) async {
    if (_isLoadingMore) return;

    final currentState = state;

    if (currentState is! HomeSuccess ||
        !currentState.hasMore) {
      return;
    }

    _isLoadingMore = true;

    emit(
      HomeSuccess(
        movies: currentState.movies,
        hasMore: currentState.hasMore,
        isLoadingMore: true,
      ),
    );

    try {
      final nextPage = _currentPage + 1;

      final newMovies = await _repository.getMovies(
        page: nextPage,
        limit: _limit,
      );

      if (newMovies.isEmpty) {
        emit(
          HomeSuccess(
            movies: currentState.movies,
            hasMore: false,
          ),
        );
        return;
      }

      _currentPage = nextPage;

      emit(
        HomeSuccess(
          movies: [
            ...currentState.movies,
            ...newMovies,
          ],
          hasMore: newMovies.length == _limit,
        ),
      );
    } catch (e) {
      emit(
        HomeSuccess(
          movies: currentState.movies,
          hasMore: currentState.hasMore,
        ),
      );
    } finally {
      _isLoadingMore = false;
    }
  }
}