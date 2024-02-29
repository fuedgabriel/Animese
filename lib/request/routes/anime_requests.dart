import 'package:http/http.dart' as http;




class HomeRequest{
  static Future<http.Response> getHome() async {
    var url = Uri.http('192.168.1.64:3333', '/home', );
    var response = await http.get(url);
    return response;
  }
  static Future<http.Response> getSeason(id) async {
    var url = Uri.http('192.168.1.64:3333', '/season/$id',);
    var response = await http.get(url);
    return response;
  }

}


class AnimeRequest {
  static Future<http.Response> getAnime(String id) async {
    var url = Uri.http('192.168.1.64:3333', '/animes/$id', );
    var response = await http.get(url);
    return response;
  }

  static Future<http.Response> getAnimeSearch(String skip,String title) async {
    var url = Uri.http('192.168.1.64:3333', '/animes/search/$skip/$title', );
    var response = await http.get(url);
    return response;
  }
  static Future<http.Response> getDetails(String id) async {
    var url = Uri.http('192.168.1.64:3333', '/animeDetails/$id', );
    var response = await http.get(url);
    return response;
  }

}

