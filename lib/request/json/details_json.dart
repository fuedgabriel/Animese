class DetailsJson {
  String? id;
  String? banner;
  String? imageName;
  String? description;
  int? episodes;
  int? year;
  String? status;
  String? trailer;
  String? animeId;

  DetailsJson(
      {this.id,
        this.banner,
        this.imageName,
        this.description,
        this.episodes,
        this.year,
        this.status,
        this.trailer,
        this.animeId});

  DetailsJson.fromJson(Map<String, dynamic> json) {
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
