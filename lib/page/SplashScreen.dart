import 'dart:async';

import 'package:doge_coffee/home.dart';
import 'package:doge_coffee/login.dart';
import 'package:doge_coffee/main.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreenPage extends ConsumerStatefulWidget {
  SplashScreenPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends ConsumerState<SplashScreenPage> {
  bool isSplash = true;
  startSplash() async {
    var duration = new Duration(milliseconds: 1000);

    Timer(
      duration,
      route,
    );
  }

  Future<void> route() async {
    await Future.delayed(Duration(milliseconds: 1000));

    setState(() {
      isSplash = false;
    });

    if (!sp.containsKey('token') | (sp.getBool("rememberMe"))! == false) {
      print("Login");
      await sp.clear();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          pageBuilder: (context, animation, anotherAnimation) {
            return Login();
          },
        ),
      );
    } else {
      print("Home screen");
      print("Token:" + sp.getString('token')!);

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          pageBuilder: (context, animation, anotherAnimation) {
            return Home();
          },
        ),
      );
    }
  }

  Future<void> loadPage() async {
    route();
  }

  @override
  void initState() {
    loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedOpacity(
      opacity: isSplash ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: Container(
        color: primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bigLogo.png',
            ),
            16.height,
            Center(
              child: Text(
                "Doge Coffee",
                style: TextStyle(
                  color: white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            8.height,
          ],
        ),
      ),
    ));
  }
}
