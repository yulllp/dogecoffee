// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:doge_coffee/history.dart';
import 'package:doge_coffee/profile.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';

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
  List<String> names = [
    'Best Seller',
    "Doge Coffee's Signature",
    'Coffee',
    'Non-Coffee',
    'Others'
  ];
  int selectedindex = 0;

  final List<Map<String, dynamic>> bestSeller = [
    {
      "image": "assets/cappuccino_caramelo.png",
      "name": "Cappuccino Caramelo",
      "description":
          "Tren baru menikmati cappuccino ala Fore dengan perpaduan rasa karamel",
      "price": 29000
    },
    {
      "image": "assets/matcha_strawberry_cream.png",
      "name": "Matcha Strawberry Cream",
      "description":
          "Tren baru menikmati matcha yang menyegarkan dengan krim dan taburan strawberry",
      "price": 33000
    },
    {
      "image": "assets/vanilla_oat_latte.png",
      "name": "Vanilla Oat Latte",
      "description":
          "Tren baru menikmati oat latte dengan perpaduan drizzle vanilla beans dan susu oat",
      "price": 39000
    }
  ];

  late List<Map<String, dynamic>> dogeCoffeeSignature;
  late List<Map<String, dynamic>> coffee;
  late List<Map<String, dynamic>> noncoffee;
  late List<Map<String, dynamic>> others;

  @override
  void initState() {
    super.initState();
    dogeCoffeeSignature = List.from(bestSeller);
    coffee = List.from(bestSeller);
    noncoffee = List.from(bestSeller);
    others = List.from(bestSeller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 32, left: 16, right: 16),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    height: 30,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: names.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedindex = index;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 3,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedindex == index
                                      ? cyan
                                      : lightPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    names[index],
                                    style: TextStyle(
                                        color: selectedindex == index
                                            ? navyblue
                                            : white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Best Seller
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Best Seller",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle the tap event
                    },
                    child: Text(
                      bestSeller.length.toString() + " items",
                      style: TextStyle(
                        fontSize: 16,
                        color: lightGrey,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 380,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bestSeller.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(bestSeller[index]['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            12.width,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Text(
                                      bestSeller[index]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 0.0),
                                    child: Text(
                                      bestSeller[index]['description'],
                                      style: TextStyle(
                                        color: lightGrey,
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Rp " +
                                              NumberFormat.decimalPattern('id')
                                                  .format(bestSeller[index]
                                                      ['price']),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          color: cyan,
                                          onPressed: () {
                                            // Handle add button pressed
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: white,
                          thickness: 1,
                          height: 0,
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Doge Coffee's Signature
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Doge Coffee's Signature",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle the tap event
                    },
                    child: Text(
                      dogeCoffeeSignature.length.toString() + " items",
                      style: TextStyle(
                        fontSize: 16,
                        color: lightGrey,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 380,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dogeCoffeeSignature.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(
                                      dogeCoffeeSignature[index]['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            12.width,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Text(
                                      dogeCoffeeSignature[index]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 0.0),
                                    child: Text(
                                      dogeCoffeeSignature[index]['description'],
                                      style: TextStyle(
                                        color: lightGrey,
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Rp " +
                                              NumberFormat.decimalPattern('id')
                                                  .format(
                                                      dogeCoffeeSignature[index]
                                                          ['price']),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          color: cyan,
                                          onPressed: () {
                                            // Handle add button pressed
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: white,
                          thickness: 1,
                          height: 0,
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Coffee
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coffee",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle the tap event
                    },
                    child: Text(
                      coffee.length.toString() + " items",
                      style: TextStyle(
                        fontSize: 16,
                        color: lightGrey,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 380,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: coffee.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(coffee[index]['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            12.width,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Text(
                                      coffee[index]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 0.0),
                                    child: Text(
                                      coffee[index]['description'],
                                      style: TextStyle(
                                        color: lightGrey,
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Rp " +
                                              NumberFormat.decimalPattern('id')
                                                  .format(
                                                      coffee[index]['price']),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          color: cyan,
                                          onPressed: () {
                                            // Handle add button pressed
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: white,
                          thickness: 1,
                          height: 0,
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Noncoffee
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Non-Coffee",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle the tap event
                    },
                    child: Text(
                      noncoffee.length.toString() + " items",
                      style: TextStyle(
                        fontSize: 16,
                        color: lightGrey,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 380,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: noncoffee.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(noncoffee[index]['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            12.width,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Text(
                                      noncoffee[index]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 0.0),
                                    child: Text(
                                      noncoffee[index]['description'],
                                      style: TextStyle(
                                        color: lightGrey,
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Rp " +
                                              NumberFormat.decimalPattern('id')
                                                  .format(noncoffee[index]
                                                      ['price']),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          color: cyan,
                                          onPressed: () {
                                            // Handle add button pressed
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: white,
                          thickness: 1,
                          height: 0,
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Others
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Others",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle the tap event
                    },
                    child: Text(
                      others.length.toString() + " items",
                      style: TextStyle(
                        fontSize: 16,
                        color: lightGrey,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 380,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: others.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(
                                      others[index]['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            12.width,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Text(
                                      others[index]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: white),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 0.0),
                                    child: Text(
                                      others[index]['description'],
                                      style: TextStyle(
                                        color: lightGrey,
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Rp " +
                                              NumberFormat.decimalPattern('id')
                                                  .format(
                                                      others[index]
                                                          ['price']),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: white),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          color: cyan,
                                          onPressed: () {
                                            // Handle add button pressed
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: white,
                          thickness: 1,
                          height: 0,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
