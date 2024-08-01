import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/view_model/home_view_model.dart';

import '../utils/contants.dart';

class AvailableSize extends StatelessWidget {
  AvailableSize({
    super.key,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          color: isSelected ? maincolor : Colors.white,
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: Text(
            provider.products[index].size.toString(),
            style: TextStyle(color: isSelected ? Colors.white : maincolor),
          ),
        ),
      ),
    );
  }
}
