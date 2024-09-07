import 'package:animese/main.dart';
import 'package:flutter/material.dart';

class ConnectionNotifier extends InheritedNotifier<ValueNotifier<bool>>{
  const ConnectionNotifier({
    super.key,
    required  super.notifier,
    required super.child,
  });
  static ValueNotifier<bool>? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ConnectionNotifier>()!.notifier;
  }
}


class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key, required this.page, });
  final bool page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.wifi_off,
              size: 100,
              color: Colors.grey,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 10,),
            const Text(
              'Tentando se reconectar ao servidor',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: const StadiumBorder(side: BorderSide(color: Colors.black,)),
              ),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Tentando se reconectar ao servidor', style: TextStyle(color: Colors.white),),
                  backgroundColor: Colors.white10,
                ));
                // if(page){
                //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
                // }
              },
              child: const Text('Tentar novamente', style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }
}
