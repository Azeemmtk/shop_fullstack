import 'package:flutter/material.dart';

import 'onbord.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    gotoonbord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4d5468),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          // Adjusted swipe detection threshold
          if (details.primaryDelta! < -20) {
            // Swiped up
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Onbord()),
            );
          }
        },
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height / 3, // Adjusted position
              left: 0,
              child: SizedBox(
                height: 400,
                width: 400,
                child: Image.asset('assets/images/logo (2).png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gotoonbord() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Onbord(),
        ));
  }
}
