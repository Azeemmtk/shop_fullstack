import 'package:flutter/material.dart';
import 'package:store/Screens/staff/completed_screen.dart';
import 'package:store/Screens/staff/pendign_screen.dart';

import '../../utils/contants.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int currentindux = 0;
  List pages = [
    PendingScreen(),
    CompletedScreen(),
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
        title: const Row(
          children: [
            Text(
              'All Products',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
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
            label: 'Pending',
            icon: Icon(Icons.pending_actions),
          ),
          BottomNavigationBarItem(
            label: 'Completed',
            icon: Icon(Icons.done_all),
          ),
        ],
      ),
      body: pages[currentindux],
    );
  }
}
