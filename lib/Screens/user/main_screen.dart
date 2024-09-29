import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/Screens/user/cart_screen.dart';
import 'package:store/Screens/user/chatbot_screen.dart';
import 'package:store/Screens/user/profile_screen.dart';

import '../../utils/contants.dart';
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
    ChatbotScreen(),
    Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              currentindux == 0
                  ? 'Explore'
                  : currentindux == 1
                      ? 'Favourite'
                      : currentindux == 2
                          ? 'chat support'
                          : 'Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: currentindux,
            onTap: (value) {
              setState(() {
                currentindux = value;
              });
            },
            selectedItemColor: maincolor,
            unselectedItemColor: CupertinoColors.inactiveGray,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
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
                label: 'Chat',
                icon: Icon(CupertinoIcons.chat_bubble_2_fill),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(CupertinoIcons.profile_circled),
              ),
            ],
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: pages[currentindux],
      ),
    );
  }
}
