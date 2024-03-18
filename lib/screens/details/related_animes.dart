import 'package:animese/request/json/anime_json.dart';
import 'package:animese/screens/details/details_and_play.dart';
import 'package:flutter/material.dart';
import '';

class RelatedAnimes extends StatelessWidget {
  const RelatedAnimes({Key? key, required this.animes}) : super(key: key);
  final List<AnimeJson> animes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        controller: ScrollController(keepScrollOffset: false),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.7,  ),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10),
        itemCount: animes.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAndPlay(anime: animes[index],)));
              },
              child: Container(
                margin: const EdgeInsets.all(3),
                height: 200,
                width: 180,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image(
                        height: 180,
                        width: 120,
                        image: NetworkImage(animes[index].image.toString()),
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
                              Text(animes[index].mainTitle.toString().length > 20 ? '${animes[index].mainTitle.toString().substring(0, 20)}...' : animes[index].mainTitle.toString(),
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
    );
  }
}
