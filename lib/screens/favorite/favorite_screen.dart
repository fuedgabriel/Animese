import 'package:flutter/material.dart';




class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: const Center(
        child: Text('Favorite Screen'),
      ),
    );
  }
}
