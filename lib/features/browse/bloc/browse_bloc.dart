import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/movie_repository.dart';
import 'browse_event.dart';
import 'browse_state.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  final MovieRepository _repository;

  int _currentPage = 1;
  final int _limit = 20;

  bool _isLoadingMore = false;

  String _selectedGenre = 'Action';

  BrowseBloc({
    MovieRepository? repository,
  })  : _repository = repository ?? MovieRepository(),
        super(BrowseInitial()) {
    on<LoadBrowseMovies>(_onLoadMovies);
    on<ChangeGenre>(_onChangeGenre);
    on<LoadMoreBrowseMovies>(_onLoadMoreMovies);
  }

  Future<void> _onLoadMovies(
      LoadBrowseMovies event,
      Emitter<BrowseState> emit,
      ) async {
    emit(BrowseLoading());

    try {
      _currentPage = 1;

      final movies = await _repository.getMovies(
        page: _currentPage,
        limit: _limit,
        genre: _selectedGenre,
      );

      emit(
        BrowseSuccess(
          movies: movies,
          selectedGenre: _selectedGenre,
          hasMore: movies.length == _limit,
        ),
      );
    } catch (e) {
      emit(
        BrowseError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _onChangeGenre(
      ChangeGenre event,
      Emitter<BrowseState> emit,
      ) async {
    if (_selectedGenre == event.genre) {
      return;
    }

    _selectedGenre = event.genre;

    emit(BrowseLoading());

    try {
      _currentPage = 1;

      final movies = await _repository.getMovies(
        page: _currentPage,
        limit: _limit,
        genre: _selectedGenre,
      );

      emit(
        BrowseSuccess(
          movies: movies,
          selectedGenre: _selectedGenre,
          hasMore: movies.length == _limit,
        ),
      );
    } catch (e) {
      emit(
        BrowseError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadMoreMovies(
      LoadMoreBrowseMovies event,
      Emitter<BrowseState> emit,
      ) async {
    if (_isLoadingMore) {
      return;
    }

    final currentState = state;

    if (currentState is! BrowseSuccess ||
        !currentState.hasMore) {
      return;
    }

    _isLoadingMore = true;

    emit(
      BrowseSuccess(
        movies: currentState.movies,
        selectedGenre: currentState.selectedGenre,
        hasMore: currentState.hasMore,
        isLoadingMore: true,
      ),
    );

    try {
      final nextPage = _currentPage + 1;

      final newMovies = await _repository.getMovies(
        page: nextPage,
        limit: _limit,
        genre: _selectedGenre,
      );

      if (newMovies.isEmpty) {
        emit(
          BrowseSuccess(
            movies: currentState.movies,
            selectedGenre: currentState.selectedGenre,
            hasMore: false,
          ),
        );

        return;
      }

      _currentPage = nextPage;

      emit(
        BrowseSuccess(
          movies: [
            ...currentState.movies,
            ...newMovies,
          ],
          selectedGenre: currentState.selectedGenre,
          hasMore: newMovies.length == _limit,
        ),
      );
    } catch (e) {
      emit(
        BrowseSuccess(
          movies: currentState.movies,
          selectedGenre: currentState.selectedGenre,
          hasMore: currentState.hasMore,
        ),
      );
    } finally {
      _isLoadingMore = false;
    }
  }
}