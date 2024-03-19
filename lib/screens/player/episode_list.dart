import 'package:animese/colors.dart';
import 'package:animese/screens/player/dropdown_playerButton.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    super.key,
    required this.title, required this.list, required this.reverse,
  });
  final String title;
  final List<String> list;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: DropdownPlayerButton( list: list,),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.60,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              reverse: reverse,
              itemCount: 30,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color(0xFF0A0A19),
                  elevation: 5,
                  child: ListTile(
                      splashColor: Colors.transparent,
                      selectedTileColor: Colors.transparent,
                      selected: false,
                      tileColor: Colors.transparent,
                      enabled: true,
                      enableFeedback: true,
                      title: SizedBox(
                        height: 30,
                        child: OutlinedButton(
                          onPressed: (){
                            showDialog(
                                context: context, builder: (BuildContext context){
                                  return Dialog(
                                    backgroundColor: const Color(0xFF0A0A19),
                                    child: SizedBox(
                                      height: 500,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const SizedBox(height: 10,),
                                          const Image(image: AssetImage('assets/images/logo_name.png',) , width: 120, opacity: AlwaysStoppedAnimation(.6)),
                                          const Text("Selecione a qualidade",style:TextStyle(fontSize: 16, color: Colors.white),),
                                          const Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ButtonQuality(title: "4K",),
                                              ButtonQuality(title: "FHD",),
                                              ButtonQuality(title: "HD",),
                                              ButtonQuality(title: "SD",),
                                            ],
                                          ),
                                          const Divider(color: Colors.white,),
                                          const ExpansionTile(
                                            title: Text("Informações", style: TextStyle(color: Colors.white),),
                                            leading: Icon(Icons.info, color: Colors.white,),
                                            trailing: Icon(Icons.arrow_drop_down, color: Colors.white,),
                                            childrenPadding: const EdgeInsets.all(10),
                                            children: <Widget>[
                                              const Text("Click em cima da qualidade desejada para reproduzir o episódio externamente!! ", style: TextStyle(color: Colors.white),),
                                              SizedBox(height: 10,),
                                              const Text("Player de video que recomendamos: MXplayer, VLC, videCast. ", style: TextStyle(color: Colors.white, fontSize: 11),),
                                            ],
                                          ),
                                          OutlinedButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Fechar", style: TextStyle(color: Colors.white),)
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(color: Colors.white, width: 1),
                          ),
                          child: const Text(
                            'Externo',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      leading: Text(
                        'Episódio $index       ',
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      trailing: IconButton(
                          onPressed: (){

                          },
                          icon: const Icon(Icons.play_arrow, color: Colors.white, size: 30,)
                      )
                  ),
                );
                },
            )
        )
      ],
    );
  }
}

class ButtonQuality extends StatelessWidget {
  const ButtonQuality({
    super.key, required this.title,
  });
  final String title;

  Future<void> _launchUrl(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        _launchUrl('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4');

      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: Colors.white, width: 1),
      ),
      child: Text(title, style: const TextStyle(color: Colors.white),),
    );
  }
}