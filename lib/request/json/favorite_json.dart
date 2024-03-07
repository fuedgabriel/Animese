class FavoriteJson {
  String? userId;
  String? animeId;
  String? status;

  FavoriteJson({this.userId, this.animeId, this.status});

  FavoriteJson.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    animeId = json['animeId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['animeId'] = animeId;
    data['status'] = status;
    return data;
  }
}
