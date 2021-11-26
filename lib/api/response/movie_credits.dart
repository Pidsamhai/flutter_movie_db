class Crew {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;

  Crew({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.creditId,
    this.department,
    this.job,
  });
  Crew.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender']?.toInt();
    id = json['id']?.toInt();
    knownForDepartment = json['known_for_department']?.toString();
    name = json['name']?.toString();
    originalName = json['original_name']?.toString();
    popularity = json['popularity']?.toDouble();
    profilePath = json['profile_path']?.toString();
    creditId = json['credit_id']?.toString();
    department = json['department']?.toString();
    job = json['job']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['original_name'] = originalName;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    data['credit_id'] = creditId;
    data['department'] = department;
    data['job'] = job;
    return data;
  }
}

class Cast {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });
  Cast.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender']?.toInt();
    id = json['id']?.toInt();
    knownForDepartment = json['known_for_department']?.toString();
    name = json['name']?.toString();
    originalName = json['original_name']?.toString();
    popularity = json['popularity']?.toDouble();
    profilePath = json['profile_path']?.toString();
    castId = json['cast_id']?.toInt();
    character = json['character']?.toString();
    creditId = json['credit_id']?.toString();
    order = json['order']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['original_name'] = originalName;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    data['cast_id'] = castId;
    data['character'] = character;
    data['credit_id'] = creditId;
    data['order'] = order;
    return data;
  }
}

class MovieCredits {
  int? id;
  List<Cast> cast = [];
  List<Crew> crew = [];

  MovieCredits({
    this.id,
    this.cast = const [],
    this.crew = const [],
  });
  MovieCredits.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    if (json['cast'] != null) {
      final v = json['cast'];
      final arr0 = <Cast>[];
      v.forEach((v) {
        arr0.add(Cast.fromJson(v));
      });
      cast = arr0;
    }
    if (json['crew'] != null) {
      final v = json['crew'];
      final arr0 = <Crew>[];
      v.forEach((v) {
        arr0.add(Crew.fromJson(v));
      });
      crew = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['cast'] = cast;
    data['crew'] = crew;
    return data;
  }
}
