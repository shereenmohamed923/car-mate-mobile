import 'package:flutter/material.dart';

import './map_screen.dart';
import './market_screen.dart';
import './rents_screen.dart';
import './user_profile_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': MapScreeen(),
      'title': 'map',
    },
    {
      'page': ProductsOverviewScreen(),
      'title': 'market',
    },
    {
      'page': RentsScreen(),
      'title': 'rents',
    },
    {
      'page': UserProfileScreen(),
      'title': 'user profile',
    }
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).hintColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).hintColor,
            icon: Icon(Icons.fmd_good),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).hintColor,
            icon: Icon(Icons.storefront),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).hintColor,
            icon: Icon(Icons.car_rental),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).hintColor,
            icon: Icon(Icons.account_circle_outlined),
            label: '',
          ),
        ],
      ),
    );
  }
}
