import 'package:animese/request/routes/anime_requests.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite{
  Future<bool> favoriteAnime(idAnime, context) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempUser = prefs.getString('id');
    bool result = false;
    if(tempUser != null){
      AnimeRequest.getFavoritesUserAnime(idAnime, tempUser).then((value) {
        if(value == 200){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Anime já adicionado aos favoritos'),
            backgroundColor: Colors.red,
          ));
        }else{
          AnimeRequest.favoriteAnime(idAnime, tempUser).then((value) {
            if(value == 201){
              result = true;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Anime adicionado aos favoritos'),
                backgroundColor: Colors.green,
              ));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Erro ao adicionar aos favoritos'),
                backgroundColor: Colors.red,
              ));
            }
          });
        }
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Você precisa estar logado para adicionar aos favoritos'),
        backgroundColor: Colors.red,
      ));
    }
    print(result);
    return result;
  }
}