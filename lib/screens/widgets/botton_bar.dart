import 'package:animese/request/json/anime_json.dart';
import 'package:animese/request/json/categories_json.dart';
import 'package:animese/request/json/details_json.dart';
import 'package:animese/request/json/season_json.dart';
import 'package:animese/request/json/section_json.dart';
import 'package:animese/screens/catalog/catalog_screen.dart';
import 'package:animese/screens/bar/bar_screen.dart';
import 'package:animese/screens/home/home_screen.dart';
import 'package:animese/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';





class ButtonBarSwipe extends StatefulWidget {
  const ButtonBarSwipe({super.key, required this.section, required this.initial, required this.detailsInitial, required this.banner1, required this.detailsBanner1, required this.banner2, required this.detailsBanner2, required this.banner3, required this.detailsBanner3, required this.season, required this.isLogged, required this.categorias, });

  final List<SectionJson> section;
  final AnimeJson initial;
  final DetailsJson detailsInitial;

  final AnimeJson banner1;
  final DetailsJson detailsBanner1;

  final AnimeJson banner2;
  final DetailsJson detailsBanner2;

  final AnimeJson banner3;
  final DetailsJson detailsBanner3;

  final SeasonJson season;

  final List<CategoriesJson> categorias;

  final bool isLogged;



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
          BarScreen(pageController: _pageController,),
          HomeScreen(section: widget.section, initial: widget.initial, detailsInitial: widget.detailsInitial, banner1: widget.banner1, detailsBanner1: widget.detailsBanner1, banner2: widget.banner2, detailsBanner2: widget.detailsBanner2, banner3: widget.banner3, detailsBanner3: widget.detailsBanner3, season: widget.season, isLogged: widget.isLogged, categorias: widget.categorias,),
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

