import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50.0,horizontal: 20.0),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black87,
              Colors.red,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        //padding: const EdgeInsets.symmetric(vertical: 60.0,horizontal: 20.0),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage('assets/images/logo_name.png'),
              width: double.maxFinite,
            ),
            Stack(
              alignment: Alignment.center,
              children: [

                Image(
                  image: AssetImage('assets/images/progress_bar_luffy.gif'),
                  width: double.maxFinite,
                ),
                LinearProgressIndicator(
                  backgroundColor: Colors.red,
                  valueColor: AlwaysStoppedAnimation(Colors.orange),
                  minHeight: 25,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

