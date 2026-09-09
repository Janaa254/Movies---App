import '../models/movie_details_model.dart';
import '../models/movie_model.dart';
import '../services/movie_api_service.dart';

class MovieRepository {
  final MovieApiService _apiService;

  MovieRepository({
    MovieApiService? apiService,
  }) : _apiService = apiService ?? MovieApiService();

  // Get movies for Home / Browse / Search
  Future<List<MovieModel>> getMovies({
    int page = 1,
    int limit = 20,
    String? genre,
    String? sortBy,
    String? queryTerm,
  }) async {
    final response = await _apiService.getMovies(
      page: page,
      limit: limit,
      genre: genre,
      sortBy: sortBy,
      queryTerm: queryTerm,
    );

    final movies =
        response['data']['movies'] as List<dynamic>? ?? [];

    return movies
        .map(
          (movie) => MovieModel.fromJson(
        movie as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  // Get movie details
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await _apiService.getMovieDetails(movieId);

    final movieJson = response['data']['movie'];

    return MovieDetailsModel.fromJson(
      movieJson as Map<String, dynamic>,
    );
  }

  // Get movie suggestions
  Future<List<MovieDetailsModel>> getMovieSuggestions(
      int movieId,
      ) async {
    final response = await _apiService.getMovieSuggestions(movieId);

    final movies =
        response['data']['movies'] as List<dynamic>? ?? [];

    return movies
        .map(
          (movie) => MovieDetailsModel.fromJson(
        movie as Map<String, dynamic>,
      ),
    )
        .toList();
  }
}