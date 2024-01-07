import 'package:animese/screens/favorite/favorite_screen.dart';
import 'package:animese/screens/home/home_screen.dart';
import 'package:animese/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';






class BottonBarSwipe extends StatefulWidget {
  const BottonBarSwipe({super.key});

  @override
  State<BottonBarSwipe> createState() => _BottonBarSwipeState();
}

class _BottonBarSwipeState extends State<BottonBarSwipe> {

  int _currentIndex = 1;

  final _pageController = PageController(initialPage: 1);
  final List<Widget> _pages = [
    const FavoriteScreen(),
    HomeScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: NavigationBar(
          height: 50,
          animationDuration: const Duration(milliseconds: 3000),
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(_currentIndex,
                  duration: const Duration(milliseconds: 300), curve: Curves.linear);
            });
            },
        indicatorColor: Colors.white54,
        selectedIndex: _currentIndex,
        backgroundColor: Colors.black,
        elevation: 2,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Badge(
              label: Text('2', style: TextStyle(color: Colors.white),),
              child: Icon(Icons.favorite_border, color: Colors.red,),
            ),
            tooltip: 'Favoritos',
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.white,),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings, color: Colors.grey,),
            label: '',
          ),
        ],
      ),
    );
  }
}

