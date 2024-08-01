import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/Screens/cart_screen.dart';
import 'package:store/Screens/profile_screen.dart';

import '../utils/contants.dart';
import 'favourite_screen.dart';
import 'home_screen.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Mainscreen> {
  int currentindux = 0;

  List pages = [
    Homescreen(),
    Favouritrscreen(),
    Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [maincolor, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              'Shop',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
              icon: Icon(CupertinoIcons.cart_fill),
              color: Colors.white,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindux,
        onTap: (value) {
          setState(() {
            currentindux = value;
          });
        },
        selectedItemColor: maincolor,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'Favorite',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(CupertinoIcons.profile_circled),
          ),
        ],
      ),
      body: pages[currentindux],
    );
  }
}
