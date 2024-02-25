class DetailsJson {
  AnimeDetail? animeDetail;

  DetailsJson({this.animeDetail});

  DetailsJson.fromJson(Map<String, dynamic> json) {
    animeDetail = json['AnimeDetail'] != null
        ? AnimeDetail.fromJson(json['AnimeDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (animeDetail != null) {
      data['AnimeDetail'] = animeDetail!.toJson();
    }
    return data;
  }
}

class AnimeDetail {
  String? id;
  String? banner;
  String? imageName;
  String? description;
  int? episodes;
  int? year;
  String? status;
  String? trailer;
  String? animeId;

  AnimeDetail(
      {this.id,
        this.banner,
        this.imageName,
        this.description,
        this.episodes,
        this.year,
        this.status,
        this.trailer,
        this.animeId});

  AnimeDetail.fromJson(Map<String, dynamic> json) {
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
