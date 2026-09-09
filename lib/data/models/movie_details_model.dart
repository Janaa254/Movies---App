class MovieDetailsModel {
  final int id;
  final String title;
  final String? titleLong;
  final int? year;
  final double? rating;
  final int? runtime;
  final int? likeCount;
  final List<String> genres;
  final String? description;
  final String? summary;
  final String? largeCoverImage;
  final String? mediumCoverImage;
  final String? backgroundImage;
  final String? trailerCode;

  final List<String> screenshots;

  final List<CastModel> cast;

  MovieDetailsModel({
    required this.id,
    required this.title,
    this.titleLong,
    this.year,
    this.rating,
    this.runtime,
    required this.genres,
    this.description,
    this.summary,
    this.largeCoverImage,
    this.mediumCoverImage,
    this.backgroundImage,
    this.trailerCode,
    required this.screenshots,
    required this.cast, this.likeCount,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    final screenshots = <String>[];

    for (int i = 1; i <= 3; i++) {
      final image = json['large_screenshot_image$i'];

      if (image != null && image.toString().isNotEmpty) {
        screenshots.add(image.toString());
      }
    }

    final castJson = json['cast'] as List<dynamic>? ?? [];

    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleLong: json['title_long'],
      year: json['year'],
      rating: json['rating'] != null

          ? (json['rating'] as num).toDouble()
          : null,
      runtime: json['runtime'],
      likeCount: json['like_count'],
      genres: List<String>.from(json['genres'] ?? []),
      description: json['description_full'],
      summary: json['summary'] ?? json['description_full'],
      largeCoverImage: json['large_cover_image'],
      mediumCoverImage: json['medium_cover_image'],
      backgroundImage: json['background_image'],
      trailerCode: json['yt_trailer_code'],
      screenshots: screenshots,
      cast: castJson
          .map(
            (e) => CastModel.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}

class CastModel {
  final String name;
  final String character;
  final String? image;

  CastModel({
    required this.name,
    required this.character,
    this.image,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      image: json['image'],
    );
  }
}