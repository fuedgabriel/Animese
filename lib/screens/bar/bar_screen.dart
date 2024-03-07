import 'dart:convert';

import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/routes/anime_requests.dart';
import 'package:animese/screens/details/details_and_play.dart';
import 'package:animese/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class BarScreen extends StatelessWidget {
  const BarScreen({super.key, this.pageController});
  final pageController;




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 0,

        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 5,
            leading: const Padding(padding: EdgeInsets.only(left: 10), child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),),
            leadingWidth: 45,
            title: Image(
              image: const AssetImage('assets/images/nome.png'),
              height: 60,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.40,
            ),
            centerTitle: true,
            actions: <Widget> [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white, size: 30,),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
                },
              ),
            ],
            bottom:  const TabBar(
              tabs: [
                Tab(text: 'Favoritos'),
                Tab(text: 'Baixados'),
                Tab(text: 'Histórico'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const FavoriteList(),
              const Icon(Icons.directions_transit),
              Historic(pageController: pageController,)
            ],
          ),
        )
    );
  }
}

class Historic extends StatefulWidget {
  const Historic({super.key,this.pageController});
  final pageController;

  @override
  State<Historic> createState() => _HistoricState();
}

class _HistoricState extends State<Historic> {
  final List<String> ImagesCapass = ["https://cdn.myanimelist.net/images/anime/1188/136926.webp", "https://cdn.myanimelist.net/images/anime/1506/138982.jpg", "https://cdn.myanimelist.net/images/anime/1100/138338.jpg", "https://cdn.myanimelist.net/images/anime/1015/138006.jpg", "https://cdn.myanimelist.net/images/anime/1622/139331.jpg"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details){
        if(details.primaryVelocity! < 0){
          setState(() {
            widget.pageController.animateToPage(1,
                duration: const Duration(milliseconds: 200), curve: Curves.linear);
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: 16/12,
            ),
            scrollDirection: Axis.vertical,
            controller: ScrollController(keepScrollOffset: false),
            itemCount: ImagesCapass.length,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap: (){

                },
                child: ListView(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 16/8,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(0)),
                            child: Image(
                              image: NetworkImage(ImagesCapass[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                          shadows: [
                            Shadow(
                              blurRadius: 60,
                              color: Colors.black,
                            ),
                            Shadow(
                              blurRadius: 60,
                              color: Colors.black,
                            ),
                            Shadow(
                              blurRadius: 60,
                              color: Colors.black,
                            ),
                            Shadow(
                              blurRadius: 60,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 4,
                          right: 5,
                          child: Container(
                            height: 20,
                            width: 85,
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text('${index+2}m restantes',
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: (index+2)/10,
                      backgroundColor: Colors.black,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                    const Text('Nome do Anime', style: TextStyle(color: Colors.white38, fontSize: 12),),
                    Text('Episodio $index', style: const TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}

class FavoriteList extends StatefulWidget {
  const FavoriteList({
    super.key,
  });

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {

  List<AnimeJson> animesFavoritos = [];

  @override
  void initState() {
    super.initState();
    getFavoritos();
  }

  void getFavoritos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempUser = prefs.getString('userId') ?? '';
    AnimeRequest.getAnimeFavorite(tempUser).then((response){
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
      child: GridView.builder(
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
