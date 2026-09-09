class MovieModel {
  final int id;
  final String title;
  final String? titleLong;
  final int? year;
  final double? rating;
  final String? mediumCoverImage;
  final String? largeCoverImage;
  final String? backgroundImage;
  final List<String> genres;

  MovieModel({
    required this.id,
    required this.title,
    this.titleLong,
    this.year,
    this.rating,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.backgroundImage,
    required this.genres,
  });

  factory MovieModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleLong: json['title_long'],
      year: json['year'],
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      mediumCoverImage:
      json['medium_cover_image'],
      largeCoverImage:
      json['large_cover_image'],
      backgroundImage:
      json['background_image'],
      genres: List<String>.from(
        json['genres'] ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'title_long': titleLong,
      'year': year,
      'rating': rating,
      'medium_cover_image':
      mediumCoverImage,
      'large_cover_image':
      largeCoverImage,
      'background_image':
      backgroundImage,
      'genres': genres,
    };
  }
}