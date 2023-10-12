import 'package:flutter/material.dart';
import 'package:animese/colors.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
List<String> ImagesCapas = ["https://cdn-eu.anidb.net/images/main/248254.jpg", "https://cdn-eu.anidb.net/images/main/248466.jpg", "https://cdn-eu.anidb.net/images/main/248007.jpg", "https://cdn-eu.anidb.net/images/main/242518.jpg", "https://cdn-eu.anidb.net/images/main/247665.jpg",
  "https://cdn-eu.anidb.net/images/main/247925.jpg","https://cdn-eu.anidb.net/images/main/247715.jpg", "https://cdn-eu.anidb.net/images/main/247378.jpg",
  "https://cdn-eu.anidb.net/images/main/247207.jpg", "https://cdn-eu.anidb.net/images/main/245285.jpg", "https://cdn-eu.anidb.net/images/main/245193.jpg", "https://cdn-eu.anidb.net/images/main/247991.jpg",
  "https://cdn-eu.anidb.net/images/main/248781.jpg", "https://cdn-eu.anidb.net/images/main/242323.jpg", "https://cdn-eu.anidb.net/images/main/10806.jpeg",
  "https://cdn-eu.anidb.net/images/main/247259.jpg", "https://cdn-eu.anidb.net/images/main/244863.jpg", "https://cdn-eu.anidb.net/images/main/247604.jpg", "https://cdn-eu.anidb.net/images/main/248538.jpg"

];
class DetailsAndPlay extends StatefulWidget {
  const DetailsAndPlay({super.key});

  @override
  State<DetailsAndPlay> createState() => _DetailsAndPlayState();
}

class _DetailsAndPlayState extends State<DetailsAndPlay> {
  // Wheater to loop through elements
  bool _loop = true;

  // Scroll controller for carousel
  late InfiniteScrollController _controller;

  // Maintain current index of carousel
  int _selectedIndex = 0;

  // Width of each item
  double? _itemExtent;

  // Get screen width of viewport.
  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
              opacity: 0.6,
            child: Image.network(
                'https://cdn.myanimelist.net/images/anime/1100/138338.jpg',
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
                            color: Colors.white,
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
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
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
                                    const Text(
                                      'Jujutsu Kaisen',
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
                              onTap: (){},
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    'https://cdn.myanimelist.net/images/anime/1100/138338.jpg',
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
                  ),
                  const SizedBox(height: 20,),
                  const ExpandableText(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
                    style: TextStyle(
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
                  SizedBox(
                    height: 250,
                    child: ContentScroll(
                        images: ImagesCapas,
                        color: Colors.white70,
                        title: 'Episodio um',
                        imageHeight: 200,
                        imageWidth: 200,
                        icon: Icons.abc
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: InfiniteCarousel.builder(
                      itemCount: kDemoImages.length,
                      itemExtent: _itemExtent ?? 40,
                      loop: _loop,
                      controller: _controller,
                      onIndexChanged: (index) {
                        if (_selectedIndex != index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        }
                      },
                      itemBuilder: (context, itemIndex, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              _controller.animateToItem(realIndex);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: kElevationToShadow[2],
                                image: DecorationImage(
                                  image: NetworkImage(kDemoImages[itemIndex]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ContentScroll extends StatelessWidget {

  final List<String> images;
  final String title;
  final double imageHeight;
  final double imageWidth;
  Color color;
  IconData icon;

  ContentScroll({
    super.key,
    required this.images,
    required this.color,
    required this.title,
    required this.imageHeight,
    required this.imageWidth,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        SizedBox(height:  MediaQuery.of(context).size.height*0.02, ),
        Row(
          children: <Widget>[
            SizedBox(width:  MediaQuery.of(context).size.width*0.03, ),
            Icon(
              icon,
              size: 30.0,
              color: color,
            ),
            SizedBox(width:  MediaQuery.of(context).size.width*0.03, ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.blueAccent
              ),
            ),
            SizedBox(width:  MediaQuery.of(context).size.width*0.2, ),
            GestureDetector(
                onTap: () {

                },
                child: const Text(
                  "Ver todos  >",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white54,
                  ),
                )
            ),
          ],
        ),
        Container(
          height: imageHeight,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child:  Container(
                  width: imageWidth,
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: ClipRRect(
//                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: images[index],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                        errorWidget: (context, url, error) => Center(child: Icon(Icons.error, color: Colors.black87,),),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}