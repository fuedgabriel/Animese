class SeasonJson {
  Season? season;

  SeasonJson({this.season});

  SeasonJson.fromJson(Map<String, dynamic> json) {
    season =
    json['season'] != null ? Season.fromJson(json['season']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (season != null) {
      data['season'] = season!.toJson();
    }
    return data;
  }
}

class Season {
  String? id;
  String? title;
  int? year;
  int? number;
  List<Anime>? anime;

  Season({this.id, this.title, this.year, this.number, this.anime});

  Season.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    number = json['number'];
    if (json['anime'] != null) {
      anime = <Anime>[];
      json['anime'].forEach((v) {
        anime!.add(Anime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['year'] = year;
    data['number'] = number;
    if (anime != null) {
      data['anime'] = anime!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Anime {
  String? id;
  String? mainTitle;
  String? officialTitle;
  String? image;
  String? seasonId;
  String? sectionId;
  List<Categories>? categories;

  Anime(
      {this.id,
        this.mainTitle,
        this.officialTitle,
        this.image,
        this.seasonId,
        this.sectionId,
        this.categories});

  Anime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainTitle = json['main_title'];
    officialTitle = json['official_title'];
    image = json['image'];
    seasonId = json['seasonId'];
    sectionId = json['sectionId'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main_title'] = mainTitle;
    data['official_title'] = officialTitle;
    data['image'] = image;
    data['seasonId'] = seasonId;
    data['sectionId'] = sectionId;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? id;
  String? name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
