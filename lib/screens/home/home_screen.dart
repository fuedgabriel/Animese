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
            Trends(),
            Recents()
          ],
        ),
      ),
    );
  }
}

class Recents extends StatelessWidget {
  const Recents({
    super.key,
  });

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
  const ListRecents({
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
                padding: const EdgeInsets.only(top: 10, left: 20),
                itemBuilder: (_, index){
                    return SizedBox(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth * 0.25,
                      child: Clip,
                    );
                },
              );

            }
        ) ,
    );
  }
}

class Trends extends StatelessWidget {
  const Trends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: AspectRatio(
          aspectRatio: 16/13,
          child: Column(
            children: [
              HeaderTrends(),
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
                return const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: SizedBox(
                    height: 200,
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image(
                              image: NetworkImage('https://cdn-eu.anidb.net/images/main/292047.jpg'),
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
  const HeaderTrends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
                'Trends',
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


