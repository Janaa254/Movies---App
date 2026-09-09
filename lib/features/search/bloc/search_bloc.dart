import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/movie_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository _repository;

  int _currentPage = 1;
  final int _limit = 20;

  bool _isLoadingMore = false;
  String _currentQuery = '';

  SearchBloc({
    MovieRepository? repository,
  })  : _repository = repository ?? MovieRepository(),
        super(SearchInitial()) {
    on<SearchMovies>(_onSearchMovies);
    on<LoadMoreSearchMovies>(_onLoadMoreSearchMovies);
  }

  Future<void> _onSearchMovies(
      SearchMovies event,
      Emitter<SearchState> emit,
      ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      _currentPage = 1;
      _currentQuery = query;

      final movies = await _repository.getMovies(
        page: _currentPage,
        limit: _limit,
        queryTerm: _currentQuery,
      );

      emit(
        SearchSuccess(
          movies: movies,
          query: _currentQuery,
          hasMore: movies.length == _limit,
        ),
      );
    } catch (e) {
      emit(
        SearchError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadMoreSearchMovies(
      LoadMoreSearchMovies event,
      Emitter<SearchState> emit,
      ) async {
    if (_isLoadingMore) {
      return;
    }

    final currentState = state;

    if (currentState is! SearchSuccess ||
        !currentState.hasMore ||
        _currentQuery.isEmpty) {
      return;
    }

    _isLoadingMore = true;

    emit(
      SearchSuccess(
        movies: currentState.movies,
        query: currentState.query,
        hasMore: currentState.hasMore,
        isLoadingMore: true,
      ),
    );

    try {
      final nextPage = _currentPage + 1;

      final newMovies = await _repository.getMovies(
        page: nextPage,
        limit: _limit,
        queryTerm: _currentQuery,
      );

      if (newMovies.isEmpty) {
        emit(
          SearchSuccess(
            movies: currentState.movies,
            query: currentState.query,
            hasMore: false,
          ),
        );

        return;
      }

      _currentPage = nextPage;

      emit(
        SearchSuccess(
          movies: [
            ...currentState.movies,
            ...newMovies,
          ],
          query: currentState.query,
          hasMore: newMovies.length == _limit,
        ),
      );
    } catch (e) {
      emit(
        SearchSuccess(
          movies: currentState.movies,
          query: currentState.query,
          hasMore: currentState.hasMore,
        ),
      );
    } finally {
      _isLoadingMore = false;
    }
  }
}