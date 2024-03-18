import 'package:animese/colors.dart';
import 'package:animese/screens/details/dropdown_button.dart';
import 'package:flutter/material.dart';



class ReportAnime extends StatelessWidget {
   ReportAnime({super.key});


  var id;
  var tipo;
  var anime = 'Aplicativo';
  String motivo = 'Selecione o motivo';
  String problema = '';
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: AnimeseColors.background,
          title: const Text('Suporte', style: TextStyle(color: Colors.white)),
          elevation: 5,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: ListView(children: <Widget>[
          const SizedBox(height: 20,),
          Row(
            children: [
              const SizedBox(width: 50,),
              const Icon(Icons.report_problem, color: Colors.white, size: 30),
              const SizedBox(width: 10,),
              DropdownButtonExample(list: ["Pedir para adicionar um anime","Relatar um erro em um anime", "Relatar um problema no aplicativo", "Problema com a conta de usuário", "Melhorias no aplicativo", "Outros" ],),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              controller: _textFieldController,
              decoration: InputDecoration(
                hintText: problema,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Align(
            child: SizedBox(
                height: 50,
                width: 250,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: (){

                  },
                  child: const Text('Enviar', style: TextStyle(color: Colors.white),
                  ),
                )
            ),
          )

        ])
    );
  }
}
