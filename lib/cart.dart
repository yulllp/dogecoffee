// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doge_coffee/main.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:doge_coffee/webView.dart';
import 'package:doge_coffee/models/cart.dart';
import 'package:doge_coffee/models/order.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:nb_utils/nb_utils.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> cartItems = [];
  late Map<String, dynamic> userMap;
  late String? userJson;
  int totalPrice = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItemCart();
    userJson = sp.getString('user');
    if (userJson != null) {
      userMap = jsonDecode(userJson!);
      debugPrint(userMap['name']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        // backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  final menu = cartItem.menu;
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'http://10.0.2.2:8000/storage/images/${menu.image}',
                                  width: 50.0,
                                  height: 50.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/bigLogo.png',
                                    width: 50.0,
                                    height: 50.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          menu.name!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 8.0),
                                        child: Text(cartItem.note ?? '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          "Rp ${NumberFormat.decimalPattern('id').format(menu.price! * cartItem.count!)}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Circular radius should be half of height/width for a perfect circle
                                        child: Container(
                                          color:
                                              white, // Background color of the container
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        navyblue, // Border color
                                                    width: 2.0, // Border width
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  color: navyblue,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  incrementItem(cartItem.id!);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      cartItem.count.toString(),
                                      style: TextStyle(color: white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Circular radius should be half of height/width for a perfect circle
                                        child: Container(
                                          color: Colors
                                              .transparent, // Background color of the container
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors
                                                        .white, // Border color
                                                    width: 2.0, // Border width
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size:
                                                      20, // Adjust size if needed
                                                ),
                                                onPressed: () {
                                                  if (cartItem.count! > 1) {
                                                    decrementItem(cartItem.id!);
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Circular radius should be half of height/width for a perfect circle
                                    child: Container(
                                      color: Colors
                                          .transparent, // Background color of the container
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors
                                                    .white, // Border color
                                                width: 2.0, // Border width
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 20, // Adjust size if needed
                                            ),
                                            onPressed: () {
                                              deleteCart(cartItem);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                      )
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "Rp ${NumberFormat.decimalPattern('id').format(totalPrice)}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // set radius here
                      ),
                    ),
                    onPressed: () {
                      payNow();
                    },
                    child: totalPrice > 0
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Checkout ',
                                style: TextStyle(
                                  color: navyblue, // text color
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: navyblue, // icon color
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void fetchItemCart() async {
    // debugPrint(widget.token);
    debugPrint('fetchCart called');
    const url = "http://10.0.2.2:8000/api/getItemCart";
    // const url = "http://192.168.0.3:8000/api/getItemCart";
    // const url = "http://0.0.0.0:8000/api/menu";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Authorization': "Bearer ${sp.getString('token')}"
      },
    );
    final body = response.body;
    debugPrint(body);

    final json = jsonDecode(body);
    setState(() {
      cartItems =
          (json['cart'] as List).map((item) => Cart.fromJson(item)).toList();
      // debugPrint(cartItems.toString());
      totalPrice = totalAmount(cartItems);
    });
  }

  Future<int> addToOrder() async {
    // debugPrint(widget.token);
    debugPrint('Add to order called');
    // const url = "http://10.0.2.2:8000/api/getItemCart";
    const url = "http://10.0.2.2:8000/api/addToOrder";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Authorization': "Bearer ${sp.getString('token')}"
      },
      body: json.encode({"total_price": totalPrice}),
    );
    print(response.body.toString() + "check");
    final Map<String, dynamic> responseData = json.decode(response.body);
    final order = Orderr.fromJson(responseData);
    return order.order!.id!;
  }

  int totalAmount(List<Cart> cart) {
    int total = 0;
    for (int i = 0; i < cart.length; i++) {
      total += cart[i].count! * cart[i].menu.price!;
    }
    return total;
  }

  String generateRandomString() {
    Random random = Random();
    const String characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String randomString = '';

    for (int i = 0; i < 7; i++) {
      randomString += characters[random.nextInt(characters.length)];
    }
    return randomString;
  }

  Future<void> incrementItem(int id) async {
    final url = "http://10.0.2.2:8000/api/incrementCart/$id";
    print('increment cart called');
    final uri = Uri.parse(url);
    await http.put(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Authorization': "Bearer ${sp.getString('token')}"
      },
    );
    fetchItemCart();
  }

  Future<void> decrementItem(int id) async {
    final url = "http://10.0.2.2:8000/api/decrementCart/$id";
    print('increment cart called');
    final uri = Uri.parse(url);
    await http.put(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Authorization': "Bearer ${sp.getString('token')}"
      },
    );
    fetchItemCart();
  }

  Future<void> deleteCart(Cart item) async {
    final url = "http://10.0.2.2:8000/api/cart/${item.id}";
    print('delete cart called');
    final uri = Uri.parse(url);
    await http.delete(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Authorization': "Bearer ${sp.getString('token')}"
      },
    );
    fetchItemCart();
  }

  Future<void> payNow() async {
    String randomString = generateRandomString();
    int id = await addToOrder();
    String orderId = "$id#$randomString";
    print(orderId);
    Map<String, dynamic> requestBody = {
      "transaction_details": {"order_id": orderId, "gross_amount": totalPrice},
      "customer_details": {
        "first_name": userMap['name'],
        "last_name": "",
        "email": userMap['email'],
        "phone": userMap['phone']
      }
    };

    String url = 'https://app.sandbox.midtrans.com/snap/v1/transactions';

    // try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Basic U0ItTWlkLXNlcnZlci1VZ3hWLXRibUF1eklhN3AzM2ZrbGZOMUU='
      },
      body: jsonEncode(requestBody),
    );
    print('cek');
    try {
      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        // addToOrder();
        debugPrint(json['redirect_url']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MidtransWebview(
              url: json['redirect_url'],
              order: id,
            ),
          ),
        );
      } else {
        print('Request failed with status: ${response.statusCode}');
        // print('Response body: ${response.body}');
      }
    } catch (e) {
      // print('Exception occurred: $e');
    }
  }
  // Future<void> payNow() async {
  //   debugPrint('checl');
  //   Map<String, dynamic> requestBody = {
  //     "transaction_details": {
  //       "order_id": "YOUR-ORDERID-10",
  //       "gross_amount": 10000
  //     },
  //     "customer_details": {
  //       "first_name": "budi",
  //       "last_name": "pratama",
  //       "email": "budi.pra@example.com",
  //       "phone": "08111222333"
  //     }
  //   };

  //   String url =
  //       'https://app.sandbox.midtrans.com/snap/v1/transactions'; // Ganti dengan URL API Anda

  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization':
  //             'Basic U0ItTWlkLXNlcnZlci1VZ3hWLXRibUF1eklhN3AzM2ZrbGZOMUU='
  //       },
  //       body: jsonEncode(requestBody),
  //     );

  //     if (response.statusCode == 201) {
  //       final json = jsonDecode(response.body);
  //       debugPrint(json['redirect_url']);
  //       if (!await launchUrl(
  //         Uri.parse(json['redirect_url']),
  //         mode: LaunchMode.inAppWebView,
  //       )) {
  //         throw 'Could not launch $url';
  //       }
  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Exception occurred: $e');
  //   }
  // }
}
