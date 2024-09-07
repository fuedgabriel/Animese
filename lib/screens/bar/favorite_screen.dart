import 'dart:convert';

import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/routes/anime_requests.dart';
import 'package:animese/screens/details/details_and_play.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteScreen> {

  List<AnimeJson> animesFavoritos = [];
  String id = '';

  @override
  void initState() {
    super.initState();
    getFavoritos();
  }

  void getFavoritos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    AnimeRequest.getAnimeFavorite(id).then((response){
      if(response.statusCode == 200){
        setState(() {
          animesFavoritos = json.decode(response.body)['animes'].map<AnimeJson>((json) => AnimeJson.fromJson(json)).toList();
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: id.isEmpty ? const Center(child: Text("Você precisa estar logado para favoritar um anime", style: TextStyle(color: Colors.white),),) :  GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            childAspectRatio: .70,
          ),
          scrollDirection: Axis.vertical,
          controller: ScrollController(keepScrollOffset: false),
          itemCount: animesFavoritos.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAndPlay(anime: animesFavoritos[index], favorite: true,)));
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image(
                      height: 300,
                      width: 300,
                      image: NetworkImage(animesFavoritos[index].image.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                  //sino de notificação
                  // const Positioned(
                  //   top: 10,
                  //   right: 5,
                  //   child: DecoratedBox(
                  //     decoration: BoxDecoration(
                  //       color: Colors.black54,
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //     child: Badge(
                  //       label: Text('2', style: TextStyle(color: Colors.white),),
                  //       child: Icon(Icons.notifications_active, color: Colors.yellow,),
                  //     ),
                  //   )
                  // ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 30,
                      width: 300,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        color: Colors.black54,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(animesFavoritos[index].mainTitle.toString().length > 20 ? '${animesFavoritos[index].mainTitle.toString().substring(0, 20)}...' : animesFavoritos[index].mainTitle.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            const Icon(Icons.favorite, color: Colors.white, size: 20,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}