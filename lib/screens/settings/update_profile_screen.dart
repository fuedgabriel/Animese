import 'package:animese/colors.dart';
import 'package:flutter/material.dart';


class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);
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
              // -- IMAGE with ICON
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

              // -- Form Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Nome'), prefixIcon: Icon(Icons.verified_user, color: Colors.white70,)),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Apelido'), prefixIcon: Icon(Icons.account_box, color: Colors.white70,)),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('E-mail'), prefixIcon: Icon(Icons.email, color: Colors.white70,)),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Telefone'), prefixIcon: Icon(Icons.phone, color: Colors.white70,)),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          label: const Text('Senha'),
                          prefixIcon: const Icon(Icons.fingerprint, color: Colors.white70,),
                          suffixIcon: IconButton(icon: const Icon(Icons.remove_red_eye), onPressed: () {

                          }),
                        ),
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
                          child: const Text('Salvar perfil', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // -- Created Date and Delete Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text.rich(
                            TextSpan(
                              text: 'FernBandidex2000@gmail.com',
                              style: TextStyle(fontSize: 12, color: Colors.white),
                              children: [

                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent.withOpacity(0.1),
                                elevation: 0,
                                foregroundColor: Colors.red,
                                shape: const StadiumBorder(),
                                side: BorderSide.none),
                            child: const Text('Deletar Conta', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      )
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