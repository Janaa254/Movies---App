import '../models/movie_details_model.dart';
import '../services/movie_api_service.dart';

class MovieRepository {
  final MovieApiService _apiService;

  MovieRepository({
    MovieApiService? apiService,
  }) : _apiService = apiService ?? MovieApiService();

  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await _apiService.getMovieDetails(movieId);

    final movieJson = response['data']['movie'];

    return MovieDetailsModel.fromJson(
      movieJson as Map<String, dynamic>,
    );
  }

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