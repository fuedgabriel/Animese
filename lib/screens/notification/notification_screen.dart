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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Nome do anime', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                        const Text('Episódio 1', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: 20,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.cyan,
                              backgroundColor: Colors.black,
                              side: const BorderSide(color: Colors.cyan, width: 1),
                            ),
                            child: const Text('Filmes', style: TextStyle(color: Colors.white,fontSize: 8 ),),
                            onPressed: (){

                            },
                          ),
                        ),
                        const Text('27/02/2024', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white70),),
                      ],
                    ),
                  ),
                  Container(
                    height: 120,
                    width: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage('https://cdn.myanimelist.net/images/anime/1188/136926.webp'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child:  const Icon(
                      Icons.play_circle_outline_outlined,
                      color: Colors.white,
                      size: 30,
                      shadows: [
                        Shadow(
                          blurRadius: 60,
                          color: Colors.white,
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

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


