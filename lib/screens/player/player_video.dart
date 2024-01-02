import 'package:animese/colors.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video_box.dart';

class PlayerVideo extends StatefulWidget {
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
      source: VideoPlayerController.network('https://edisciplinas.usp.br/pluginfile.php/5196097/mod_resource/content/1/Teste.mp4'),
      autoplay: true,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: controller,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoBox(
              controller: vc,
              children: <Widget>[
                VideoBar(vc: vc),
                 Align(
                  alignment: const Alignment(-0.9, -0.9),
                  child: Row(
                    children: [
                      const SizedBox(width: 10,),
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
                        'video box',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
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
                    onPressed: () {},
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
          ListTile(
            title: const Text('Inverter ordem',
            style: TextStyle(color: Colors.white, fontSize: 18),),
            trailing: const Icon(Icons.swap_vert, color: Colors.white,),
            selectedColor: Colors.white,
            shape: Border.all(
              color: Colors.red.withOpacity(.5),
              width: 1,
            ),
            onTap: () {
              setState(() {
                swap = !swap;
              });
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 100,
            reverse: swap,
            itemBuilder: (context, index) {
              return ListTile(
                splashColor: Colors.transparent,
                selectedTileColor: Colors.transparent,
                selected: false,
                tileColor: AnimeseColors.background,
                title: Text(
                  'Episódio $index',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                trailing: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,

                ),
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}

class VideoBar extends StatelessWidget {
  final VideoController vc;
  final List<double> speeds;

  const VideoBar({
    Key? key,
    required this.vc,
    this.speeds = const [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0],
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      child: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('test'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white,),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.slow_motion_video),
                        title: const Text('play speed'),
                        onTap: () {
                          showModalBottomSheet<double>(
                            context: context,
                            builder: (context) {
                              return ListView(
                                children: speeds
                                    .map((e) => ListTile(
                                  title: Text(e.toString()),
                                  onTap: () =>
                                      Navigator.of(context).pop(e),
                                ))
                                    .toList(),
                              );
                            },
                          ).then((value) {
                            if (value != null) vc.setPlaybackSpeed(value);
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}