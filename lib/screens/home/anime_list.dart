import 'dart:convert';

import 'package:animese/colors.dart';
import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/routes/anime_requests.dart';
import 'package:animese/screens/details/details_and_play.dart';
import 'package:flutter/material.dart';



class AnimeList extends StatefulWidget {
  const AnimeList({super.key, required this.animes, required this.title, this.id});
  final List<AnimeJson> animes;
  final String title;
  final String? id;


  @override
  State<AnimeList> createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  var controller = ScrollController();
  int skip = 0;


  @override
  initState(){
    controller.addListener(() {
      if(controller.position.pixels == controller.position.maxScrollExtent && widget.id != null){
        setState(() {
          skip += 15;
          HomeRequest.getCategoriesAnimes(widget.id, skip).then((value) {
            List<AnimeJson> animesrequest = json.decode(value.body)['animes'].map<AnimeJson>((json) => AnimeJson.fromJson(json)).toList();
            widget.animes.addAll(animesrequest);
          });

        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        centerTitle: true,
        backgroundColor: AnimeseColors.background,
        elevation: 5,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30,),
        ),
      ),
      body: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.7  ),
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10),
          controller: controller,
          itemCount: widget.animes.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAndPlay(anime: widget.animes[index],)));
              },
              child: Container(
                margin: const EdgeInsets.all(3),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image(
                        height: 300,
                        width: 180,
                        image: NetworkImage(widget.animes[index].image.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 30,
                        width: 200,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                          color: Colors.black54,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.animes[index].mainTitle.toString().length > 20 ? '${widget.animes[index].mainTitle.toString().substring(0, 20)}...' : widget.animes[index].mainTitle.toString(),
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            );
          }
      ),
    );
  }
}

