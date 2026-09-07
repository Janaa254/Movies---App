import 'package:dio/dio.dart';

import '../../network/dio_helper.dart';

class MovieApiService {
  final Dio _dio = DioHelper.dio;

  // Get movies for Home
  Future<Map<String, dynamic>> getMovies({
    int page = 1,
    int limit = 20,
    String? genre,
    String? sortBy,
  }) async {
    final response = await _dio.get(
      '/list_movies.json',
      queryParameters: {
        'page': page,
        'limit': limit,
        if (genre != null) 'genre': genre,
        if (sortBy != null) 'sort_by': sortBy,
      },
    );

    return response.data;
  }

  // Get movie details
  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final response = await _dio.get(
      '/movie_details.json',
      queryParameters: {
        'movie_id': movieId,
        'with_images': true,
        'with_cast': true,
      },
    );

    return response.data;
  }

  // Get movie suggestions
  Future<Map<String, dynamic>> getMovieSuggestions(
      int movieId,
      ) async {
    final response = await _dio.get(
      '/movie_suggestions.json',
      queryParameters: {
        'movie_id': movieId,
      },
    );

    return response.data;
  }
}