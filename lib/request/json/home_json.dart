class HomeJson {
  List<Sections>? sections;
  Anime? initial;
  InitialDetails? initialDetails;
  Anime? banner1;
  Banner1Details? banner1Details;
  Anime? banner2;
  Banner1Details? banner2Details;
  Anime? banner3;
  Banner1Details? banner3Details;

  HomeJson(
      {this.sections,
        this.initial,
        this.initialDetails,
        this.banner1,
        this.banner1Details,
        this.banner2,
        this.banner2Details,
        this.banner3,
        this.banner3Details});

  HomeJson.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
    initial =
    json['initial'] != null ? Anime.fromJson(json['initial']) : null;
    initialDetails = json['initialDetails'] != null
        ? InitialDetails.fromJson(json['initialDetails'])
        : null;
    banner1 =
    json['banner1'] != null ? Anime.fromJson(json['banner1']) : null;
    banner1Details = json['banner1Details'] != null
        ? Banner1Details.fromJson(json['banner1Details'])
        : null;
    banner2 =
    json['banner2'] != null ? Anime.fromJson(json['banner2']) : null;
    banner2Details = json['banner2Details'] != null
        ? Banner1Details.fromJson(json['banner2Details'])
        : null;
    banner3 =
    json['banner3'] != null ? Anime.fromJson(json['banner3']) : null;
    banner3Details = json['banner3Details'] != null
        ? Banner1Details.fromJson(json['banner3Details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    if (initial != null) {
      data['initial'] = initial!.toJson();
    }
    if (initialDetails != null) {
      data['initialDetails'] = initialDetails!.toJson();
    }
    if (banner1 != null) {
      data['banner1'] = banner1!.toJson();
    }
    if (banner1Details != null) {
      data['banner1Details'] = banner1Details!.toJson();
    }
    if (banner2 != null) {
      data['banner2'] = banner2!.toJson();
    }
    if (banner2Details != null) {
      data['banner2Details'] = banner2Details!.toJson();
    }
    if (banner3 != null) {
      data['banner3'] = banner3!.toJson();
    }
    if (banner3Details != null) {
      data['banner3Details'] = banner3Details!.toJson();
    }
    return data;
  }
}

class Sections {
  String? id;
  String? title;
  List<Anime>? anime;

  Sections({this.id, this.title, this.anime});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
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

class InitialDetails {
  String? id;
  String? banner;
  String? imageName;
  String? description;
  int? episodes;
  int? year;
  String? status;
  String? trailer;
  String? animeId;

  InitialDetails(
      {this.id,
        this.banner,
        this.imageName,
        this.description,
        this.episodes,
        this.year,
        this.status,
        this.trailer,
        this.animeId});

  InitialDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    imageName = json['image_name'];
    description = json['description'];
    episodes = json['episodes'];
    year = json['year'];
    status = json['status'];
    trailer = json['trailer'];
    animeId = json['animeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner'] = banner;
    data['image_name'] = imageName;
    data['description'] = description;
    data['episodes'] = episodes;
    data['year'] = year;
    data['status'] = status;
    data['trailer'] = trailer;
    data['animeId'] = animeId;
    return data;
  }
}

class Banner1Details {
  String? id;
  String? banner;
  String? imageName;
  String? description;
  int? episodes;
  int? year;
  String? status;
  String? trailer;
  String? animeId;

  Banner1Details(
      {this.id,
        this.banner,
        this.imageName,
        this.description,
        this.episodes,
        this.year,
        this.status,
        this.trailer,
        this.animeId});

  Banner1Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    imageName = json['image_name'];
    description = json['description'];
    episodes = json['episodes'];
    year = json['year'];
    status = json['status'];
    trailer = json['trailer'];
    animeId = json['animeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner'] = banner;
    data['image_name'] = imageName;
    data['description'] = description;
    data['episodes'] = episodes;
    data['year'] = year;
    data['status'] = status;
    data['trailer'] = trailer;
    data['animeId'] = animeId;
    return data;
  }
}
