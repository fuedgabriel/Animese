import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animese/screens/widgets/botton_bar.dart';
import 'package:animese/request/routes/anime_requests.dart';
import 'package:animese/request/json/home_json.dart';
import 'package:animese/request/json/season_json.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    HomeRequest.getHome().then((value) {
      if(value.statusCode == 200){
        HomeRequest.getSeason('clt0be0hj000022rpokscu3td').then((value2) {
          if(value.statusCode == 200){
            HomeJson home =  HomeJson.fromJson(json.decode(value.body));
            SeasonJson season =  SeasonJson.fromJson(json.decode(value2.body));

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ButtonBarSwipe(home: home,season: season,)),
            );
          }
        });

      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50.0,horizontal: 20.0),
        width: double.infinity,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Colors.black87,
        //       Colors.red,
        //       Colors.black87,
        //     ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomLeft,
        //
        //   ),
        // ),
        //padding: const EdgeInsets.symmetric(vertical: 60.0,horizontal: 20.0),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: AssetImage('assets/images/logo.png'),
              width: 200,
            ),
            SizedBox(height: 100,),
            Stack(
              alignment: Alignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/progress_bar_luffy.gif'),
                  width: double.maxFinite,
                ),
                LinearProgressIndicator(
                  backgroundColor: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                  minHeight: 25,
                ),
                Positioned(
                    top: 220,
                    child: Image(
                      image: AssetImage('assets/images/nome.png'),
                      width: 350,
                    ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}

