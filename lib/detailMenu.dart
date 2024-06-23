import 'package:cached_network_image/cached_network_image.dart';
import 'package:doge_coffee/models/menu.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class DetailMenu extends StatefulWidget {
  final Menu menu;
  const DetailMenu({super.key, required this.menu});

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailPage(
        menu: widget.menu,
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final Menu menu;
  const DetailPage({super.key, required this.menu});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 0;
  int totalPrice = 0;
  String notes = "";

  void updateQuantity(int change) {
    setState(() {
      quantity += change;
      if (quantity < 0) quantity = 0;
      totalPrice = quantity * widget.menu!.price!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          imageUrl:
                              'http://10.0.2.2:8000/storage/images/${widget.menu.image}',
                          width: 400.0,
                          height: 400.0,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/default_image.jpg',
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: lightPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.only(
                          top: 15,
                          left: 5,
                          right: 5,
                          bottom: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.menu.name!,
                                style: TextStyle(
                                  color: white,
                                  fontSize: 30,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "Rp ${NumberFormat.decimalPattern('id').format(widget.menu.price!)}",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 25,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                widget.menu.description!,
                                style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: lightPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.only(
                          top: 5,
                          left: 5,
                          right: 5,
                          bottom: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notes",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Optional",
                                style: TextStyle(color: white, fontSize: 15),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                maxLength: 200,
                                decoration: InputDecoration(
                                  hintText: 'Example: add more, plz',
                                  labelStyle: TextStyle(color: white),
                                  hintStyle: TextStyle(color: grey),
                                  prefixIcon: Icon(Icons.description),
                                  prefixStyle: TextStyle(color: white),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    notes = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: lightPurple,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Item Quantity",
                      style: TextStyle(color: white, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            updateQuantity(-1);
                          },
                          iconSize: 40,
                          color: cyan,
                          icon: Icon(Icons.remove),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "$quantity",
                          style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 15),
                        IconButton(
                          onPressed: () {
                            updateQuantity(1);
                          },
                          iconSize: 40,
                          color: cyan,
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    // Handle add to cart action
                  },
                  child: Text(
                    'Add to cart - Rp ${NumberFormat.decimalPattern('id').format(totalPrice)}',
                    style: TextStyle(fontSize: 20, color: white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
