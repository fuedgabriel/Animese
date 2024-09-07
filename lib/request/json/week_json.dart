import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/json/categories_json.dart';

class weekJson {
  List<Weeks>? weeks;
  List<CategoriesJson>? categories;

  weekJson({this.weeks, this.categories});

  weekJson.fromJson(Map<String, dynamic> json) {
    if (json['weeks'] != null) {
      weeks = <Weeks>[];
      json['weeks'].forEach((v) {
        weeks!.add(Weeks.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <CategoriesJson>[];
      json['categories'].forEach((v) {
        categories!.add(CategoriesJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (weeks != null) {
      data['weeks'] = weeks!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weeks {
  String? id;
  String? title;
  String? datetime;
  List<AnimeJson>? anime;

  Weeks({this.id, this.title, this.datetime, this.anime});

  Weeks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    datetime = json['datetime'];
    if (json['anime'] != null) {
      anime = <AnimeJson>[];
      json['anime'].forEach((v) {
        anime!.add(AnimeJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['datetime'] = datetime;
    if (anime != null) {
      data['anime'] = anime!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

