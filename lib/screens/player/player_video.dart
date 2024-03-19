import 'package:animese/request/json/anime_json.dart';
import 'package:animese/screens/details/dropdown_button.dart';
import 'package:animese/screens/player/cast.dart';
import 'package:animese/screens/player/dropdown_playerButton.dart';
import 'package:animese/screens/player/episode_list.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video_box.dart';



class PlayerVideo extends StatefulWidget {
  const PlayerVideo({super.key, required this.anime});

  final AnimeJson anime;
  @override
  State<PlayerVideo> createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {
  late VideoController vc;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    vc = VideoController(
      // ignore: deprecated_member_use
      source: VideoPlayerController.network('https://edisciplinas.usp.br/pluginfile.php/5196097/mod_resource/content/1/Teste.mp4'),
      autoplay: false,
    )
      ..initialize().then((e) {
        // ignore: avoid_print
        print(e);
        // if (e != null) {
        //   print('[video box init] error: ' + e.message);
        // } else {
        //   print('[video box init] success');
        // }
      })
      ..addListener(() {
        setState(() {
          if(vc.videoCtrl.value.isPlaying){
            floatingButton = Icons.cast;
          }else{
            floatingButton = Icons.swap_vert_outlined;
          }
        });
        if (vc.videoCtrl.value.isBuffering) {

          // ignore: avoid_print
          print('==============================');
          // ignore: avoid_print
          print('isBuffering');
          // ignore: avoid_print
          print('==============================');
        }
      });
  }

  @override
  void dispose() {
    vc.dispose();
    super.dispose();
  }

  bool swap = false;
  IconData floatingButton = Icons.swap_vert_outlined;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A19),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          if (vc.videoCtrl.value.isPlaying) {
            // CastOPP().CastOP();
          } else {
            if (swap){
              setState(() {
                swap = false;
              });
            }else{
              setState(() {
                swap = true;
              });
            }
          }
        },

        child: Icon(floatingButton, color: Colors.white,),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoBox(
                controller: vc,
                children: <Widget>[
                  Align(
                      alignment: const Alignment(-0.9, -0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white,),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Image(
                            image: AssetImage('assets/images/logo.png'),
                            width: 30,
                            opacity: AlwaysStoppedAnimation(.6),
                          ),
                          const SizedBox(width: 10,),
                          const Text(
                            'Episódio 1024',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.20
                          ),

                          QualityButton(vc: vc),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                  ),
                  Align(
                    alignment: const Alignment(-0.5, 0),
                    child: IconButton(
                      iconSize: VideoBox.centerIconSize,
                      disabledColor: Colors.white60,
                      icon: const Icon(Icons.skip_previous),
                      onPressed: () {

                      },
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.5, 0),
                    child: IconButton(
                      iconSize: VideoBox.centerIconSize,
                      disabledColor: Colors.white60,
                      icon: const Icon(Icons.skip_next),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            EpisodeList(
              title: 'Episódios', list: ['', '1º temporada', '2º temporada', '3º temporada'], reverse: swap,
            ),
          ],
        ),
      )
    );
  }
}
