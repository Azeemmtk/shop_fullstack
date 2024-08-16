import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:store/Screens/user/main_screen.dart';
import 'package:store/utils/contants.dart';

class PaymentSuccesfull extends StatefulWidget {
  const PaymentSuccesfull({super.key});

  @override
  State<PaymentSuccesfull> createState() => _PaymentSuccesfullState();
}

class _PaymentSuccesfullState extends State<PaymentSuccesfull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: maincolor,
        child: Stack(children: [
          Positioned(
            top: 90,
            right: 0,
            left: 0,
            bottom: 0,
            child: Lottie.asset(
              'assets/lottie/Animation - 1723530512083.json',
              width: 100,
              height: 90,
              repeat: true,
              reverse: true,
              animate: true,
              onLoaded: (composition) {},
            ),
          ),
          Positioned(
            top: 50,
            left: 90,
            child: Text(
              "Order Summary",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                fontFamily: "Airbnb",
                color: Colors.white70,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 110,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Mainscreen(),
                    ));
              },
              child: Text(
                "Home Page",
                style: TextStyle(color: maincolor, fontSize: 18),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
