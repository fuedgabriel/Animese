import 'package:animese/screens/settings/update_profile_screen.dart';
import 'package:animese/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool vFullScreen = false;


  String nome = "Faça login";
  String email = "para accesar mais opções";
  String id = '';
  String nick = '';
  String tel = '';
  String token = '';
  String refresh = '';
  bool fullscreen = false;

  buscarDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nome = prefs.getString('name') ?? "Faça login";
      email = prefs.getString('email') ?? "para accesar mais opções";
      id = prefs.getString('id') ?? '';
      nick = prefs.getString('nickname')?? '';
      tel =  prefs.getString('telefone') ?? '';
      token = prefs.getString('token') ?? '';
      refresh = prefs.getString('refreshtoken')?? '';
      fullscreen = prefs.getBool('fullscreen') ?? false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    buscarDados();
    super.initState();
  }

  Future<void> _launchUrl(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 5,
        leading: const Padding(padding: EdgeInsets.only(left: 10), child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),),
        leadingWidth: 45,
        title: Image(
          image: const AssetImage('assets/images/nome.png'),
          height: 60,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.40,
        ),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child: const Image(image: AssetImage('assets/images/fern.png'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
                      child: const Icon(
                        Icons.alternate_email,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(nome, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Text(email, style: TextStyle(color: Colors.white.withOpacity(0.8))),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateProfileScreen(nome: nome, email: email, id: id, apelido: nick, telefone: tel, token: token, refreshToken: refresh, senha: '********', confirmarSenha: '********',))),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text('Editar Perfil', style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              BuildSwitchListTile(
                title: "Tela cheia",
                icon: Icons.settings,
                vOption: fullscreen,
              ),
              BuildSwitchListTile(title: "Notificar favoritados", icon: Icons.wallet,),
              BuildSwitchListTile(title: "Ajudar mais", icon: Icons.card_giftcard,),
              const Divider(),
              const SizedBox(height: 10),
              BuildListTile(title: "Avalie-nos na Play Store", icon: Icons.star, onPress: () {
                _launchUrl('https://play.google.com/store/apps/details?id=com.dogbytegames.offtheroad&pcampaignid=web_share');

              }, iconColor: Colors.yellow),
              ListTile(
                onTap: () async{
                  _launchUrl('https://discord.com/invite/7vz3rHk');
                },
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Image.network('https://miro.medium.com/max/512/0*E3Nphq-iyw_gsZFH.png'),
                ),
                title: const Text("Comunidade do Discord", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: const Icon(Icons.arrow_forward_ios, size: 18.0, color: Colors.white)),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

class BuildListTile extends StatelessWidget {
  const BuildListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.iconColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
      trailing: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: const Icon(Icons.arrow_forward_ios, size: 18.0, color: Colors.white)),
    );
  }
}

class BuildSwitchListTile extends StatefulWidget {
  BuildSwitchListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.vOption = false,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  bool vOption;
  final Color? textColor;

  @override
  State<BuildSwitchListTile> createState() => _BuildSwitchListTileState();
}

class _BuildSwitchListTileState extends State<BuildSwitchListTile> {


  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: Colors.red,
      activeTrackColor: Colors.grey.shade400,
      inactiveThumbColor: Colors.blueGrey.shade600,
      inactiveTrackColor: Colors.grey.shade400,
      value: widget.vOption,
      secondary: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white.withOpacity(0.1),
        ),
        child: Icon(widget.icon, color: Colors.white),
      ),
      title: Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
      onChanged: (bool value) async {
        setState(() {
          widget.vOption = value;
        });
        // if(value){
        //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        //
        // }else{
        //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        // }
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('fullscreen', value).then((value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        ));

      },
    );
  }
}

/*
ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          Column(
            children: <Widget>[
              SwitchListTile(
                title: const Text('Tela cheia', style: TextStyle(color: Colors.white, ),),
                value: vFullScreen,
                activeColor: Colors.yellow,
                activeTrackColor: Colors.grey.shade400,
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                onChanged: (bool value) {
                  setState(() {
                    vFullScreen = value;
                  });
                  },
                secondary: const Icon(Icons.fullscreen, color: Colors.white,),
              ),
              SwitchListTile(
                title: const Text('Notificar favoritados', style: TextStyle(color: Colors.white, ),),
                value: vFullScreen,
                activeColor: Colors.yellow,
                activeTrackColor: Colors.grey.shade400,
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                onChanged: (bool value) {
                  setState(() {
                    vFullScreen = value;
                  });
                },
                secondary: const Icon(Icons.favorite_border, color: Colors.red,),
              ),
              const SizedBox(height: 10,),
              ListTile(
                  leading: Icon(Icons.star, color: Colors.yellow, size: 56,),
                  title: Text('Avalie-nos na google play', style: TextStyle(color: Colors.white),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow,),
                  onTap: ()  {

                  }
              ),
              ListTile(
                  leading: Image.network('https://miro.medium.com/max/512/0*E3Nphq-iyw_gsZFH.png'),
                  title: Text('Comunidade no Discord', style: TextStyle(color: Colors.white),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow,),
                  onTap: ()  {

                  }
              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.white, size: 56,),
                title: Text('E-MAIL', style: TextStyle(color: Colors.white),),
                subtitle: Text('animeseempresa@gmail.com', style: TextStyle(color: Colors.yellow),),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow,),
                onTap: () {

                },
              ),
              ListTile(
                  leading: Icon(Icons.autorenew, color: Colors.white, size: 56,),
                  title: Text('Versão 2.2.7', style: TextStyle(color: Colors.white),),
                  subtitle: Text('Acessar Google Play', style: TextStyle(color: Colors.white),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow,),
                  onTap: ()  {

                  }
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text("Qualidade de Download",style: TextStyle(color: Colors.white),),
                  Icon(Icons.arrow_forward, size: 22, color: Colors.white,),
                  DropdownButton<String>(
                    value: "HD",
                    icon: Icon(Icons.arrow_downward, color: Colors.yellowAccent,),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.green),
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    onChanged: (var newValue) {

                    },
                    items: <String>['HD', 'SD', 'BG'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              ListTile(
                  leading: Icon(Icons.info, color: Colors.white, size: 56,),
                  title: Text('Sobre', style: TextStyle(color: Colors.white),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow,),
                  onTap: ()  {

                  }
              ),
            ],),
          Padding(padding: EdgeInsets.only(bottom: 0)),


        ],
      ),

 */