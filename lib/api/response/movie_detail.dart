class SpokenLanguages {
  String? iso_639_1;
  String? name;

  SpokenLanguages({
    this.iso_639_1,
    this.name,
  });
  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    iso_639_1 = json['iso_639_1']?.toString();
    name = json['name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['iso_639_1'] = iso_639_1;
    data['name'] = name;
    return data;
  }
}

class ProductionCountries {
  String? iso_3166_1;
  String? name;

  ProductionCountries({
    this.iso_3166_1,
    this.name,
  });
  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso_3166_1 = json['iso_3166_1']?.toString();
    name = json['name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['iso_3166_1'] = iso_3166_1;
    data['name'] = name;
    return data;
  }
}

class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });
  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    logoPath = json['logo_path']?.toString();
    name = json['name']?.toString();
    originCountry = json['origin_country']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({
    this.id,
    this.name,
  });
  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class MovieDetail {
  bool? adult;
  String? backdropPath;
  String? belongsToCollection;
  int? budget;
  List<Genres?> genres = [];
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies?> productionCompanies = [];
  List<ProductionCountries?> productionCountries = [];
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguages?>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieDetail({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres = const [],
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies = const [],
    this.productionCountries = const [],
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  MovieDetail.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path']?.toString();
    belongsToCollection = json['belongs_to_collection']?.toString();
    budget = json['budget']?.toInt();
    if (json['genres'] != null) {
      final v = json['genres'];
      final arr0 = <Genres>[];
      v.forEach((v) {
        arr0.add(Genres.fromJson(v));
      });
      genres = arr0;
    }
    homepage = json['homepage']?.toString();
    id = json['id']?.toInt();
    imdbId = json['imdb_id']?.toString();
    originalLanguage = json['original_language']?.toString();
    originalTitle = json['original_title']?.toString();
    overview = json['overview']?.toString();
    popularity = json['popularity']?.toDouble();
    posterPath = json['poster_path']?.toString();
    if (json['production_companies'] != null) {
      final v = json['production_companies'];
      final arr0 = <ProductionCompanies>[];
      v.forEach((v) {
        arr0.add(ProductionCompanies.fromJson(v));
      });
      productionCompanies = arr0;
    }
    if (json['production_countries'] != null) {
      final v = json['production_countries'];
      final arr0 = <ProductionCountries>[];
      v.forEach((v) {
        arr0.add(ProductionCountries.fromJson(v));
      });
      productionCountries = arr0;
    }
    releaseDate = json['release_date']?.toString();
    revenue = json['revenue']?.toInt();
    runtime = json['runtime']?.toInt();
    if (json['spoken_languages'] != null) {
      final v = json['spoken_languages'];
      final arr0 = <SpokenLanguages>[];
      v.forEach((v) {
        arr0.add(SpokenLanguages.fromJson(v));
      });
      spokenLanguages = arr0;
    }
    status = json['status']?.toString();
    tagline = json['tagline']?.toString();
    title = json['title']?.toString();
    video = json['video'];
    voteAverage = json['vote_average']?.toDouble();
    voteCount = json['vote_count']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['belongs_to_collection'] = belongsToCollection;
    data['budget'] = budget;
    data['genres'] = genres;
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['production_companies'] = productionCompanies;
    data['production_countries'] = productionCountries;
    data['release_date'] = releaseDate;
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    if (spokenLanguages != null) {
      final v = spokenLanguages;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['spoken_languages'] = arr0;
    }
    data['status'] = status;
    data['tagline'] = tagline;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
