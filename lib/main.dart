// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:doge_coffee/login.dart';
import 'package:doge_coffee/signUp.dart';
import 'style/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doge Coffee',
      // theme: new ThemeData(scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 1)),
      theme: new ThemeData(
          scaffoldBackgroundColor: navyblue),
      home: const Login(),
    );
  }
}
