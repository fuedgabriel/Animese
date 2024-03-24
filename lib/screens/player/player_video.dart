import 'package:animese/request/json/anime_json.dart';
import 'package:animese/screens/details/dropdown_button.dart';
import 'package:animese/screens/player/cast.dart';
import 'package:animese/screens/player/dropdown_playerButton.dart';
import 'package:animese/screens/player/episode_list.dart';
import 'package:cast/cast.dart';
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
  Future<List<CastDevice>>? _future;


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

  void _startSearch() {
    _future = CastDiscoveryService().search();
  }

  Future<void> _connectToYourApp(BuildContext context, CastDevice object) async {
    final session = await CastSessionManager().startSession(object);

    session.stateStream.listen((state) {
      if (state == CastSessionState.connected) {
        const snackBar = SnackBar(content: Text('Connected'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        _sendMessageToYourApp(session);
      }
    });

    session.messageStream.listen((message) {
      print('receive message: $message');
    });

    session.sendMessage(CastSession.kNamespaceReceiver, {
      'type': 'LAUNCH',
      'appId': 'Youtube', // set the appId of your app here
    });
  }

  void _sendMessageToYourApp(CastSession session) {
    print('_sendMessageToYourApp');

    session.sendMessage('urn:x-cast:namespace-of-the-app', {
      'type': 'sample',
    });
  }

  Future<void> _connectAndPlayMedia(BuildContext context, CastDevice object) async {
    final session = await CastSessionManager().startSession(object);

    session.stateStream.listen((state) {
      if (state == CastSessionState.connected) {
        const snackBar = SnackBar(content: Text('Connected'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    var index = 0;

    session.messageStream.listen((message) {
      index += 1;

      print('receive message: $message');

      if (index == 2) {
        Future.delayed(const Duration(seconds: 5)).then((x) {
          _sendMessagePlayVideo(session);
        });
      }
    });

    session.sendMessage(CastSession.kNamespaceReceiver, {
      'type': 'LAUNCH',
      'appId': 'CC1AD845', // set the appId of your app here
    });
  }

  void _sendMessagePlayVideo(CastSession session) {
    print('_sendMessagePlayVideo');

    var message = {
      // Here you can plug an URL to any mp4, webm, mp3 or jpg file with the proper contentType.
      'contentId': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/big_buck_bunny_1080p.mp4',
      'contentType': 'video/mp4',
      'streamType': 'BUFFERED', // or LIVE

      // Title and cover displayed while buffering
      'metadata': {
        'type': 0,
        'metadataType': 0,
        'title': "Big Buck Bunny",
        'images': [
          {'url': 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg'}
        ]
      }
    };

    session.sendMessage(CastSession.kNamespaceMedia, {
      'type': 'LOAD',
      'autoPlay': true,
      'currentTime': 0,
      'media': message,
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
            // Navigator.push(context, MaterialPageRoute(builder: (context) => CastPage()));
            showDialog(
                context: context, builder: (BuildContext context){
              return Dialog(
                backgroundColor: const Color(0xFF0A0A19),
                child: SizedBox(
                  height: 450,
                  child: CastPage(),
                ),
              );
            });
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
