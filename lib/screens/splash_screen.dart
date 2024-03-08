import 'dart:convert';

import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/json/details_json.dart';
import 'package:animese/request/json/season_json.dart';
import 'package:animese/request/json/section_json.dart';
import 'package:animese/screens/authenticate/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animese/screens/widgets/botton_bar.dart';
import 'package:animese/request/routes/anime_requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        List<SectionJson> section = json.decode(value.body)['sections'].map<SectionJson>((json) => SectionJson.fromJson(json)).toList();

        AnimeJson initial =  AnimeJson.fromJson(json.decode(value.body)['initial']);
        DetailsJson detailsInitial =  DetailsJson.fromJson(json.decode(value.body)['initial']['details']);

        AnimeJson banner1 =  AnimeJson.fromJson(json.decode(value.body)['banner1']);
        DetailsJson detailsBanner1 =  DetailsJson.fromJson(json.decode(value.body)['banner1']['details']);

        AnimeJson banner2 =  AnimeJson.fromJson(json.decode(value.body)['banner2']);
        DetailsJson detailsBanner2 =  DetailsJson.fromJson(json.decode(value.body)['banner2']['details']);

        AnimeJson banner3 =  AnimeJson.fromJson(json.decode(value.body)['banner3']);
        DetailsJson detailsBanner3 =  DetailsJson.fromJson(json.decode(value.body)['banner3']['details']);

        SeasonJson season = SeasonJson.fromJson(json.decode(value.body)['season']);
        verificarLogin().then((logged) {
          if(logged){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ButtonBarSwipe(section: section, initial: initial, detailsInitial: detailsInitial, banner1: banner1, detailsBanner1: detailsBanner1, banner2: banner2, detailsBanner2: detailsBanner2, banner3: banner3, detailsBanner3: detailsBanner3, season: season, isLogged: logged,)),
            );
          }else{
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ButtonBarSwipe(section: section, initial: initial, detailsInitial: detailsInitial, banner1: banner1, detailsBanner1: detailsBanner1, banner2: banner2, detailsBanner2: detailsBanner2, banner3: banner3, detailsBanner3: detailsBanner3, season: season, isLogged: false,)),
            );          }
        });
      }else{
        //print('Erro ao carregar a home');
      }
    });

  }

  verificarLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('token')){
      return true;
    }
    return false;
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

