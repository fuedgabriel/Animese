import 'package:animese/colors.dart';
import 'package:flutter/material.dart';
import 'package:animese/request/routes/authenticate.dart';

class CreateUser extends StatelessWidget {
  CreateUser({Key? key}) : super(key: key);

  TextEditingController nome_ = TextEditingController();
  TextEditingController apelido_ = TextEditingController();
  TextEditingController email_ = TextEditingController();
  TextEditingController telefone_ = TextEditingController();
  TextEditingController senha_ = TextEditingController();
  TextEditingController senhaD_ = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AnimeseColors.background,
        title:
            const Text('Editar Perfil', style: TextStyle(color: Colors.white)),
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                        image: AssetImage('assets/images/logo.png'))),
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Form(
                  child: Column(
                    children: [
                      InputWidget(controllerText: nome_, icon: Icons.verified_user, label: 'Nome'),
                      const SizedBox(height: 10),
                      InputWidget(controllerText: apelido_, icon: Icons.verified_user, label: 'Apelido'),
                      const SizedBox(height: 10),
                      InputWidget(controllerText: email_, icon: Icons.email, label: 'Email'),
                      const SizedBox(height: 10),
                      InputWidget(controllerText: telefone_, icon: Icons.phone, label: 'Telefone'),
                      const SizedBox(height: 10),
                      InputWidget(controllerText: senha_, icon: Icons.lock, label: 'Senha'),
                      const SizedBox(height: 10),
                      InputWidget(controllerText: senhaD_, icon: Icons.lock, label: 'Confirmar Senha'),
                      const SizedBox(height: 30),

                      // -- Form Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if(nome_.text.isEmpty || apelido_.text.isEmpty || email_.text.isEmpty || telefone_.text.isEmpty || senha_.text.isEmpty || senhaD_.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Preencha todos os campos'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              return;
                            }else if(senha_.text != senhaD_.text){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('As senhas não coincidem'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              return;
                            }else if(senha_.text.length < 8){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('A senha deve ter no mínimo 8 caracteres'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              return;
                            }else if(telefone_.text.length < 11){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Número de telefone inválido'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              return;
                            }else if(!email_.text.contains('@') || !email_.text.contains('.') || email_.text.length < 5 || email_.text.length > 50 ){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Email inválido'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              return;
                            }else{
                              AuthenticateRequest.register(nome_.text, apelido_.text, email_.text, senha_.text, telefone_.text).then((value) => {
                                if(value==1){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Conta criada com sucesso'),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 3),
                                    ),
                                  ),
                                  Navigator.pop(context)

                                } else if(value==409){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Email já cadastrado'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  )
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Erro de conexão'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  )
                                }
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text('Criar conta',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 20),
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

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.controllerText, required this.icon, required this.label,
  });
  final TextEditingController controllerText;
  final IconData icon;
  final String label;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerText,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      autofocus: true,
      decoration: InputDecoration(
        label: Text(label),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan.withOpacity(0.7),),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan.withOpacity(0.7),),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
        ),
        labelStyle: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }
}
