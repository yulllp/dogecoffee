import 'dart:convert';

import 'package:doge_coffee/models/userSignIn.dart';
import 'package:doge_coffee/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doge_coffee/main.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late Map<String, dynamic> userMap;
  late String? userJson;

  void initState() {
    userJson = sp.getString('user');
    if (userJson != null) {
      userMap = jsonDecode(userJson!);
      debugPrint(userMap['name']);
    }
    _nameController.text = userMap['name'];
    _phoneController.text = userMap['phone'];
    _emailController.text = userMap['email'];
  }

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
          color: lightGray,
        ),
        title: Text(
          "Edit Profile",
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
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 30, right: 30),
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
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
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
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
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
              ],
            ),
          ),
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
                    _saveProfile(
                      userMap['id'],
                      _nameController.text,
                      _phoneController.text,
                      _emailController.text,
                      context,
                    );
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
                      'Save',
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
    );
  }

  Future<void> _saveProfile(
    int id,
    String name,
    String phone,
    String email,
    BuildContext context,
  ) async {
    String url = "http://10.0.2.2:8000/api/saveProfile/$id";
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Authorization': "Bearer ${sp.getString('token')}",
      },
      body: json.encode(
        {
          'name': name,
          'phone': phone,
          'email': email,
        },
      ),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final userSignInResult = UserSignInResult.fromJson(responseData);
      await sp.setString("token", userSignInResult.token);
      await sp.setString("user", userSignInResult.user.toString());
      String userJson = jsonEncode(userSignInResult.user);
      await sp.setString('user', userJson);
      Navigator.pop(
        context,
        true
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Success",
                style:
                    TextStyle(color: const Color.fromARGB(255, 54, 244, 105)),
              ),
              content: Text("Akun disimpan!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
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
            content:
                Text("Maaf ada kendala, silahkan coba beberapa saat lagi!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        },
      );
    }
  }
}
