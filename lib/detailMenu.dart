import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doge_coffee/main.dart';
import 'package:doge_coffee/models/menu.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final TextEditingController _notescontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo(widget.menu.id!);
  }

  void updateQuantity(int change) {
    setState(() {
      quantity += change;
      if (quantity < 0) quantity = 0;
      totalPrice = quantity * widget.menu!.price!;
    });
  }

  Future<void> addToCart(int product_id, int count, String note) async {
    // debugPrint(widget.token);
    debugPrint('Add to cart called');
    // const url = "http://10.0.2.2:8000/api/getItemCart";
    const url = "http://10.0.2.2:8000/api/addToCart";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Authorization': "Bearer ${sp.getString('token')}"
      },
      body:
          json.encode({"product_id": product_id, 'count': count, 'note': note}),
    );
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Success",
                style: TextStyle(color: Colors.green),
              ),
              content: Text("Item berhasil dimasukkan keranjang!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                )
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Failed",
                style: TextStyle(color: Colors.red),
              ),
              content: Text("Item gagal dimasukkan keranjang!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                )
              ],
            );
          });
    }
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
                                controller: _notescontroller,
                                maxLength: 200,
                                decoration: InputDecoration(
                                  hintText: 'Example: add more, plz',
                                  labelStyle: TextStyle(color: white),
                                  hintStyle: TextStyle(color: grey),
                                  prefixIcon: Icon(
                                    Icons.description,
                                    color: white,
                                  ),
                                  prefixStyle: TextStyle(color: white),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(color: Colors.white),
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
                    addToCart(widget.menu.id!, quantity, _notescontroller.text);
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

  Future<void> getInfo(int id) async {
    debugPrint('fetchUsers called');
    final url = "http://10.0.2.2:8000/api/cartInfo/${id}";
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
        quantity = json['count'];
        _notescontroller.text = json['note'];
        totalPrice = json['count'] * widget.menu.price!;
      });

      // debugPrint("menus: ${menus.toString()}");
      // debugPrint("categories: ${categories.toString()}");
    } else {
      debugPrint("error ${response.statusCode}");
    }
  }
}
