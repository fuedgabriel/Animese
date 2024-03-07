import 'dart:convert';
import 'package:http/http.dart' as http;


String ip = '192.168.1.64';

class HomeRequest{
  static Future<http.Response> getHome() async {
    var url = Uri.http('$ip:3333', '/home', );
    var response = await http.get(url);
    return response;
  }
  static Future<http.Response> getSeason(id) async {
    var url = Uri.http('$ip:3333', '/season/$id',);
    var response = await http.get(url);
    return response;
  }

}


class AnimeRequest {
  static Future<http.Response> getAnime(String id) async {
    var url = Uri.http('$ip:3333', '/animes/$id',);
    var response = await http.get(url);
    return response;
  }

  static Future<http.Response> getAnimeSearch(String skip, String title) async {
    var url = Uri.http('$ip:3333', '/animes/search/$skip/$title',);
    var response = await http.get(url);
    return response;
  }

  static Future<http.Response> getDetails(String id) async {
    var url = Uri.http('$ip:3333', '/animeDetails/$id',);
    var response = await http.get(url);
    return response;
  }

  static Future<http.Response> getAnimeFavorite(String idUser) async {
    var url = Uri.http('$ip:3333', '/animeFavorite/$idUser',);
    var response = await http.get(url);
    return response;
  }

  static Future<int> favoriteAnime(String idAnime, String idUser) async {
    var url = Uri.http('$ip:3333', '/animeFavorite',);
    //FavoriteJson favoriteJson = FavoriteJson(userId: idUser, animeId: id, status: 'Lançamento');
    Map data = {
      'userId': idUser,
      'animeId': idAnime,
      'status': 'Lançamento'
    };
    var body = json.encode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"} ,body: body);
    return response.statusCode;
  }

  static Future<int> getFavoritesUserAnime(String idAnime, String idUser) async {
    var url = Uri.http('$ip:3333', '/animeFavorite/$idUser/$idAnime',);
    var response = await http.get(url);
    return response.statusCode;
  }

}