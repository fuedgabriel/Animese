import 'package:flutter/material.dart';



class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtros e filtros', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
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
            SizedBox(height: 20),
            Text('Categorias', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white)),
            SizedBox(height: 20),
            Text('Categoria 1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            SizedBox(height: 20),
            Text('Categoria 2', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            SizedBox(height: 20),
            Text('Categoria 3', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            SizedBox(height: 20),
            Text('Categoria 4', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            SizedBox(height: 20),
            Text('Categoria 5', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            SizedBox(height: 20),
            Text('Categoria 6', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            SizedBox(height: 20),
            Text('Categoria 7', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            SizedBox(height: 20),
            Text('Categoria 8', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            SizedBox(height: 20),
            Text('Categoria 9', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            SizedBox(height: 20),
            Text('Categoria 10', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            SizedBox(height: 20),
          ],
        )
      ),
    );
  }
}