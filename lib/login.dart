// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:doge_coffee/forgetPass.dart';
import 'package:doge_coffee/home.dart';
import 'package:doge_coffee/signUp.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
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
                  padding: const EdgeInsets.only(top: 35, left: 30, right: 30),
                  child: TextFormField(
                    cursorColor: white,
                    style: TextStyle(
                      color: white,
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
                            checkColor: Color.fromRGBO(227, 227, 227, 1.0),
                            side: BorderSide(
                              color: Color.fromRGBO(227, 227, 227, 1.0),
                            ),
                            fillColor: MaterialStateProperty.resolveWith(
                              (states) {
                                return Color.fromRGBO(39, 39, 39, 1);
                              },
                            ),
                          ),
                          Text(
                            "Remember me",
                            style: TextStyle(
                              color: Color.fromRGBO(227, 227, 227, 0.75),
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
                            MaterialPageRoute(builder: (context) => const ForgetPass()),
                          );
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Colors.blue,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ),
                        );
                        // Action when login button is pressed
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          cyan,
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
                          color: Color.fromRGBO(227, 227, 227, 0.75),
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
                            color: Colors.blue,
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
