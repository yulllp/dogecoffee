// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doge_coffee/history.dart';
import 'package:doge_coffee/models/order_detail.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HistoryDetail extends StatelessWidget {
  final List<Orders> orders;
  final id;
  const HistoryDetail({Key? key, required this.orders, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparentColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: Icon(Icons.arrow_back),
          color: lightGrey,
        ),
        title: Text(
          "Your Transaction",
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
              child: DetailOrderView(
            orders: orders,
            id: id,
          )),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: transparentColor, // Customize with your preferred color
        child: Column(
          children: [
            Divider(color: Colors.grey,),
            SizedBox(
              height: 40,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Rp ${orders[id].totalPrice}', // Function to calculate total price
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailOrderView extends StatelessWidget {
  final List<Orders> orders;
  final id;
  const DetailOrderView({super.key, required this.orders, required this.id});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders[id].listItem!.length,
      itemBuilder: (context, i) {
        int sub = (int.parse('${orders[id].listItem![i].quantity}')) *
            (int.parse('${orders[id].listItem![i].price}'));

        if (i == 0) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Transaction',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
                  ),
                  Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Id',
                        style: TextStyle(
                          fontSize: 16,
                          color: grey,
                        ),
                      ),
                      Text(
                        '${orders[id].orderId}',
                        style: TextStyle(
                          fontSize: 16,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction Date',
                        style: TextStyle(
                          fontSize: 16,
                          color: grey,
                        ),
                      ),
                      Text(
                        '${orders[id].date}',
                        style: TextStyle(
                          fontSize: 16,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 16,
                          color: grey,
                        ),
                      ),
                      Text(
                        orders[id].status == 'Paid'
                            ? 'Completed | Paid'
                            : 'Failed | Unpaid',
                        style: TextStyle(
                          fontSize: 16,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Detail Item',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: white,
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              'https://via.placeholder.com/70',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${orders[id].listItem![i].name}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: white,
                                    ),
                                  ),
                                  Text(
                                    '${orders[id].listItem![i].quantity} x Rp ${orders[id].listItem![i].price}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Rp $sub',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        'https://via.placeholder.com/70',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${orders[id].listItem![i].name}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: white,
                              ),
                            ),
                            Text(
                              '${orders[id].listItem![i].quantity} x Rp ${orders[id].listItem![i].price}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Rp $sub',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
