import 'package:animese/colors.dart';
import 'package:flutter/material.dart';
import 'sliver_header_delegate.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            Header(),
            Trends(title: 'Teste'),
            SeasonAnimes(),
            Recents(),
            Categories(),

          ],
        ),
      ),
    );
  }
}

class SeasonAnimes extends StatelessWidget {
  const SeasonAnimes({super.key,});


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: LayoutBuilder(
          builder: (_, constrains){
            return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: constrains.maxWidth*0.6,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Season Animes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SeasonList(),
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
                  padding: const EdgeInsets.only(top: 0, left: 20),
                  itemBuilder: (_, index){
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: (){

                        },
                        child:  CircleAvatar(
                          radius: 65,
                          backgroundColor: const Color(0xffFDCF09),
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.9),
                            radius: 60,
                            backgroundImage: const NetworkImage('https://cdn.myanimelist.net/images/anime/1693/138042.jpg'),
                          ),
                        ),),
                    );
                }
              );
            }
        ),
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
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: constrains.maxWidth*0.45,
                    width: 200,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Categorias',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        CategoriesList(),
                      ],
                    ),
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
    List<String> CategoryListVar = ['Açã', 'Terror', 'Comédia', 'Aventura', 'Suspense', 'Ecchi'];
    return Expanded(
        child: LayoutBuilder(
          builder: (_, constraints){
            return ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(top: 10, left: 20),
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


class Recents extends StatelessWidget {
  const Recents({super.key,});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: AspectRatio(
          aspectRatio: 16/7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Recents',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ListRecents(),
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
    return  const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: AspectRatio(
          aspectRatio: 16/13,
          child: Column(
            children: [
              HeaderTrends(title: title.toString()),
              ListTrends()
            ],
          ),
        ),
      )
    );
  }
}

class ListTrends extends StatelessWidget {
  const ListTrends({super.key,});

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
                    width: constraints.maxWidth*.375,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image(
                              image: NetworkImage('https://cdn.myanimelist.net/images/anime/1693/138042.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text(
                          'One Piece',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 7.5,),
                        Text(
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

class HeaderTrends extends StatelessWidget {
  final String title;
  const HeaderTrends({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              )
          ),
          Text(
            'See All',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
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


