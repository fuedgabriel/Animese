import 'dart:convert';

import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/routes/anime_requests.dart';
import 'package:flutter/material.dart';
import 'categories_screen.dart';




class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {

  TextEditingController? searchController = TextEditingController();
  Color? colorSem = Colors.transparent;

  List<AnimeJson> animeList = [];
  List<AnimeJson> animeFound = [];
  List<AnimeJson> animeSearchPass = [];


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
          if(searchController!.text.isEmpty){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoriesScreen()),
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
        child: Icon((searchController!.text.isEmpty ? Icons.search : Icons.clear), color: searchController!.text.isEmpty ? Colors.white : Colors.red, size: 30,),
      ),
      body: SafeArea(
          child: ListView(
            controller: ScrollController(keepScrollOffset: false, initialScrollOffset: 0.0),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CategoriesScreen()),
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
                          Icons.settings_applications_outlined,
                          color: Colors.amber.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                // height: MediaQuery.of(context).size.height * 0.88,
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
                  itemCount: searchController!.text.isEmpty ? 0 : animeFound.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {

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
              const SizedBox(height: 10,),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: searchController!.text.isNotEmpty ? Container() : ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green,
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(color: Colors.green, width: 1),
                        ),
                        child: const Text("Arquiélogo", style: TextStyle(color: Colors.white,fontSize: 10 ),),
                        onPressed: (){

                        },
                      ),
                    );
                  },

                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 90,
                width: double.infinity,
                child: searchController!.text.isNotEmpty ? Container() : ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      height: 80,
                      width: 78,
                      padding: const EdgeInsets.only(right: 11),
                      alignment: Alignment.center,
                      child: OutlinedButton(
                        onPressed: () {
                          if(colorSem == Colors.transparent){
                            setState(() {
                              colorSem = Colors.green;
                            });
                          }else{
                            setState(() {
                              colorSem = Colors.transparent;
                            });
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green,
                          backgroundColor: colorSem,
                          side: const BorderSide(color: Colors.grey, width: 1),

                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("SEG", style: TextStyle(color: Colors.white,fontSize: 10 )),
                            Text("20", style: TextStyle(color: Colors.white,fontSize: 10 )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ListView.builder(
                controller: ScrollController(keepScrollOffset: true),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20 ),
                scrollDirection: Axis.vertical,
                itemCount: searchController!.text.isNotEmpty ? 0 : 10,
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
                                color: Colors.lightGreenAccent,
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
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        image: NetworkImage('https://cdn-eu.anidb.net/images/150/241329.jpg-thumb.jpg'),
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
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text('anime do nome', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                    SizedBox(height: 10,),
                                    Text('episódio 1024', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),),
                                    SizedBox(height: 10,),
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
