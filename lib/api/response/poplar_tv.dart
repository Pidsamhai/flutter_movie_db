class Tv {
  String? posterPath;
  double? popularity;
  int? id;
  String? backdropPath;
  double? voteAverage;
  String? overview;
  String? firstAirDate;
  List<String?> originCountry = [];
  List<int?> genreIds = [];
  String? originalLanguage;
  int? voteCount;
  String? name;
  String? originalName;

  Tv({
    this.posterPath,
    this.popularity,
    this.id,
    this.backdropPath,
    this.voteAverage,
    this.overview,
    this.firstAirDate,
    this.originCountry = const [],
    this.genreIds = const [],
    this.originalLanguage,
    this.voteCount,
    this.name,
    this.originalName,
  });
  Tv.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path']?.toString();
    popularity = json['popularity']?.toDouble();
    id = json['id']?.toInt();
    backdropPath = json['backdrop_path']?.toString();
    voteAverage = json['vote_average']?.toDouble();
    overview = json['overview']?.toString();
    firstAirDate = json['first_air_date']?.toString();
    if (json['origin_country'] != null) {
      final v = json['origin_country'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      originCountry = arr0;
    }
    if (json['genre_ids'] != null) {
      final v = json['genre_ids'];
      final arr0 = <int>[];
      v.forEach((v) {
        arr0.add(v.toInt());
      });
      genreIds = arr0;
    }
    originalLanguage = json['original_language']?.toString();
    voteCount = json['vote_count']?.toInt();
    name = json['name']?.toString();
    originalName = json['original_name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['poster_path'] = posterPath;
    data['popularity'] = popularity;
    data['id'] = id;
    data['backdrop_path'] = backdropPath;
    data['vote_average'] = voteAverage;
    data['overview'] = overview;
    data['first_air_date'] = firstAirDate;
    data['origin_country'] = originCountry;
    data['genre_ids'] = genreIds;
    data['original_language'] = originalLanguage;
    data['vote_count'] = voteCount;
    data['name'] = name;
    data['original_name'] = originalName;
    return data;
  }
}

class PopularTvResponse {
  int? page;
  List<Tv> results = [];
  int? totalResults;
  int? totalPages;

  PopularTvResponse({
    this.page,
    this.results = const [],
    this.totalResults,
    this.totalPages,
  });
  PopularTvResponse.fromJson(Map<String, dynamic> json) {
    page = json['page']?.toInt();
    if (json['results'] != null) {
      final v = json['results'];
      final arr0 = <Tv>[];
      v.forEach((v) {
        arr0.add(Tv.fromJson(v));
      });
      results = arr0;
    }
    totalResults = json['total_results']?.toInt();
    totalPages = json['total_pages']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    data['results'] = results;
    data['total_results'] = totalResults;
    data['total_pages'] = totalPages;
    return data;
  }
}
