import 'package:animese/colors.dart';
import 'package:animese/screens/authenticate/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key, required this.nome, required this.apelido, required this.email, required this.telefone,  required this.senha, required this.confirmarSenha, required this.id, required this.token, required this.refreshToken}) : super(key: key);

  final String id;
  final String nome;
  final String apelido;
  final String email;
  final String telefone;
  final String senha;
  final String confirmarSenha;
  final String token;
  final String refreshToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AnimeseColors.background,
        title: const Text('Editar Perfil', style: TextStyle(color: Colors.white)),
        elevation: 5,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage('assets/images/fern.png'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
                      child: const Icon(Icons.camera, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: nome,
                        decoration: const InputDecoration(
                            labelText: 'Nome',
                            labelStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.verified_user, color: Colors.white70,)),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: apelido,
                        decoration: const InputDecoration(
                            labelText: 'Apelido',
                            labelStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.account_box, color: Colors.white70,)
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: email,
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.email, color: Colors.white70,)),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: telefone,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: Colors.white70,),
                          labelText: 'Telefone',
                          labelStyle: TextStyle(color: Colors.white70),

                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: senha,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Colors.white70),
                          prefixIcon: Icon(Icons.fingerprint, color: Colors.white70,),

                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: confirmarSenha,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Colors.white70),
                          prefixIcon: Icon(Icons.fingerprint, color: Colors.white70,),

                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),

                      // -- Form Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text('Alterar perfil', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // -- Created Date and Delete Button
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Sair da conta', style: TextStyle(color: Colors.white)),
                                backgroundColor: AnimeseColors.background,
                                content: const Text('Tem certeza que deseja sair da sua conta?', style: TextStyle(color: Colors.white)),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      SharedPreferences.getInstance().then((prefs) {
                                        prefs.clear();
                                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginScreen()),);
                                      });
                                    },
                                    child: const Text('Sair', style: TextStyle(color: Colors.red)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            elevation: 0,
                            foregroundColor: Colors.red,
                            shape: const StadiumBorder(),
                            side: BorderSide.none),
                        child: const Text('Sair da conta', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}