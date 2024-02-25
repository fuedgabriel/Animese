import 'package:animese/request/json/season_json.dart';
import 'package:animese/screens/catalog/catalog_screen.dart';
import 'package:animese/screens/favorite/favorite_screen.dart';
import 'package:animese/screens/home/home_screen.dart';
import 'package:animese/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:animese/request/json/home_json.dart';





class ButtonBarSwipe extends StatefulWidget {
  const ButtonBarSwipe({super.key, required this.home, required this.season, });
  final HomeJson home;
  final SeasonJson season;

  @override
  State<ButtonBarSwipe> createState() => _ButtonBarSwipeState();
}

class _ButtonBarSwipeState extends State<ButtonBarSwipe> {

  int _currentIndex = 1;

  final _pageController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          const FavoriteScreen(),
          HomeScreen(home: widget.home, season: widget.season,),
          const CatalogScreen(),
          const SettingsScreen(),
        ],
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
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
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
            tooltip: 'Inicio',
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today, color: Colors.white,),
            tooltip: 'Catálogo',
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings, color: Colors.grey,),
            tooltip: 'Configurações',
            label: '',
          ),
        ],
      ),
    );
  }
}

