import 'dart:async';

import 'package:animese/colors.dart';
import 'package:animese/screens/error/connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animese/screens/splash_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


void main() async {
  final hasConnection = await InternetConnectionChecker().hasConnection;
  runApp(
    ConnectionNotifier(
      notifier: ValueNotifier<bool>(true),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final StreamSubscription<InternetConnectionStatus> listener;

  final customInstance = InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 2), // Custom check timeout
    checkInterval: const Duration(seconds: 2), // Custom check interval
  );

  // Register it with any dependency injection framework. For example GetIt.


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listener = InternetConnectionChecker().onStatusChange.listen((status) {
      final notifier = ConnectionNotifier.of(context);
      notifier!.value = status == InternetConnectionStatus.connected ? true : false;
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
    );

    final hasConnection = ConnectionNotifier.of(context)!.value;



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AnimeseColors.background,
      ),
      home: hasConnection ? const SplashScreen() :  const ConnectionScreen(page: true,),
    );
  }
}

