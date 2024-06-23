// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';

import 'package:doge_coffee/home.dart';
import 'package:doge_coffee/login.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            child: Form(
              key: _formKey,
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
                    padding:
                        const EdgeInsets.only(top: 35, left: 30, right: 30),
                    child: TextFormField(
                      controller: _nameController,
                      cursorColor: white,
                      style: TextStyle(
                        color: white,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lightPurple,
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: lightGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Icon(
                          Icons.person_outline,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      cursorColor: white,
                      style: TextStyle(
                        color: white,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lightPurple,
                        labelText: 'Phone',
                        labelStyle: TextStyle(
                          color: lightGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Icon(
                          Icons.phone_outlined,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
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
                            _signUp(_nameController.text, _phoneController.text, _emailController.text, _passwordController.text, context);
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
                              'Sign Up',
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
      ),
    );
  }
}

Future<void> _signUp(
  String name,
  String phone,
  String email,
  String password,
  BuildContext context,
) async {
  const url = "http://10.0.2.2:8000/api/signUp";
  final uri = Uri.parse(url);
  final response = await http.post(
    uri,
    headers: {
      'Content-type': 'application/json',
    },
    body: json.encode(
      {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'address': 'tolol'
      },
    ),
  );

  if (response.statusCode == 200) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Success",
              style: TextStyle(color: const Color.fromARGB(255, 54, 244, 105)),
            ),
            content: Text("Akun berhasil dibuat!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                child: Text("OK"),
              )
            ],
          );
        });
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Failed",
              style: TextStyle(color: Colors.red),
            ),
            content: Text("Maaf ada kendala, silahkan coba beberapa saat lagi!"),
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
