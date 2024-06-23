// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ffi';

import 'package:doge_coffee/forgetPass.dart';
import 'package:doge_coffee/home.dart';
import 'package:doge_coffee/main.dart';
import 'package:doge_coffee/signUp.dart';
import 'package:doge_coffee/style/colors.dart';
import 'style/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doge_coffee/models/user.dart';
import 'package:doge_coffee/models/userSignIn.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
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
                  padding: EdgeInsets.only(top: 35, left: 30, right: 30),
                  child: TextFormField(
                    controller: _emailController,
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
                    controller: _passwordController,
                    obscureText: true,
                    cursorColor: white,
                    style: TextStyle(
                      color: white,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: lightPurple,
                      labelText: 'Password',
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
                      //   color: Color.fromRGBO(227, 227, 227, 0.75),
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
                  padding: const EdgeInsets.only(top: 10, left: 25, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            visualDensity: VisualDensity(horizontal: -4.0),
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                            value: isChecked,
                            checkColor: lightGrey,
                            side: BorderSide(
                              color: lightGrey,
                            ),
                            fillColor: MaterialStateProperty.resolveWith(
                              (states) {
                                return lightPurple;
                              },
                            ),
                          ),
                          Text(
                            "Remember me",
                            style: TextStyle(
                              color: lightGrey,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPass()),
                          );
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: royalBlue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _signIn(_emailController.text, _passwordController.text,
                            context, isChecked);
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
                          'Login',
                          style: TextStyle(
                            color: navyblue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 50.0, left: 30.0, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: lightGrey,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: royalBlue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
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

Future<void> _signIn(
  String email,
  String password,
  BuildContext context,
  bool isChecked,
) async {
  // print(isChecked);
  // return;
  const url = "http://10.0.2.2:8000/api/login";
  final uri = Uri.parse(url);
  final response = await http.post(
    uri,
    headers: {
      'Content-type': 'application/json',
    },
    body: json.encode(
      {
        'email': email,
        'password': password,
      },
    ),
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final userSignInResult = UserSignInResult.fromJson(responseData);
    await sp.setBool('rememberMe', isChecked);
    await sp.setString("token", userSignInResult.token);
    await sp.setString("user", userSignInResult.user.toString());
    print("Token: ${sp.getString('token')}");
    String userJson = jsonEncode(userSignInResult.user);
    await sp.setString('user', userJson);
    print("User: ${sp.getString('user')}");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Failed",
              style: TextStyle(color: Colors.red),
            ),
            content: Text("Email atau password salah!"),
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
