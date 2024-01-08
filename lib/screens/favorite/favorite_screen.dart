import 'package:flutter/material.dart';




class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 5,
            leading: const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 60,
              width: 200,
            ),
            title: Image(
              image: const AssetImage('assets/images/nome.png'),
              height: 60,
              width: MediaQuery.of(context).size.width * 0.45,
            ),
            centerTitle: true,
            actions: <Widget> [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white, size: 30,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteScreen()));
                },
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Favoritos'),
                Tab(text: 'Baixados'),
                Tab(text: 'Histórico'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const FavoriteList(),
              const Icon(Icons.directions_transit),
              Historic()
            ],
          ),
        )
    );
  }
}

class Historic extends StatelessWidget {
  Historic({super.key,});

  final List<String> ImagesCapass = ["https://cdn.myanimelist.net/images/anime/1188/136926.webp", "https://cdn.myanimelist.net/images/anime/1506/138982.jpg", "https://cdn.myanimelist.net/images/anime/1100/138338.jpg", "https://cdn.myanimelist.net/images/anime/1015/138006.jpg", "https://cdn.myanimelist.net/images/anime/1622/139331.jpg"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            childAspectRatio: 16/12,
          ),
          scrollDirection: Axis.vertical,
          controller: ScrollController(keepScrollOffset: false),
          itemCount: ImagesCapass.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: (){

              },
              child: ListView(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 16/8,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(0)),
                          child: Image(
                            image: NetworkImage(ImagesCapass[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 50,
                        shadows: [
                          Shadow(
                            blurRadius: 60,
                            color: Colors.black,
                          ),
                          Shadow(
                            blurRadius: 60,
                            color: Colors.black,
                          ),
                          Shadow(
                            blurRadius: 60,
                            color: Colors.black,
                          ),
                          Shadow(
                            blurRadius: 60,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 4,
                        right: 5,
                        child: Container(
                          height: 20,
                          width: 85,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text('${index+2}m restantes',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: (index+2)/10,
                    backgroundColor: Colors.black,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                  Text('Nome do Anime', style: const TextStyle(color: Colors.white38, fontSize: 12),),
                  Text('Episodio $index', style: const TextStyle(color: Colors.white, fontSize: 12),
                  )],
              ),
            );
          }
      ),
    );
  }
}

class FavoriteList extends StatefulWidget {
  const FavoriteList({
    super.key,
  });

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  final List<String> capas = <String>['https://cdn-eu.anidb.net/images/main/283419.jpg', 'https://cdn-eu.anidb.net/images/main/289073.jpg', 'https://cdn-eu.anidb.net/images/main/298055.jpg', 'https://cdn-eu.anidb.net/images/main/297001.jpg', 'https://cdn-eu.anidb.net/images/main/295891.jpg', 'https://cdn-eu.anidb.net/images/main/296428.jpg', 'https://cdn-eu.anidb.net/images/main/296336.jpg', 'https://cdn-eu.anidb.net/images/main/293976.jpg', 'https://cdn-eu.anidb.net/images/main/294806.jpg', 'https://cdn-eu.anidb.net/images/main/297625.jpg', 'https://cdn-eu.anidb.net/images/main/294397.jpg', 'https://cdn-eu.anidb.net/images/main/296722.jpg'];
  final List<String> status = <String>['Assistindo', 'Finalizado', 'Acompanhando', 'Começar a Assistir', 'Assistindo', 'Finalizado', 'Acompanhando', 'Começar a Assistir', 'Assistindo', 'Finalizado', 'Acompanhando', 'Começar a Assistir'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            childAspectRatio: .70,
          ),
          scrollDirection: Axis.vertical,
          controller: ScrollController(keepScrollOffset: false),
          itemCount: capas.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: (){

              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image(
                      height: 300,
                      width: 300,
                      image: NetworkImage(capas[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned(
                    top: 10,
                    right: 5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Badge(
                        label: Text('2', style: TextStyle(color: Colors.white),),
                        child: Icon(Icons.notifications_active, color: Colors.yellow,),
                      ),
                    )
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 30,
                      width: 300,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        color: Colors.black54,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(status[index],
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            const Icon(Icons.favorite, color: Colors.white, size: 20,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
