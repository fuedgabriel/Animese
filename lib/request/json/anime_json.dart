class AnimeJson {
  String? id;
  String? mainTitle;
  String? officialTitle;
  String? image;
  String? seasonId;
  String? sectionId;

  AnimeJson(
      {this.id,
        this.mainTitle,
        this.officialTitle,
        this.image,
        this.seasonId,
        this.sectionId});

  AnimeJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainTitle = json['main_title'];
    officialTitle = json['official_title'];
    image = json['image'];
    seasonId = json['seasonId'];
    sectionId = json['sectionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main_title'] = mainTitle;
    data['official_title'] = officialTitle;
    data['image'] = image;
    data['seasonId'] = seasonId;
    data['sectionId'] = sectionId;
    return data;
  }
}
