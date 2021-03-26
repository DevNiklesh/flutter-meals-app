import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import './category_screen.dart';
import './favourites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  TabsScreen(this.favouriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _screens = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'screen': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'screen': FavouritesScreen(widget.favouriteMeals),
        'title': 'My Favourites',
      },
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedPageIndex]['title']),
        elevation: 0.0,
      ),
      drawer: MainDrawer(),
      body: _screens[_selectedPageIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          )
        ],
      ),
    );
  }

  Widget buildTopTabBar() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'All Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favourites',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesScreen(),
            FavouritesScreen(widget.favouriteMeals),
          ],
        ),
      ),
    );
  }
}
