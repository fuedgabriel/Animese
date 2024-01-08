import 'package:animese/colors.dart';
import 'package:animese/screens/home/home_appbar.dart';
import 'package:flutter/material.dart';
import 'sliver_header_delegate.dart';
import 'package:animese/screens/details/details_and_play.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      appBar: HomeAppBar(scrollOffset: offset,),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: const [
            //Header(),
            ContentHeader(),
            Trends(title: 'Recomendados',),
            SeasonAnimes(title: 'Temporada de Inverno 2024',),
            Trends(title: 'Mais assistidos',),
            OneTrend(title: 'One Piece', image: 'https://www.crunchyroll.com/imgsrv/display/thumbnail/1200x675/catalog/crunchyroll/1ecde018e863e2aaee31f00a23378c35.jpe', description: 'One Piece é uma série de mangá escrita e ilustrada por Eiichiro Oda. Os capítulos têm sido serializados na revista Weekly Shōnen Jump desde 22 de julho de 1997, com os capítulos compilados e publicados em volumes tankōbon pela editora Shueisha. A Wikipédia',),
            // //Categories(),
            OneTrend(title: 'Frieren: Beyond Journey\'s End', image: 'https://www.crunchyroll.com/imgsrv/display/thumbnail/1200x675/catalog/crunchyroll/bcc213e8825420a85790049366d409fd.jpe', description: 'Com a grande luta terminada, todos eles seguem caminhos separados para viver uma vida tranquila. Mas como uma elfo, a quase imortal Frieren durará muito mais que o resto de seu antigo bando. Como ela aceitará a mortalidade de seus amigos?'),
            TrendsShort(title: 'Recentes',),
            TrendsShort(title: 'Top 10 admin',),
          ],
        ),
      ),
      );
  }
}

class OneTrend extends StatelessWidget {
  const OneTrend({
    super.key, required this.title, required this.image, required this.description,
  });
  final String title;
  final String image;
  final String description;


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AspectRatio(
          aspectRatio: 16/15,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 2,),
                AspectRatio(
                  aspectRatio: 16/9,
                  child: Image(
                    image: NetworkImage(image),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
                Text(
                  title,
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
                  description.length > 150 ?
                  '${description.substring(0, 150)}...' :
                  description,
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
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.deepOrange,
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

                        },

                        icon: const Icon(Icons.favorite_border_outlined, color: Colors.red, size: 35,)
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

class ContentHeader extends StatelessWidget {
  const ContentHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 500,
            decoration: const BoxDecoration(
              image:  DecorationImage(
                image: NetworkImage('https://cdn-eu.anidb.net/images/main/293673.jpg',),
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
              bottom: 110,
              child: SizedBox(
                width: 250,
                child: Image.network('https://i.imgur.com/zceyR0I.png'),
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
                    onTap: (){},
                    child: const Column(
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(height: 2,),
                        Text('Favoritos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow, color: Colors.black,),
                    label: const Text('Play', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                  ),
                  GestureDetector(
                    onTap: (){},
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
  const SeasonAnimes({super.key, required this.title,});
  final String title;


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: LayoutBuilder(
          builder: (_, constrains){
            return Padding(
                padding: const EdgeInsets.only(top: 0),
                child: SizedBox(
                  height: constrains.maxWidth*0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5,),
                        child: Text(
                          title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SeasonList(),
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: LayoutBuilder(
            builder: (_, constraints){
              return ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  itemBuilder: (_, index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 13),
                      child: GestureDetector(
                        onTap: (){

                        },
                        child:  CircleAvatar(
                          radius: 70,
                          backgroundColor: const Color(0xffFDCF09),
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.9),
                            radius: 65,
                            backgroundImage: const NetworkImage('https://cdn.myanimelist.net/images/anime/1693/138042.jpg'),
                          ),
                        ),),
                    );
                  }
              );
            }
        )
    );
  }
}

class Categories extends StatelessWidget {

  const Categories({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: LayoutBuilder(
            builder: (_, constrains){
              return Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 10, left: 0),
                  child: SizedBox(
                    height: constrains.maxWidth*0.35,
                    width: 200,
                    child: const CategoriesList()
                  )
              );
            }

        )
    );
  }
}

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    List<Color> cor = [Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent];
    // ignore: non_constant_identifier_names
    List<String> CategoryListVar = ['Ação', 'Terror', 'Comédia', 'Aventura', 'Suspense', 'Ecchi'];
    return Expanded(
        child: LayoutBuilder(
          builder: (_, constraints){
            return ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(top: 10, left: 5),
              itemBuilder: (_, index){
                return GestureDetector(
                  onTap: (){

                  },
                  child: Card(
                    color: cor[index],
                    child: Container(
                      alignment: Alignment.center,
                      width: constraints.maxWidth * 0.3,
                      child: Text(CategoryListVar[index],
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
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
  const Trends({super.key, required this.title,});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: AspectRatio(
          aspectRatio: 16/13,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2, left: 10),
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
              const ListTrends()
            ],
          ),
        ),
      )
    );
  }
}

class ListTrends extends StatelessWidget {
  const ListTrends({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: LayoutBuilder(
          builder: (_, constraints){
            return ListView.builder(
              itemCount: 10,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 10, left: 5, bottom: 0),
                itemBuilder: (_, index){
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth*.375,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsAndPlay()));
                          },
                          child: const ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image(
                              image: NetworkImage('https://cdn.myanimelist.net/images/anime/1693/138042.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2,),
                        const Text(
                          'One Piece',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const Text(
                          'Episode 1000',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
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

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: SliverHeaderDelegate(
      minHeight: 60,
      maxHeight: 80,
      child: Container(
        color: AnimeseColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        alignment: Alignment.centerLeft,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 30,
                    width: 30,
                  ),
                ),
                //Icon(Icons.notifications_active, color: Colors.white, size: 30,),
                Icon(Icons.search, color: Colors.white, size: 30,)
              ],
            ),
            SizedBox(height: 5,),
            Text(
              'Watch Anime Online',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            // Image(
            //   image: AssetImage('assets/images/appbar_icon_shoyo_hinata.png'),
            //   height: 30,
            //   width: 30,
            // ),

          ],
        ),
        ),
      ),
    );
  }
}


