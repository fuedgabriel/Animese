import 'package:animese/screens/authenticate/login_screen.dart';
import 'package:animese/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:animese/screens/notification/notification_screen.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, this.scrollOffset = 0.0, required this.isLogged});

  final double scrollOffset;
  final bool isLogged;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(
          (scrollOffset / 350).clamp(0, 1).toDouble()
      ),
      elevation: 0,
      leading:  Row(
        children: [
           const Padding(padding: EdgeInsets.only(left: 10),
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              height: 40,
            ),
          ),
          const SizedBox(width: 10,),
          isLogged ?
          const SizedBox(width: 0,)
        : GestureDetector(
            child: const Badge(
              label: Text('Entrar', style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.red,
              child: Icon(Icons.account_circle_outlined, color: Colors.yellow, size: 30,),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);

            },
          ),
        ],
      ),
      leadingWidth: 100,
      title: Image(
        image: const AssetImage('assets/images/nome.png'),
        height: 60,
        width: MediaQuery.of(context).size.width * 0.40,
      ),
      centerTitle: true,
      actions: <Widget>[
        GestureDetector(
          child: const Badge(
            label: Text('1', style: TextStyle(color: Colors.white),),
            child: Icon(Icons.notifications, color: Colors.yellow, size: 30,),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationScreen()),
            );
          },
        ),
        const SizedBox(width: 10,),
        IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 30,),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            }
        )
      ],
    );
  }
}


