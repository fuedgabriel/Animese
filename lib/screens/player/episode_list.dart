import 'package:animese/screens/player/dropdown_playerButton.dart';
import 'package:flutter/material.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    super.key,
    required this.title, required this.list, required this.reverse,
  });
  final String title;
  final List<String> list;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: DropdownPlayerButton( list: list,),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.60,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              reverse: reverse,
              controller: ScrollController(keepScrollOffset: true),
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  splashColor: Colors.transparent,
                  selectedTileColor: Colors.transparent,
                  selected: false,
                  tileColor: Colors.transparent,
                  enabled: true,
                  enableFeedback: true,
                  title: Text(
                    'Episódio $index',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onTap: () {


                  },
                );
                },
            )
        )
      ],
    );
  }
}