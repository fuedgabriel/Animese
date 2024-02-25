// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/routes/anime_requests.dart';
import 'package:flutter/material.dart';
import 'package:animese/colors.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:animese/screens/player/player_video.dart';
import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/json/details_json.dart';

const List<String> list = <String>['1', '2', '3', '4'];
List<String> ImagesCapas = ["https://cdn-eu.anidb.net/images/main/248254.jpg", "https://cdn-eu.anidb.net/images/main/248466.jpg", "https://cdn-eu.anidb.net/images/main/248007.jpg", "https://cdn-eu.anidb.net/images/main/242518.jpg", "https://cdn-eu.anidb.net/images/main/247665.jpg",
  "https://cdn-eu.anidb.net/images/main/247925.jpg","https://cdn-eu.anidb.net/images/main/247715.jpg", "https://cdn-eu.anidb.net/images/main/247378.jpg",
  "https://cdn-eu.anidb.net/images/main/247207.jpg", "https://cdn-eu.anidb.net/images/main/245285.jpg", "https://cdn-eu.anidb.net/images/main/245193.jpg", "https://cdn-eu.anidb.net/images/main/247991.jpg",
  "https://cdn-eu.anidb.net/images/main/248781.jpg", "https://cdn-eu.anidb.net/images/main/242323.jpg", "https://cdn-eu.anidb.net/images/main/10806.jpeg",
  "https://cdn-eu.anidb.net/images/main/247259.jpg", "https://cdn-eu.anidb.net/images/main/244863.jpg", "https://cdn-eu.anidb.net/images/main/247604.jpg", "https://cdn-eu.anidb.net/images/main/248538.jpg"

];
List<String> kDemoImages = [
  'https://i.pinimg.com/originals/7f/91/a1/7f91a18bcfbc35570c82063da8575be8.jpg',
  'https://www.absolutearts.com/portfolio3/a/afifaridasiddique/Still_Life-1545967888l.jpg',
  'https://cdn11.bigcommerce.com/s-x49po/images/stencil/1280x1280/products/53415/72138/1597120261997_IMG_20200811_095922__49127.1597493165.jpg?c=2',
  'https://i.pinimg.com/originals/47/7e/15/477e155db1f8f981c4abb6b2f0092836.jpg',
  'https://images.saatchiart.com/saatchi/770124/art/3760260/2830144-QFPTZRUH-7.jpg',
  'https://images.unsplash.com/photo-1471943311424-646960669fbc?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c3RpbGwlMjBsaWZlfGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80',
  'https://cdn11.bigcommerce.com/s-x49po/images/stencil/1280x1280/products/40895/55777/1526876829723_P211_24X36__2018_Stilllife_15000_20090__91926.1563511650.jpg?c=2',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIUsxpakPiqVF4W_rOlq6eoLYboOFoxw45qw&usqp=CAU',
  'https://images.mojarto.com/photos/267893/large/DA-SL-01.jpg?1560834975',
];

class DetailsAndPlay extends StatefulWidget {


  const DetailsAndPlay({super.key, required this.anime, });
  final AnimeJson anime;
  @override
  State<DetailsAndPlay> createState() => _DetailsAndPlayState();
}

class _DetailsAndPlayState extends State<DetailsAndPlay> {
  //deatils
  IconData favorite = Icons.favorite_border;

  // Scroll controller for carousel
  late InfiniteScrollController _controller;

  // Maintain current index of carousel
  final int _selectedIndex = 0;

  // Width of each item
  double? _itemExtent;

  // Get screen width of viewport.
  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    DetailsAnime();
    super.initState();
    _controller = InfiniteScrollController(initialItem: _selectedIndex);
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemExtent = screenWidth - 200;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  DetailsJson detailAnime = DetailsJson();
  String Description = "";
  String Banner = "";

  void DetailsAnime() async {
    final response = await AnimeRequest.getDetails(widget.anime.id.toString());
    print("aaaa");
    setState(() {
      detailAnime = DetailsJson.fromJson(json.decode(response.body));
      Description = detailAnime.animeDetail!.description.toString();
      Banner = detailAnime.animeDetail!.banner.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.6,
            child: Image.network(
              Banner.toString() == "" ? widget.anime.image.toString() : Banner.toString(),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          child:  Image(
                            image: AssetImage('assets/images/nome.png'),
                            height: 40,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if(favorite == Icons.favorite_border){
                                favorite = Icons.favorite;
                              }else{
                                favorite = Icons.favorite_border;
                              }
                            });
                          },
                          child: Icon(
                            favorite,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  NameBody( title: widget.anime.mainTitle.toString() ,  image: widget.anime.image.toString(),),
                  const SizedBox(height: 20,),
                   ExpandableText(
                     Description.toString().isEmpty ? "Carregando descrição..." : Description.toString(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      wordSpacing: 1.5,
                    ),
                    animation: true,
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 5,
                    linkColor: Colors.blue,
                  ),
                  const SizedBox(height: 20,),
                  const Episodes(title: 'Episódios',),
                  const SizedBox(height: 20,),
                  const RelatedAnimes(),
                  const SizedBox(height: 20,),
                  const SimilarAnimes(),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SimilarAnimes extends StatelessWidget {
  const SimilarAnimes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Center(
              child: Text(
                'Animes Similares',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              )
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
              side: const BorderSide(color: Colors.red, width: 0.8, style: BorderStyle.solid)),
        ),
        const SizedBox(height: 10,),
        GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: .70,
            ),
            scrollDirection: Axis.vertical,
            controller: ScrollController(keepScrollOffset: false),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap: (){

                },
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image(
                    height: 300,
                    width: 300,
                    image: NetworkImage('https://cdn.myanimelist.net/images/anime/1693/138042.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
        ),
      ],
    );
  }
}

