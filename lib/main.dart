// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:doge_coffee/login.dart';
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
      theme: new ThemeData(scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 1.0)),
      home: const Login(),
    );
  }
}