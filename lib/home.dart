import 'package:doge_coffee/history.dart';
import 'package:doge_coffee/profile.dart';
import 'package:flutter/material.dart';

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
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
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
        padding: EdgeInsets.symmetric(vertical: 32,horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Selamat Pagi,",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
