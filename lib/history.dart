// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doge_coffee/historyDetail.dart';
import 'package:doge_coffee/main.dart';
import 'package:doge_coffee/models/order_detail.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Orders> orders = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    debugPrint('fetchUsers called');
    const url = "http://10.0.2.2:8000/api/getOrderList";
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
        orders = (json['orders'] as List)
            .map((item) => Orders.fromJson(item))
            .toList();
      });
      debugPrint("orders: ${orders.toString()}");
    } else {
      debugPrint("error ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparentColor,
        iconTheme: IconThemeData(
          color: Colors.grey, // Set the desired color here
        ),
        title: Text(
          "History",
          style: TextStyle(
            fontSize: 22,
            color: white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: OrderListView(orders: orders),
          ),
        ],
      ),
    );
  }
}

class OrderListView extends StatelessWidget {
  final List<Orders> orders;
  const OrderListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, i) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: 205, // Set the maximum height
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconTheme(
                            data: IconThemeData(color: Colors.white),
                            child: Icon(Icons.coffee),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transaction',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                orders[i].date ?? '',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: orders[i].status == 'Paid'
                                  ? Colors.green
                                  : Colors.yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              orders[i].status == 'Paid'
                                  ? 'Completed'
                                  : 'Failed',
                              style: TextStyle(
                                  color: orders[i].status == 'Paid'
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'http://10.0.2.2:8000/storage/images/${orders[i].listItem![0].image}',
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
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orders[i].listItem != null &&
                                      orders[i].listItem!.isNotEmpty
                                  ? orders[i].listItem![0].name ?? ''
                                  : '',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              orders[i].listItem != null &&
                                      orders[i].listItem!.isNotEmpty
                                  ? '${orders[i].listItem![0].quantity} products'
                                  : '',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              orders[i].totalLeft != 0
                                  ? '+${orders[i].totalLeft! - 1} other products'
                                  : ' ',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Belanja:',
                              style: TextStyle(color: Colors.white)),
                          Text(
                              'Rp ${NumberFormat.decimalPattern('id').format(orders[i].totalPrice)}',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HistoryDetail(orders: orders, id: i),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6, top: 15),
                          child: Text(
                            'See more',
                            style: TextStyle(
                              color: Colors.cyan,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
