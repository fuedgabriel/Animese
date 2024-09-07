import 'anime_json.dart';

class SectionJson {
  String? id;
  String? title;
  List<AnimeJson>? anime;

  SectionJson({this.id, this.title, this.anime});

  SectionJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
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
    if (anime != null) {
      data['anime'] = anime!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

