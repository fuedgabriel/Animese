import 'package:animese/colors.dart';
import 'package:flutter/material.dart';



class ReportAnime extends StatelessWidget {
  const ReportAnime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar anime', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              childAspectRatio: .80,
            ),
            scrollDirection: Axis.vertical,
            controller: ScrollController(keepScrollOffset: false),
            itemCount: 1,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsAndPlay(anime: animes[index],)));
                },
                child: Stack(
                  children: [
                    const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image(
                        height: 300,
                        width: 180,
                        image: NetworkImage('https://www.animeseason.com/wp-content/uploads/2013/07/Anime-Season-Logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 30,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.5),
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        ),
                        child: const Center(
                          child: Text('Anime', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
      )
    );
  }
}
