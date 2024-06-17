import 'package:doge_coffee/cart.dart';
import 'package:doge_coffee/history.dart';
import 'package:doge_coffee/main.dart';
import 'package:doge_coffee/models/cart.dart';
import 'package:doge_coffee/profile.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:doge_coffee/models/user.dart';
import 'package:doge_coffee/models/menu.dart';
import 'package:doge_coffee/style/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  late var screen;

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
  void initState() {
    super.initState();
    screen = [
      HomePage(),
      HistoryPage(),
      ProfilePage(),
    ];
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

class Product {
  final String category;
  final String name;
  final String image;
  final String description;
  final double price;

  Product(
      {required this.category,
      required this.name,
      required this.image,
      required this.description,
      required this.price});
}

class ProductCard extends StatelessWidget {
  final Menu menus;

  const ProductCard({Key? key, required this.menus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  image: Image.network(
                    'http://10.0.2.2:8000/storage/images/${menus.image}',
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/bigLogo.png");
                    },
                  ).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      menus.name!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 0.0),
                    child: Text(
                      menus.description!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rp ${NumberFormat.decimalPattern('id').format(menus.price!)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.cyan,
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
          color: Colors.white,
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedindex = 0;

  List<Menu> menus = [];
  List<Category> categories = [];
  late Map<String, dynamic> userMap;
  late String? userJson;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // User user = sp.getString('user');
    userJson = sp.getString('user');
    if (userJson != null) {
      userMap = jsonDecode(userJson!);
      debugPrint(userMap['name']);
    }
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    fetchData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    double currentOffset = 0;
    for (int i = 0; i < categories.length; i++) {
      double categoryHeight = _getCategoryHeight(categories[i]);
      if (offset >= currentOffset && offset < currentOffset + categoryHeight) {
        setState(() {
          selectedindex = i;
        });
        break;
      }
      currentOffset += categoryHeight;
    }
  }
  
  void _scrollToCategory(int categoryIndex) {
    double offset = 0;
    for (int i = 0; i < categoryIndex; i++) {
      offset += _getCategoryHeight(categories[i]);
    }
    _scrollController.animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  double _getCategoryHeight(Category category) {
    int itemCount =
        menus.where((menu) => menu.category!.id == category.id).length;
    // liat di widget inspector
    double itemHeight = 123;
    double categoryHeaderHeight = 34;
    // double appBarHeight = 144;
    return itemHeight * itemCount + categoryHeaderHeight;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                          userMap['name'],
                          style: TextStyle(
                            fontSize: 24,
                            color: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()),
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedindex = index;
                              // selectedCategoryIndex = categories[index].id!;
                              _scrollToCategory(index);
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 3),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color:
                                    selectedindex == index ? cyan : lightPurple,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  categories[index].name!,
                                  style: TextStyle(
                                    color: selectedindex == index
                                        ? navyblue
                                        : white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categories.map((category) {
              List<Menu> categoryProducts = menus
                  .where((menu) => menu.category!.id == category.id)
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category.name!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle the tap event
                          },
                          child: Text(
                            "${categoryProducts.length} items",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categoryProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(menus: categoryProducts[index]);
                    },
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void fetchData() async {
    debugPrint('fetchUsers called');
    const url = "http://10.0.2.2:8000/api/menu";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Authorization': "Bearer ${sp.getString('token')}",
      },
    );
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);

      setState(() {
        menus =
            (json['menu'] as List).map((item) => Menu.fromJson(item)).toList();
        categories = (json['category'] as List)
            .map((item) => Category.fromJson(item))
            .toList();
      });

      debugPrint("menus: ${menus.toString()}");
      debugPrint("categories: ${categories.toString()}");
    } else {
      debugPrint("error ${response.statusCode}");
    }
  }
}
