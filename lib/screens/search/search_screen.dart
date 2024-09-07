import 'dart:convert';

import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/routes/anime_requests.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animese/screens/details/details_and_play.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController? searchController = TextEditingController();
  List<AnimeJson> animeSearchPass = [];


  @override
  void initState() {
    searchShared();
    super.initState();
  }


  List<AnimeJson> animeList = [];
  List<AnimeJson> animeFound = [];



  void searchShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var temp = prefs.getString('search');
    try {
      setState(() {
        animeSearchPass = json.decode(temp!).map<AnimeJson>((json) => AnimeJson.fromJson(json)).toList();
      });
    } catch (e) {
      //print(e);
    }
  }

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white38,
        elevation: 10,
        onPressed: () {
          searchController!.clear();
          setState(() {
            animeFound = [];
          });
        },
        child: Icon((searchController!.text.isEmpty ? Icons.search : Icons.clear), color: searchController!.text.isEmpty ? Colors.amber : Colors.red, size: 30,),
      ),
      body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            controller: ScrollController(keepScrollOffset: false, initialScrollOffset: 0.0),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
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
                          autofocus: true,
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
                                  color: Colors.amber.withOpacity(0.6),
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.amber,
                              ),
                              hintText: 'Procurar...',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.88,
                child: searchController!.text.isNotEmpty && animeFound.isEmpty ? Center(
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
                  itemCount: searchController!.text.isEmpty ? animeSearchPass.length : animeFound.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        if(searchController!.text.isNotEmpty){
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          var temp = prefs.getString('search');
                          if(temp != null){
                            //adiciona o item na lista já preenchida com outra coisa
                            List<AnimeJson> animeSharedList = json.decode(temp).map<AnimeJson>((json) => AnimeJson.fromJson(json)).toList();
                            animeSharedList.removeWhere((element) => element.id == animeFound[index].id); // remove o item da lista
                            animeSharedList.length >= 10 ? animeSharedList.removeLast() : null; // remove o ultimo item da lista
                            animeSharedList.insert(0,animeFound[index]); // adiciona o elemento como primeiro da lista
                            var saveData = json.encode(animeSharedList);
                            await prefs.setString('search', saveData);
                          }else{
                            //primeiro item a ser adicionado
                            List<AnimeJson> animeSharedList = [];
                            animeSharedList.add(animeFound[index]);
                            var saveData = json.encode(animeSharedList);
                            await prefs.setString('search', saveData);
                          }
                        }else{
                          //adiciona o item na lista já preenchida com um item da propria lista
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          AnimeJson animeTemp = animeSearchPass[index];
                          animeSearchPass.removeWhere((element) => element.id == animeSearchPass[index].id); // remove o item da lista
                          animeSearchPass.insert(0,animeTemp);
                          var saveData = json.encode(animeSearchPass);
                          await prefs.setString('search', saveData);
                          // prefs.remove('search');
                          // var temp = prefs.getString('search');
                          // debugPrint(temp);
                        }
                        setState(() {
                          animeSearchPass;
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAndPlay(anime: searchController!.text.isEmpty ? animeSearchPass[0] : animeFound[index],)));
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
                                  image: NetworkImage(searchController!.text.isEmpty ? animeSearchPass[index].image.toString() : animeFound[index].image.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text((searchController!.text.isEmpty ? animeSearchPass[index].mainTitle.toString() : animeFound[index].mainTitle.toString()), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Text((searchController!.text.isEmpty ? animeSearchPass[index].officialTitle.toString() : animeFound[index].officialTitle.toString()), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),),
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
              )
            ],
          )
      ),
    );
  }
}
