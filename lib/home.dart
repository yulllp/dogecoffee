import 'package:doge_coffee/cart.dart';
import 'package:doge_coffee/detailMenu.dart';
import 'package:doge_coffee/history.dart';
import 'package:doge_coffee/main.dart';
import 'package:doge_coffee/models/cart.dart';
import 'package:doge_coffee/profile.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doge_coffee/models/user.dart';
import 'package:doge_coffee/models/menu.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailMenu(
                      menu: menus,
                    )));
      },
      child: Column(
        children: [
          Row(
            children: [
              // Container(
              //   width: 100,
              //   height: 100,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     image: DecorationImage(
              //       image: Image.network(
              //         'http://10.0.2.2:8000/storage/images/${menus.image}',
              //         errorBuilder: (context, error, stackTrace) {
              //           return Image.asset("assets/bigLogo.png");
              //         },
              //       ).image,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      'http://10.0.2.2:8000/storage/images/${menus.image}',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/bigLogo.png',
                    width: 50.0,
                    height: 50.0,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailMenu(
                                            menu: menus,
                                          )));
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
  int selectedindex = 0;
  int _currentSlide = 0;
  bool isAutoScrolling = false;

  List<Menu> menus = [];
  List<Menu> topThreeMenu = [];
  List<Category> categories = [];
  List<String> imageSliders = [
    'assets/bigLogo.png',
    'assets/bigLogo.png',
    'assets/bigLogo.png'
  ];
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
    fetchTopThreeData();
    fetchData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (isAutoScrolling) return;

    double offset = _scrollController.offset;
    double accumulatedHeight = 0;

    for (int i = 0; i < categories.length; i++) {
      accumulatedHeight += _getCategoryHeight(categories[i]);

      if (offset < accumulatedHeight) {
        if (selectedindex != i) {
          setState(() {
            selectedindex = i;
          });
        }
        break;
      }
    }
  }

  void _scrollToCategory(int categoryIndex) {
    double offset = 0;
    for (int i = 0; i < categoryIndex; i++) {
      offset += _getCategoryHeight(categories[i]);
    }

    isAutoScrolling = true; // Disable scroll events
    _scrollController
        .animateTo(
      offset,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    )
        .then((_) {
      isAutoScrolling = false; // Re-enable scroll events after animation
    });

    setState(() {
      selectedindex = categoryIndex;
    });
  }

  double _getCategoryHeight(Category category) {
    int itemCount =
        menus.where((menu) => menu.category!.id == category.id).length;
    // liat di widget inspector
    double itemHeight = 123;
    double categoryHeaderHeight = 34;

    if (category.name == "Best Seller") {
      return 287;
    } else {
      return itemHeight * itemCount + categoryHeaderHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(115),
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
                            category.name == "Best Seller"
                                ? "3 items"
                                : "${categoryProducts.length} items",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  8.height,
                  category.name == "Best Seller"
                      ? CarouselSlider.builder(
                          itemCount: topThreeMenu.length,
                          options: CarouselOptions(
                            height:
                                MediaQuery.of(context).size.width * (9 / 16),
                            aspectRatio: 16 / 9,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 4),
                            initialPage: _currentSlide,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: true,
                            scrollDirection: Axis.horizontal,
                            pauseAutoPlayOnTouch: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentSlide = index;
                              });
                            },
                          ),
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            return Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  // color: black,
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'http://10.0.2.2:8000/storage/images/${topThreeMenu[itemIndex].image}',
                                      fit: BoxFit.contain,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/bigLogo.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .white, // Set the background color of the container to white
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Add border radius
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                              0.1), // Set shadow color with opacity
                                          spreadRadius: 2, // Spread radius
                                          blurRadius: 5, // Blur radius
                                          offset: Offset(0,
                                              2), // Offset in x and y direction
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(
                                        8.0), // Optional: add some padding inside the container
                                    child: Text(
                                      "${topThreeMenu[itemIndex].name}", // Text content
                                      style: TextStyle(
                                        color: navyblue,
                                        fontWeight: FontWeight
                                            .bold, // Set the text color to black
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .white, // Set the background color of the container to white
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Add border radius
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                              0.1), // Set shadow color with opacity
                                          spreadRadius: 2, // Spread radius
                                          blurRadius: 5, // Blur radius
                                          offset: Offset(0,
                                              2), // Offset in x and y direction
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(
                                        8.0), // Optional: add some padding inside the container
                                    child: Text(
                                      "${topThreeMenu[itemIndex].sold} Sold", // Text content
                                      style: TextStyle(
                                        color: navyblue,
                                        fontWeight: FontWeight
                                            .bold, // Set the text color to black
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : ListView.builder(
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
        categories.insert(0, Category(id: 0, name: "Best Seller"));
      });

      // debugPrint("menus: ${menus.toString()}");
      // debugPrint("categories: ${categories.toString()}");
    } else {
      debugPrint("error ${response.statusCode}");
    }
  }

  void fetchTopThreeData() async {
    debugPrint('fetch top three called');
    const url = "http://10.0.2.2:8000/api/topThreeMenu";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        'Content-type': 'application/json',
      },
    );
    debugPrint("cek" + response.statusCode.toString());
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      // print("json " + json.toString());
      setState(() {
        topThreeMenu =
            (json['menu'] as List).map((item) => Menu.fromJson(item)).toList();
      });

      debugPrint("menus top three: ${topThreeMenu[0].image}");
    } else {
      debugPrint("error ${response.statusCode}");
    }
  }
}
