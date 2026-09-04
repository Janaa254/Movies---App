import 'package:dio/dio.dart';

import '../../network/dio_helper.dart';

class MovieApiService {
  final Dio _dio = DioHelper.dio;

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