class RelatedAnimes extends StatelessWidget {
  const RelatedAnimes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ListTile(
          title: const Center(
              child: Text(
                'Animes Relacionados',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              )
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
              side: const BorderSide(color: Colors.red, width: 0.8, style: BorderStyle.solid)),
        ),
        const SizedBox(height: 10,),
        GridView.builder(
            shrinkWrap: true,
            controller: ScrollController(keepScrollOffset: false),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: .70,
            ),
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap: (){


                },
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image(
                    height: 300,
                    width: 300,
                    image: NetworkImage('https://cdn.myanimelist.net/images/anime/1693/138042.jpg'),
                    alignment: Alignment.center,
                    colorBlendMode: BlendMode.darken,
                    opacity: AlwaysStoppedAnimation(.80),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
        ),
      ],
    );
  }
}

class CustomTab extends StatelessWidget {
  final IconData icon;
  final String title;

  const CustomTab({super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }
}

class NameBody extends StatelessWidget {
  const NameBody({super.key, required this.title, required this.image,});
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SizedBox(
                  height: 200,
                  width: double.maxFinite,
                  child: Stack(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Positioned(
                          top: 110,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share),
                                color: Colors.red,
                                onPressed: (){

                                },
                              ),
                              // ElevatedButton(
                              //   onPressed: () {},
                              //   child: Icon(Icons.share, color: Colors.red,),
                              //   style: ButtonStyle(
                              //     shape: MaterialStateProperty.all(CircleBorder()),
                              //     padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                              //     backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.9)), // <-- Button color
                              //     overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                              //       if (states.contains(MaterialState.pressed)) return Colors.red; // <-- Splash color
                              //     }),
                              //   ),
                              // ),
                              const SizedBox(width: 5,),
                              ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.black,
                                      side: const BorderSide(color: Colors.red, width: 1.0, style: BorderStyle.solid),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
                                      enabledMouseCursor: SystemMouseCursors.click,
                                      backgroundColor: AnimeseColors.background.withOpacity(0),
                                      elevation: 1.0
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.download, color: Colors.red,),
                                      SizedBox(width: 2,),
                                      Text(
                                        "Download",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 3.0,
                                            color: Colors.red
                                        ),
                                      )
                                    ],
                                  )
                              )
                            ],
                          )
                      ),

                    ],
                  )
              ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayerVideo()));
                },
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      image,
                      fit: BoxFit.cover,
                      height: 200,
                      width: 150,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black.withOpacity(0.3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ]
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.red,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
        ],
      )
    );
  }
}

class Episodes extends StatelessWidget {
  const Episodes({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16/8.5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
                const DropdownButtonExample()

              ],
            ),
          ),
          const ListTrends()
        ],
      ),
    );
  }
}

class ListTrends extends StatelessWidget {

  const ListTrends({
    super.key
  });





  @override
  Widget build(BuildContext context) {
    List<String> ImagesCapass = ["https://cdn.myanimelist.net/images/anime/1188/136926.webp", "https://cdn.myanimelist.net/images/anime/1506/138982.jpg", "https://cdn.myanimelist.net/images/anime/1100/138338.jpg", "https://cdn.myanimelist.net/images/anime/1015/138006.jpg", "https://cdn.myanimelist.net/images/anime/1622/139331.jpg"];
    return Expanded(
        child: LayoutBuilder(
          builder: (_, constraints){
            return ListView.builder(
                itemCount: ImagesCapass.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 10, left: 20),
                itemBuilder: (_, index){
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          child: Image(
                            image: NetworkImage(ImagesCapass[index]),
                            fit: BoxFit.cover,
                            height: 200,
                            width: 130,
                            alignment: Alignment.center,
                            colorBlendMode: BlendMode.darken,
                            opacity: const AlwaysStoppedAnimation(.5),
                          ),
                        ),
                        IconButton(
                          onPressed: (){},
                          iconSize: 70,
                          icon: const Icon(Icons.play_circle_fill, color: Colors.white70,),
                        ),
                        Positioned(
                            top: 110,
                            left: 12,
                            child: Text("Episódio $index", style: const TextStyle(fontSize: 15, color: Colors.white, letterSpacing: 1.5),)
                        )
                      ],
                    ),
                  );
                }
            );
          },
        )
    );
  }
}


class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.red, size: 30,),
      elevation: 16,
      dropdownColor: AnimeseColors.background.withOpacity(0.8),
      style: const TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
      underline: Container(
        height: 0,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
              "Temporada $value º",
            style: const TextStyle(
              color: Colors.red,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }
}