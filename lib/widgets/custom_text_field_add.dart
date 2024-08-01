import 'package:flutter/material.dart';

class Addtextfield extends StatelessWidget {
  Addtextfield({super.key, required this.name, required this.controller});

  String name;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        label: Text(name),
      ),
    );
  }
}
