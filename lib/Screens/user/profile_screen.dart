import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/authentication/login.dart';
import 'package:store/utils/contants.dart';
import 'package:store/view_model/cart_viewmodel.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();
    return Scaffold(
      backgroundColor: secondaycolor,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              cart.cartData.clear();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Signin(),
                  ));
            },
            child: Text('Log out'),
          ),
        ],
      ),
    );
  }
}
