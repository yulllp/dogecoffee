// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:doge_coffee/home.dart';
import 'package:doge_coffee/login.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            icon: Icon(Icons.arrow_back),
            color: Color.fromRGBO(227, 227, 227, 1.0),
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
                    cursorColor: Color.fromRGBO(227, 227, 227, 1.0),
                    style: TextStyle(
                      color: Color.fromRGBO(227, 227, 227, 1.0),
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(39, 39, 39, 1),
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(227, 227, 227, 0.75),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Color.fromRGBO(227, 227, 227, 0.75),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    cursorColor: Color.fromRGBO(205, 115, 115, 1),
                    style: TextStyle(
                      color: Color.fromRGBO(227, 227, 227, 1.0),
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(39, 39, 39, 1),
                      labelText: 'Phone',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(227, 227, 227, 0.75),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: Color.fromRGBO(227, 227, 227, 0.75),
                      ),
                      // helperText: "*Password length must be more than 4 characters",
                      // helperStyle: TextStyle(
                      //   color: Color.fromRGBO(227, 227, 227, 0.75),
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: TextFormField(
                    obscureText: true,
                    cursorColor: Color.fromRGBO(205, 115, 115, 1),
                    style: TextStyle(
                      color: Color.fromRGBO(227, 227, 227, 1.0),
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(39, 39, 39, 1),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(227, 227, 227, 0.75),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Color.fromRGBO(227, 227, 227, 0.75),
                      ),
                      // helperText: "*Password length must be more than 4 characters",
                      // helperStyle: TextStyle(
                      //   color: Color.fromRGBO(227, 227, 227, 0.75),
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: TextFormField(
                    obscureText: true,
                    cursorColor: Color.fromRGBO(205, 115, 115, 1),
                    style: TextStyle(
                      color: Color.fromRGBO(227, 227, 227, 1.0),
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(39, 39, 39, 1),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(227, 227, 227, 0.75),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline_sharp,
                        color: Color.fromRGBO(227, 227, 227, 0.75),
                      ),
                      // helperText: "*Password length must be more than 4 characters",
                      // helperStyle: TextStyle(
                      //   color: Color.fromRGBO(227, 227, 227, 0.75),
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
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
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                          // Action when login button is pressed
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(39, 39, 39, 1),
                          ),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: Color.fromRGBO(227, 227, 227, 1.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color.fromRGBO(227, 227, 227, 0.75),
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
