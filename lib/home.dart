// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:doge_coffee/history.dart';
import 'package:doge_coffee/profile.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  var screen = [
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  var bottomNavigationIcon = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.white),
    BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'History',
        backgroundColor: Colors.white),
    BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
        backgroundColor: Colors.white),
  ];

  List<BottomNavigationBarItem> getBottomNavigationItems() {
    return bottomNavigationIcon;
  }

  List<Widget> getScreen() {
    return screen;
  }

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationItems = getBottomNavigationItems();
    final currentScreen = getScreen();

    return Scaffold(
      body: currentScreen[_index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: white,
        backgroundColor: navyblue,
        unselectedItemColor: grey,
        showUnselectedLabels: true,
        items: bottomNavigationItems,
        currentIndex: _index,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat datang,",
              style: TextStyle(
                fontSize: 16,
                color: white,
              ),
            ),
            Text(
              "KING RAFFF",
              style: TextStyle(
                fontSize: 24,
                color: white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
