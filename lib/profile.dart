// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:doge_coffee/editProfile.dart';
import 'package:doge_coffee/history.dart';
import 'package:doge_coffee/login.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doge_coffee/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, dynamic> userMap;
  late String? userJson;

  void initState() {
    userJson = sp.getString('user');
    if (userJson != null) {
      userMap = jsonDecode(userJson!);
      debugPrint(userMap['name']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparentColor,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            color: white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 0, right: 16, bottom: 10, top: 5),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0), // Adjust padding as needed
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.account_circle,
                    size: 75, // Adjust the size of the icon as needed
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userMap['name']}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                      ),
                      Text(
                        '${userMap['phone']}',
                        style: TextStyle(
                          fontSize: 17,
                          color: white,
                        ),
                      ),
                      Text(
                        '${userMap['email']}',
                        style: TextStyle(
                          fontSize: 17,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.edit, color: Colors.cyan),
                  title: Text(
                    'Edit profile',
                    style: TextStyle(color: white, fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: lightGrey,
                  ),
                  onTap: () {
                    _navigate(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.receipt_long, color: Colors.cyan),
                  title: Text(
                    'Transaction list',
                    style: TextStyle(color: white, fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: lightGrey,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.cyan),
                  title: Text(
                    'Log Out',
                    style: TextStyle(color: white, fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: lightGrey,
                  ),
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigate(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditProfile()), // Your page to navigate to
    );

    if (result == true) {
      setState(() {
        initState();
        // Reload the page or refresh the state
      });
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await sp.clear();
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
