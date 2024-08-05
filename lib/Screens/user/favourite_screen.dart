import 'package:flutter/material.dart';

class Favouritrscreen extends StatefulWidget {
  const Favouritrscreen({super.key});

  @override
  State<Favouritrscreen> createState() => _FavouritrscreenState();
}

class _FavouritrscreenState extends State<Favouritrscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Text('favourite'),
    );
  }
}
