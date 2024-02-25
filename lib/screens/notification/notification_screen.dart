import 'package:flutter/material.dart';



class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Row(
          children: <Widget>[
            Icon(Icons.notifications, color: Colors.yellow, size: 30,),
            SizedBox(width: 10,),
            Text('Notificações', style: TextStyle(color: Colors.white))
          ],
        ),
        elevation: 5,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 100,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.black,
            child: Container(
              height: 150,
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(
                              height: 30,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.cyan,
                                  backgroundColor: Colors.black,
                                  side: const BorderSide(color: Colors.cyan, width: 1),
                                ),
                                child: const Text('Filmes', style: TextStyle(color: Colors.white),),
                                onPressed: () {

                                },
                              ),
                            ),
                            const Badge(
                              label: Text('1', style: TextStyle(color: Colors.white),),
                              child: Icon(Icons.notifications, color: Colors.yellow, size: 30,),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        const Text('Nome do anime', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                        const Text('Episódio 1', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white38),),
                        const Text('Descrição do episódio', style: TextStyle(fontSize: 15, color: Colors.white38),),
                      ],
                    ),
                  ),
                  Container(
                    height: 130,
                    width: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://cdn.myanimelist.net/images/anime/1188/136926.webp'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Icon(
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
                  ),
                  const SizedBox(width: 10,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


