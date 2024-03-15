import 'package:animese/screens/constants/text_style.dart';
import 'package:flutter/material.dart';



class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [

          const SizedBox(
            height: 20,
          ),
          Image.network(
            'https://i0.wp.com/24.media.tumblr.com/1c146218ae8aee595ec45784ae98f076/tumblr_mjk9t4LutC1qkai1do1_500.gif',
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Sem conexão com a internet',
            style: kTitleTextStyle,
          ),
          const Text(
            'Verifique a sua conexão e tente novamente.',
            style: kSubtitleTextStyle,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){

            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue[800],
              ),
              child: Center(
                  child: Text(
                    'Tentar novamente'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}