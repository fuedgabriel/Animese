import 'package:animese/colors.dart';
import 'package:flutter/material.dart';


class DropdownPlayerButton extends StatefulWidget {
  DropdownPlayerButton({super.key, required this.list});
  List<String> list;

  @override
  State<DropdownPlayerButton> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownPlayerButton> {


  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.list.first;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 30,),
      elevation: 16,
      isExpanded: true,
      dropdownColor: AnimeseColors.background.withOpacity(0.8),
      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      underline: const Text(''),
      menuMaxHeight: 300,
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value.isEmpty ? "Selecione a temporada" : value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }
}


class QualityButton extends StatelessWidget {
  final vc;
  final List<String> quality;

  const QualityButton({
    Key? key,
    required this.vc,
    this.quality = const ['FHD', 'HD', 'SD'],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_vert, color: Colors.white,),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: AnimeseColors.background,
          barrierLabel: 'Qualidade',
          clipBehavior: Clip.antiAlias,
          // anchorPoint: const Offset(0.2, 0.2),
          isScrollControlled: true,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.3,
          ),
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.slow_motion_video, color: Colors.white,),
                  title: const Text('Qualidade', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    showModalBottomSheet<double>(
                      context: context,
                      backgroundColor: AnimeseColors.background,
                      barrierLabel: 'Qualidade',
                      clipBehavior: Clip.antiAlias,
                      isScrollControlled: true,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      builder: (context) {
                        return ListView(
                          children: quality
                              .map((e) => ListTile(
                            title: Text(e.toString(), style: const TextStyle(color: Colors.white)),
                            onTap: () =>
                                Navigator.of(context).pop(e),
                          ))
                              .toList(),
                        );
                      },
                    ).then((value) {
                      if (value != null) vc.setPlaybackSpeed(value);
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}