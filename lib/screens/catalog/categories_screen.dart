import 'package:flutter/material.dart';



class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: [
            OutlinedButton(
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
            ),

            OutlinedButton(
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
          ],
        )
      ),
      appBar: AppBar(
        title: const Text('filtros', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),

      body: const SingleChildScrollView(
        child: Column(
          children: [

          ],
        )
      ),
    );
  }
}