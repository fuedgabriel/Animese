import 'dart:convert';
import 'dart:ffi';

import 'package:animese/colors.dart';
import 'package:animese/request/json/categories_json.dart';
import 'package:animese/request/json/section_json.dart';
import 'package:animese/request/routes/anime_requests.dart';
import 'package:animese/screens/player/player_video.dart';
import 'package:flutter/material.dart';

//pages
import 'package:animese/screens/details/details_and_play.dart';
import 'package:animese/screens/home/home_appbar.dart';
import 'package:animese/request/json/season_json.dart';
import 'package:animese/screens/home/anime_list.dart';
//Json
import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/json/details_json.dart';
import 'package:shared_preferences/shared_preferences.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.season, required this.initial, required this.detailsInitial, required this.banner1, required this.detailsBanner1, required this.banner2, required this.detailsBanner2, required this.banner3, required this.detailsBanner3, required this.section, required this.isLogged, required this.categorias,});
  final List<SectionJson> section;
  final AnimeJson initial;
  final DetailsJson detailsInitial;

  final AnimeJson banner1;
  final DetailsJson detailsBanner1;

  final AnimeJson banner2;
  final DetailsJson detailsBanner2;

  final AnimeJson banner3;
  final DetailsJson detailsBanner3;

  final List<CategoriesJson> categorias;

  final SeasonJson season;

  final bool isLogged;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double offset = 0.0;

  @override
  void initState() {
    _scrollController
      .addListener(() {
        setState(() {
          offset = _scrollController.offset;

        });
      });
    super.initState();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(scrollOffset: offset, isLogged: widget.isLogged,),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          controller: _scrollController,
          slivers:  [
            //Header(),
            ContentHeader( anime: widget.initial, details: widget.detailsInitial,),
            Trends(title: widget.section[0].title.toString(), animeList: widget.section[0].anime!.toList(),),
            SeasonAnimes(season: widget.season, ),
            Trends(title: widget.section[1].title.toString(), animeList: widget.section[1].anime!.toList(),),
            Category(categorias: widget.categorias,),
            Trends(title: widget.section[2].title.toString(), animeList: widget.section[2].anime!.toList(),),
            OneTrend(anime: widget.banner1, details: widget.detailsBanner1,),
            Trends(title: widget.section[3].title.toString(), animeList: widget.section[3].anime!.toList(),),
            OneTrend(anime: widget.banner2, details: widget.detailsBanner2,),
            OneTrend(anime: widget.banner3, details: widget.detailsBanner3,),
          ],
        ),
      ),
      );
  }
}

class Category extends StatelessWidget {
  Category({
    super.key, required this.categorias,
  });
   final List<CategoriesJson> categorias;

  @override
  Widget build(BuildContext context) {
    List<Color> cor = [Colors.deepOrange, Colors.deepPurple, Colors.cyan, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.cyan, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.cyan, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.cyan, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent];
    return SliverToBoxAdapter(
        child: LayoutBuilder(
            builder: (_, constrains){
              return SizedBox(
                height: 140,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: categorias.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: (){
                        HomeRequest.getCategoriesAnimes(categorias[index].id, 0).then((value) {
                          List<AnimeJson> animes = json.decode(value.body)['animes'].map<AnimeJson>((json) => AnimeJson.fromJson(json)).toList();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AnimeList(animes: animes, title: categorias[index].name.toString(), id: categorias[index].id,
                          )));
                        });
                      },
                      child: AspectRatio(
                        aspectRatio: 13/13,
                        child: Card(
                          color: cor[index],
                          child: Container(
                            alignment: Alignment.center,
                            width: 400,
                            height: 100,
                            child: Text(categorias[index].name.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
        )
    );
}
}

class OneTrend extends StatelessWidget {
  const OneTrend({
    super.key, required this.anime, required this.details,
  });
  final AnimeJson anime;
  final DetailsJson details;


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AspectRatio(
          aspectRatio: 16/15.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 16/9,
                  child: Image(
                    image: NetworkImage(details.banner.toString()),
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                  ),
                ),
                Text(
                  anime.mainTitle.toString().length > 26 ? '${anime.mainTitle.toString().substring(0, 26)}...' : anime.mainTitle.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      wordSpacing: 2.0,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Divider(
                  color: Colors.cyan,
                  height: 8,
                  thickness: 2.8,
                  indent: 3,
                  endIndent: 3,
                ),
                Text(
                  details.description!.length > 150 ?
                  '${details.description!.substring(0, 150)}...' :
                  details.description.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton.icon(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAndPlay(anime: anime, details: details,)));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.cyan,
                        ),
                        icon: const Icon(Icons.play_arrow_outlined, color: Colors.black, size: 30,),
                        label: const Text(
                          'Assistir',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: (){
                          favoriteAnime(anime.id, context);
                        },
                        icon: const Icon(Icons.add, color: Colors.cyan, size: 35,)
                    )
                  ],
                ),

              ],
            ),
          )
      ),
    );
  }
}

