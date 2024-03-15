// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:animese/screens/bar/favorite_screen.dart';
import 'package:animese/screens/bar/historic_screen.dart';

import 'package:animese/screens/search/search_screen.dart';
import 'package:flutter/material.dart';


class BarScreen extends StatelessWidget {
  const BarScreen({super.key, this.pageController});
  final pageController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 5,
            leading: const Padding(padding: EdgeInsets.only(left: 10),
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                height: 40,
              ),
            ),
            leadingWidth: 45,
            title: Image(
              image: const AssetImage('assets/images/nome.png'),
              height: 60,
              width: MediaQuery.of(context).size.width * 0.40,
            ),
            centerTitle: true,
            actions: <Widget> [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white, size: 30,),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
                },
              ),
            ],
            bottom:  const TabBar(
              tabs: [
                Tab(text: 'Favoritos'),
                Tab(text: 'Baixados'),
                Tab(text: 'Histórico'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const FavoriteScreen(),
              const Icon(Icons.directions_transit),
              Historic(pageController: pageController,)
            ],
          ),
        )
    );
  }
}




