import 'package:flutter/material.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, this.scrollOffset = 0.0});

  final double scrollOffset;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(
          (scrollOffset / 350).clamp(0, 1).toDouble()),
      elevation: 0,

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
      actions: <Widget>[
        GestureDetector(
          child: const Badge(
            label: Text('1', style: TextStyle(color: Colors.white),),
            child: Icon(Icons.notifications, color: Colors.yellow, size: 30,),
          ),
          onTap: () {

          },
        ),
        const SizedBox(width: 2,),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white, size: 30,),
          onPressed: () {

          },
        ),
      ],
    );
  }
}