void favoriteAnime(idAnime, context) async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var tempUser = prefs.getString('id');
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
}

class ContentHeader extends StatelessWidget {
  const ContentHeader({
    super.key, required this.anime, required this.details,
  });
  final AnimeJson anime;
  final DetailsJson details;






  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 500,
            decoration:  BoxDecoration(
              image:  DecorationImage(
                image: NetworkImage(anime.image.toString()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 500,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AnimeseColors.background,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 150,
              child: SizedBox(
                width: 300,
                child: Image.network(details.imageName.toString()),
              ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: ()async{
                      favoriteAnime(anime.id, context);
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(height: 2,),
                        Text('Lista', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerVideo(anime: anime,)));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow, color: Colors.black,),
                    label: const Text('Play', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAndPlay(anime: anime, details: details,)));
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.info_outline, color: Colors.white),
                        SizedBox(height: 2,),
                        Text('Info', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}

class SeasonAnimes extends StatelessWidget {
  const SeasonAnimes({super.key, required this.season,});
  final SeasonJson season;


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: LayoutBuilder(
          builder: (_, constrains){
            return Padding(
                padding: const EdgeInsets.only(top: 0,bottom: 20, left: 10, ),
                child: SizedBox(
                  height: constrains.maxWidth*0.45,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 2, left: 10, bottom: 0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                  "Temporada de ${season.title}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AnimeList(animes: season.anime!.map((e) => AnimeJson.fromJson(e.toJson())).toList(), title: "Temporada de ${season.title}", )));
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Ver mais  ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SeasonList(season: season,),
                    ],
                  ),
                )
            );
          }
      )
    );
  }
}

class SeasonList extends StatelessWidget {
  const SeasonList({
    super.key, required this.season,
  });
  final SeasonJson season;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: LayoutBuilder(
            builder: (_, constraints){
              return ListView.builder(
                  itemCount: season.anime!.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  itemBuilder: (_, index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 13),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAndPlay(anime: AnimeJson.fromJson(season.anime![index].toJson()),)));
                        },
                        child:  Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.9),
                              radius: 65,
                              backgroundImage: NetworkImage(season.anime![index].image.toString()),
                            ),
                            Image.network('https://static.vecteezy.com/system/resources/previews/015/123/435/non_2x/winter-holiday-circle-frame-style-with-fall-shining-snow-png.png', fit: BoxFit.cover, width: 140,),
                          ],
                        )

                        // CircleAvatar(
                        //   radius: 70,
                        //   backgroundColor: const Color(0xffFDCF09),
                        //   child: CircleAvatar(
                        //     backgroundColor: Colors.black.withOpacity(0.9),
                        //     radius: 65,
                        //     backgroundImage: NetworkImage(season.anime![index].image.toString()),
                        //   ),
                        // ),
                      ),
                    );
                  }
              );
            }
        )
    );
  }
}


class TrendsShort extends StatelessWidget {
  const TrendsShort({super.key, required this.title,});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: AspectRatio(
          aspectRatio: 16/7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const ListRecents(),
            ],
          ),
        ),
      ),
    );
  }
}

class ListRecents extends StatelessWidget {
  const ListRecents({super.key,});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: LayoutBuilder(
            builder: (_, constraints){
              return ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 10, left: 20),
                itemBuilder: (_, index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth * 0.25,
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image(
                            image: NetworkImage('https://cdn.myanimelist.net/images/anime/1693/138042.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                },
              );
            }
        ) ,
    );
  }
}

class Trends extends StatelessWidget {
  const Trends({super.key, required this.title, required this.animeList});
  final String title;
  final List<AnimeJson> animeList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 0, left: 10),
        child: AspectRatio(
          aspectRatio: 16/13,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2, left: 10, bottom: 0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AnimeList(animes: animeList, title: title,)));
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Ver mais  ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListTrends(animeList: animeList,)
            ],
          ),
        ),
      )
    );
  }
}

class ListTrends extends StatelessWidget {
  const ListTrends({super.key,required this.animeList });
  final List<AnimeJson> animeList;


  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: LayoutBuilder(
          builder: (_, constraints){
            return ListView.builder(
              itemCount: animeList.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 10, left: 5, bottom: 0),
                itemBuilder: (_, index){
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: constraints.maxWidth*.375,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAndPlay(anime: animeList[index],)));
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: Image(
                              image: NetworkImage(animeList[index].image.toString()),
                              fit: BoxFit.cover,
                              height: constraints.maxHeight * 0.7,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2,),
                        Text(
                          animeList[index].mainTitle.toString().length > 26 ?
                            '${animeList[index].mainTitle.toString().substring(0, 26)}...' :
                          animeList[index].mainTitle.toString()
                          ,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                }
            );
          },
        )
    );
  }
}


