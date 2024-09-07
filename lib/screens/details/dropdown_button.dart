import 'package:animese/colors.dart';
import 'package:flutter/material.dart';


class DropdownButtonExample extends StatefulWidget {
  DropdownButtonExample({super.key, required this.list});
  List<String> list;

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {


  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.list.first;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 30,),
      elevation: 16,
      dropdownColor: AnimeseColors.background.withOpacity(0.8),
      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      underline: Container(
        height: 0,
      ),
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