import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';




class Historic extends StatefulWidget {
  const Historic({super.key,this.pageController, this.page});
  final pageController;
  final page;

  @override
  State<Historic> createState() => _HistoricState();
}

class _HistoricState extends State<Historic> {
  final List<String> imagesCapass = ["https://cdn.myanimelist.net/images/anime/1188/136926.webp", "https://cdn.myanimelist.net/images/anime/1506/138982.jpg", "https://cdn.myanimelist.net/images/anime/1100/138338.jpg", "https://cdn.myanimelist.net/images/anime/1015/138006.jpg", "https://cdn.myanimelist.net/images/anime/1622/139331.jpg"];

  int? touchedIndex;

  String _last = 'none';

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (TapGestureRecognizer instance) {
            instance
              ..onTapDown = (TapDownDetails details) { setState(() { print(11111); }); }
              ..onTapUp = (TapUpDetails details) { setState(() { print(22222); }); }
              ..onTap = () { setState(() { print(333333); }); }
              ..onTapCancel = () { setState(() { print(444444); }); }
            ..onTertiaryTapCancel = () { setState(() { print("000000");});}


            ;
          },
        ),
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
          child: Column(
            children: [
              GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    childAspectRatio: 16/12,
                  ),
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(keepScrollOffset: false),
                  itemCount: imagesCapass.length,
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
                                    image: NetworkImage(imagesCapass[index]),
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
                          const Text('Nome do Anime', style: TextStyle(color: Colors.white38, fontSize: 12),),
                          Text('Episodio $index', style: const TextStyle(color: Colors.white, fontSize: 12),
                          )
                        ],
                      ),
                    );
                  }
              ),
            ],
          )
      ), // Or any other widget you want to detect touches on
    );
  }
}


// onHorizontalDragEnd: (DragEndDetails details){
//   print("esquerda");
//   setState(() {
//     widget.pageController.animateToPage(0,
//         duration: const Duration(milliseconds: 200), curve: Curves.linear);
//   });
// },
// onHorizontalDragStart: (DragStartDetails details){
//   if(details.globalPosition.dx > MediaQuery.of(context).size.width/2){
//     print('direita');
//     setState(() {
//       widget.pageController.animateToPage(1,
//           duration: const Duration(milliseconds: 200), curve: Curves.linear);
//     });
//   }
// },