import 'package:flutter/material.dart';

class Onbord13 extends StatefulWidget {
  Onbord13({
    super.key,
    required this.title,
    required this.image,
    required this.sub,
    this.roundimage,
  });

  final String image;
  final String title;
  final String sub;
  final Widget? roundimage;

  @override
  State<Onbord13> createState() => _Onbord13State();
}

class _Onbord13State extends State<Onbord13> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            child: Image.asset('assets/images/ellipse.png'),
          ),
          Positioned(
            top: 190,
            left: 30,
            child: Image.asset('assets/images/nika.png'),
          ),
          Positioned(
            top: 100,
            left: 15,
            child: SizedBox(
                height: 350, width: 350, child: Image.asset(widget.image)),
          ),
          Positioned(
            top: 190,
            left: 10,
            child: Image.asset('assets/images/shade.png'),
          ),
          Positioned(
            top: 145,
            left: 50,
            child: Image.asset('assets/images/dots.png'),
          ),
          Positioned(
            top: 430,
            left: 30,
            child: Image.asset('assets/images/dots.png'),
          ),
          Positioned(
            top: 380,
            left: 340,
            child: Image.asset('assets/images/dots.png'),
          ),
          Positioned(
            top: 500,
            left: 30,
            child: Text(
              widget.title,
              style: TextStyle(
                  fontFamily: 'Airbun',
                  fontSize: 45,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 630,
            left: 30,
            child: Text(
              widget.sub,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Airbun',
              ),
            ),
          ),
          // Positioned(
          //   top: 750,
          //   left: 180,
          //   child: SizedBox(
          //     height: 40,
          //     width: 200,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //           backgroundColor: Color(0xFF5B9EE1)),
          //       onPressed: () {},
          //       child: Text(
          //         widget.bname,
          //         style: TextStyle(color: Colors.white, fontSize: 15),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
