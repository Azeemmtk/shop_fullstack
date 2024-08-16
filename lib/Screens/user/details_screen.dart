import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/user/ar_screen.dart';
import 'package:store/services/auth_service.dart';

import '../../model/product_model.dart';
import '../../utils/contants.dart';
import '../../view_model/cart_viewmodel.dart';
import '../../view_model/home_view_model.dart';
import '../../widgets/availablesize.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({
    super.key,
    required this.index,
    required this.screen,
  });

  int index;
  int screen;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedIndex = 0;

  dynamic onSizeSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();
    final cartprovider = context.watch<CartViewModel>();
    final authservise = Authservice();

    final data = widget.screen == 1
        ? provider.products
        : widget.screen == 2
            ? provider.jackets
            : provider.sneakers;
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
        title: Row(
          children: [
            Text(
              'Details',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red.shade100),
                child: Hero(
                  tag: data[widget.index].image!,
                  child: Image.network(
                    data[widget.index].image ?? 'image',
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 400,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: CupertinoColors.lightBackgroundGray,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data[widget.index].name ?? 'Name',
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      '₹ ${data[widget.index].price ?? 'price'}.0',
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data[widget.index].details ?? 'Details',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.openSans(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Sizes',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Row(
                  children: [
                    AvailableSize(
                      isSelected: selectedIndex == 3,
                      onTap: () => onSizeSelected(3),
                      index: widget.index,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Colour',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue,
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: maincolor),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArScreen(
                                index: widget.index,
                                screen: widget.screen,
                              ),
                            ));
                      },
                      child: Text(
                        'Try on AR',
                        style: GoogleFonts.openSans(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 63.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [maincolor, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹ ${data[widget.index].price ?? 'price'}.0',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: maincolor),
                    onPressed: () {
                      print(authservise.userId);
                      Productmodel newproduct = Productmodel(
                        name: data[widget.index].name,
                        category: data[widget.index].category,
                        colour: data[widget.index].colour,
                        details: data[widget.index].details,
                        price: data[widget.index].price,
                        size: data[widget.index].size,
                        sId: data[widget.index].sId,
                      );

                      cartprovider.addProductToCart(
                          userid: authservise.userId!,
                          product: newproduct,
                          context: context);
                    },
                    label: Text(
                      'Add to cart',
                      style: GoogleFonts.openSans(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
