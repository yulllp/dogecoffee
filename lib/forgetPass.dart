// ignore_for_file: prefer_const_constructors

import 'package:doge_coffee/login.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: navyblue,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            icon: Icon(Icons.arrow_back),
            color: lightGrey,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height - 64,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Container(
                      height: 225,
                      child: Image.asset(
                        "assets/bigLogo.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 30, right: 30),
                  child: TextFormField(
                    cursorColor: white,
                    style: TextStyle(
                      color: white,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: lightPurple,
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: lightGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: lightGrey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: lightGrey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: lightGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: TextFormField(
                    obscureText: true,
                    cursorColor: white,
                    style: TextStyle(
                      color: white,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: lightPurple,
                      labelText: 'New Password',
                      labelStyle: TextStyle(
                        color: lightGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline_sharp,
                        color: lightGrey,
                      ),
                      // helperText: "*Password length must be more than 4 characters",
                      // helperStyle: TextStyle(
                      //   color: lightGrey,
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: lightGrey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: lightGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: TextFormField(
                    obscureText: true,
                    cursorColor: white,
                    style: TextStyle(
                      color: white,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: lightPurple,
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        color: lightGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline_sharp,
                        color: lightGrey,
                      ),
                      // helperText: "*Password length must be more than 4 characters",
                      // helperStyle: TextStyle(
                      //   color: lightGrey,
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: lightGrey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: lightGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 48),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Action when login button is pressed
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            cyan,
                          ),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: navyblue,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                              color: navyblue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
