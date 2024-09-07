import 'dart:convert';

import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/json/week_json.dart';
import 'package:animese/request/routes/anime_requests.dart';
import 'package:animese/screens/details/details_and_play.dart';
import 'package:flutter/material.dart';
import 'categories_screen.dart';




class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {

  var controller = ScrollController();

  TextEditingController? searchController = TextEditingController();
  Color? colorSem = Colors.transparent;

  List<AnimeJson> animeList = [];
  List<AnimeJson> animeFound = [];
  List<AnimeJson> animeSearchPass = [];
  List<AnimeJson> animeCategory = [];
  List<AnimeJson> list = [];
  weekJson week = weekJson();
  int opWeek = 0;
  int opCategory = -1;

  String idCategory = '';


  void searchRequest(skip,title){
    AnimeRequest.getAnimeSearch(skip,title).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          animeList = json.decode(response.body).map<AnimeJson>((json) => AnimeJson.fromJson(json)).toList();
          animeFound = animeList.where((element) => element.mainTitle.toString().toLowerCase().contains(title.toLowerCase())).toList();
          animeFound = animeList.where((element) =>
          element.mainTitle.toString().toLowerCase().contains(title.toLowerCase()) ||
              element.officialTitle.toString().toLowerCase().contains(title.toLowerCase())
          ).toList();
          //print(animeFound);
          // animeFound.forEach((element) {
          //   print(element.mainTitle);
          // });
        });
      }
    });
  }


  void searchCategoryAnime(id,skip){
    HomeRequest.getCategoriesAnimes(id,skip).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          Map decoded = json.decode(response.body);
          Iterable lista = decoded['animes'];
          list = lista.map((model) => AnimeJson.fromJson(model)).toList();
          // print(animeCategory.length);
          animeCategory.addAll(list.map((f) => f).toList());
          // print(animeCategory.length);

          // animeCategory.add(json.decode(response.body)['animes'].map<AnimeJson>((json) => AnimeJson.fromJson(json)).toList());
          // animeCategory.addAll(json.decode(response.body)['animes'].map<AnimeJson>((json) => AnimeJson.fromJson(json)).toList());
          // animeFound = animeList;
          // searchController!.text = json.decode(response.body)['name'];
          // response.body.isEmpty ? animeFound = [] : animeList = json.decode(response.body).map<AnimeJson>((json) => AnimeJson.fromJson(json)).toList();
          // animeList = json.decode(response.body).map<AnimeJson>((json) => AnimeJson.fromJson(json['animes'])).toList();
          // animeFound = animeList;
        });
      }
    });
  }

  void getWeek(){
    try {
      HomeRequest.getWeek().then((response) {
        if (response.statusCode == 200) {
          setState(() {
            // week = json.decode(response.body).map<weekJson>((json) => weekJson.fromJson(json)).toList();
            week = weekJson.fromJson(json.decode(response.body));
          });
        }
      });
    } catch (e) {
      week = weekJson();
    }
  }
  int skip = 0;

  @override
  initState(){
    controller.addListener(() {
      if(controller.position.pixels == controller.position.maxScrollExtent ){
        if(opCategory != -1) {
          setState(() {
            skip += 15;
            searchCategoryAnime(idCategory, skip);
          });
        }
      }
    });
    super.initState();
    getWeek();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white38,
        elevation: 10,
        onPressed: () {
          if(searchController!.text.isEmpty){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoriesScreen()),
            );
          }else{
            searchController!.clear();
            setState(() {
              animeFound = [];
            });
          }
          searchController!.clear();
          setState(() {
            animeFound = [];
          });
        },
        child: Icon((searchController!.text.isEmpty ? Icons.category : Icons.clear), color: searchController!.text.isEmpty ? Colors.white : Colors.red, size: 30,),
      ),
      body: SafeArea(
          child: ListView(
            controller: controller,
            children: [
              //barra de pesquisa
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Center(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.80,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10))
                        ),
                        child: TextField(
                          autofocus: false,
                          style: TextStyle(color: Colors.white.withOpacity(0.8)),
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              searchRequest('0',value);
                            });
                          },
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  searchController!.clear();
                                  setState(() {
                                    animeFound = [];
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.cyan.withOpacity(0.6),
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.cyan,
                              ),
                              hintText: 'Procurar...',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF292B37),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF292B37),
                              blurRadius: 4,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.category,
                          color: Colors.cyan.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //barra de pesquisa


              //lista dos animes pesquisados
              SizedBox(
                // height: MediaQuery.of(context).size.height * 0.88,
                child: searchController!.text.isNotEmpty && animeFound.isEmpty ? Center(
                  heightFactor: 10,
                  child: Text(
                    'Nenhum anime encontrado!',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ) : ListView.builder(
                  controller: ScrollController(keepScrollOffset: true),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10 ),
                  scrollDirection: Axis.vertical,
                  itemCount: searchController!.text.isEmpty ? 0 : animeFound.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAndPlay(anime: animeFound[index],)));
                      },
                      splashColor: Colors.cyan,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 120,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(animeFound[index].image.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text((animeFound[index].mainTitle.toString()), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Text((animeFound[index].officialTitle.toString()), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),),
                                  const SizedBox(height: 10,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              //lista dos animes pesquisados


              //lista de categorias
              SizedBox(
                height: 30,
                width: double.infinity,
                child: searchController!.text.isNotEmpty ? Container() : ListView.builder(
                  itemCount: week.toJson().isEmpty ? 0 : week.categories!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.cyan,
                          backgroundColor: opCategory == index ? Colors.cyan : Colors.transparent,
                          side: const BorderSide(color: Colors.cyan, width: 1),
                        ),
                        child: Text(week.categories![index].name.toString(), style: const TextStyle(color: Colors.white,fontSize: 10 ),),
                        onPressed: (){
                          setState(() {
                            if(opCategory == index){
                              print('igual');
                              // opCategory = opWeek;
                            }else{
                              opCategory = index;
                              opWeek = -1;
                              idCategory = week.categories![index].id.toString();
                              skip = 0;
                              animeCategory.clear();
                              searchCategoryAnime(week.categories![index].id.toString(), skip);
                            }
                          });

                        },
                      ),
                    );
                  },
                ),
              ),
              //lista de categorias

              const SizedBox(height: 20,),

              //lista do dia
              SizedBox(
                height: 100,
                width: double.infinity,
                child: searchController!.text.isNotEmpty ? Container() : ListView.builder(
                  itemCount: week.toJson().isEmpty ? 0 : week.weeks!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3), // Adjust padding as needed
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            opWeek = index;
                            opCategory = -1;
                            animeCategory = [];
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          alignment: Alignment.center,
                          foregroundColor: Colors.cyan,
                          backgroundColor: opWeek == index ? Colors.cyan : Colors.transparent,
                          fixedSize: const Size(70, 90),
                          side: const BorderSide(color: Colors.cyan, width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(week.weeks![index].title.toString().substring(0,3), style: const TextStyle(color: Colors.white,fontSize: 10 )),
                            const SizedBox(height: 10,),
                            Text(week.weeks![index].datetime.toString().substring(5,10).replaceAll('-', '/'), style: const TextStyle(color: Colors.white,fontSize: 8 )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              //lista do dia


              //lista de animes do dia
              if (opCategory == -1) ListView.builder(
                controller: ScrollController(keepScrollOffset: true),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20 ),
                scrollDirection: Axis.vertical,
                itemCount: searchController!.text.isNotEmpty ? 0 : week.toJson().isEmpty ? 0 : week.weeks![opWeek].anime!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {

                    },
                    splashColor: Colors.cyan,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Card(
                                  color: Colors.cyan,
                                  child: SizedBox(
                                    height: 10,
                                    width: 20,
                                  ),
                                ),
                                Text('15:00', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: <Widget>[
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 120,
                                      decoration:  BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        image: DecorationImage(
                                          image: NetworkImage(week.weeks![opWeek].anime![index].image.toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.play_arrow_outlined,
                                      color: Colors.white.withOpacity(0.8),
                                      size: 40,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(week.weeks![opWeek].anime![index].mainTitle.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                      const SizedBox(height: 10,),
                                      const Text('episódio 1024', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Divider(
                              color: Colors.cyan.withOpacity(0.8),
                              thickness: 1,
                            ),
                            const SizedBox(height: 10,),
                          ],
                        )
                    ),
                  );
                },
              ) else ListView.builder(
                controller: ScrollController(keepScrollOffset: true),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20 ),
                scrollDirection: Axis.vertical,
                itemCount: searchController!.text.isNotEmpty ? 0 : animeCategory.isEmpty ? 0 : animeCategory.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAndPlay(anime: animeCategory[index],)));
                    },
                    splashColor: Colors.cyan,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Row(
                              children: <Widget>[
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 120,
                                      decoration:  BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        image: DecorationImage(
                                          image: NetworkImage(animeCategory[index].image.toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.play_arrow_outlined,
                                      color: Colors.white.withOpacity(0.8),
                                      size: 40,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(animeCategory[index].mainTitle.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                      const SizedBox(height: 10,),
                                      Text(animeCategory[index].officialTitle.toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Divider(
                              color: Colors.cyan.withOpacity(0.8),
                              thickness: 1,
                            ),
                            const SizedBox(height: 10,),
                          ],
                        )
                    ),
                  );
                },
              ),

            ],
          )
      ),
    );
  }
}
