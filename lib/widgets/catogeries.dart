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
        child: isSelected
            ? Container(
                decoration: BoxDecoration(
                    border: Border.all(color: maincolor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: secondaycolor),
                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: index == 0
                          ? Image.asset('assets/images/jacket shoe.png')
                          : index == 1
                              ? Image.asset('assets/images/jacket.png')
                              : Image.asset('assets/images/shoe.png'),
                    ),
                    Container(
                      height: 40,
                      width: 110,
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.only(top: 5, right: 5, bottom: 5, left: 5),
                      decoration: BoxDecoration(
                          color: isSelected
                              ? maincolor
                              : CupertinoColors.inactiveGray,
                          borderRadius: BorderRadius.circular(10)),
                      child: index == 0
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            )
                          : index == 1
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 40,
                width: 90,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 5, right: 5, bottom: 5, left: 5),
                decoration: BoxDecoration(
                    color:
                        isSelected ? maincolor : CupertinoColors.inactiveGray,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ));
  }
}
