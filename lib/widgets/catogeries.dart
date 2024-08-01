import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/utils/contants.dart';

class Catogeries extends StatelessWidget {
  final int index;
  final String name;
  final bool isSelected;
  final Function(int) onTap;

  Catogeries({
    super.key,
    required this.name,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 40,
        width: 110,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 5, right: 5, bottom: 5, left: 5),
        decoration: BoxDecoration(
            color: isSelected ? maincolor : CupertinoColors.inactiveGray,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
