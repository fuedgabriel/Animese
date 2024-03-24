import 'package:flutter/material.dart';
import 'package:cast/cast.dart';




class CastPage extends StatefulWidget {
  @override
  _CastPageState createState() => _CastPageState();
}

class _CastPageState extends State<CastPage> {
  Future<List<CastDevice>>? _future;

  @override
  void initState() {
    super.initState();
    _startSearch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CastDevice>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error.toString()}',
            ),
          );
        } else if (!snapshot.hasData) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/progress_bar_luffy.gif'),),
              SizedBox(height: 20,),
              Text(
                  'Procurando dispositivos...',
                  style: TextStyle(fontSize: 20, color: Colors.white)
              ),

            ],
          );
        }
        if (snapshot.data!.isEmpty) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Nenhum dispositivo encontrado',
                  style: TextStyle(fontSize: 20, color: Colors.red)
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Verifique se o dispositivo está ligado e conectado à mesma rede Wi-Fi que o seu dispositivo móvel.',
                    style: TextStyle(fontSize: 15, color: Colors.white60)
                ),
              ),
              Divider(color: Colors.white60,),
              SizedBox(height: 30,),
              ExpansionTile(
                title: Text("Ajuda", style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.info, color: Colors.white,),
                trailing: Icon(Icons.arrow_drop_down, color: Colors.white,),
                childrenPadding: EdgeInsets.all(10),
                children: <Widget>[
                  Text("O Cast nativo só foi testado com dispositovo da google, portanto não garantimos o funcionamento para outros aparelhos, estamos pesquisando maneiras de faze-lo funcionar em outros dispositivos, porém só em versões futuras! ", style: TextStyle(color: Colors.white60),),
                  SizedBox(height: 10,),
                  Text("Baixe na playstore as alternativas para cast e selecione a opção \"externo\" na hora de reproduzir:  Web video cast, Xcast, e etc ", style: TextStyle(color: Colors.white, fontSize: 11),),
                ],
              ),
            ],
          );
        }
        return Column(
          children: snapshot.data!.map((device) {
            return ListTile(
              title: Text(device.name),
              onTap: () {
                // _connectToYourApp(context, device);
                _connectAndPlayMedia(context, device);
              },
            );
          }).toList(),
        );
      },
    );
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
}
