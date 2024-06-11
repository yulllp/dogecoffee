// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:doge_coffee/login.dart';
import 'package:doge_coffee/page/SplashScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'style/colors.dart';
import 'package:flutter/material.dart';

late SharedPreferences sp;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSharedPreferences();
  // await Firebase.initializeApp(
  //   name: "",
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await initFCM();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // print(" FCMToken: $fcmToken");
  runApp(const ProviderScope(child: MyApp()));
}


Future<void> initializeSharedPreferences() async {
  sp = await SharedPreferences.getInstance();
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
      home: SplashScreenPage(),
    );
  }
}
