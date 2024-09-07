// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:animese/request/json/anime_json.dart';
import 'package:animese/screens/details/related_animes.dart';

import 'package:flutter/material.dart';


class BarScreenDetails extends StatelessWidget {
  const BarScreenDetails({super.key, required this.animes});
  final List<AnimeJson> animes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TabBar(
                automaticIndicatorColorAdjustment: true,
                isScrollable: true,
                indicatorColor: Colors.cyan,
                tabs: [
                  Tab(
                    child: Text('Relacionados', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                    ),)
                  ),
                  Tab(
                      child: Text('Comentários', style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),)
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    RelatedAnimes(animes: animes),
                    const Icon(Icons.directions_transit),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}




