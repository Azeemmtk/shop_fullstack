import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/user/paymeny_screen.dart';
import 'package:store/services/auth_service.dart';
import 'package:store/view_model/cart_viewmodel.dart';

import '../../utils/contants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<void>? _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = _loadData();
  }

  Future<void> _loadData() async {
    final authService = Authservice();
    var id = await authService.userId; // Wait for userId to load
    print('-----------------------$id');
    final cartProvider = Provider.of<CartViewModel>(context, listen: false);
    if (authService.userId != null) {
      cartProvider.fetchCartContents(authService.userId!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartprovider = context.watch<CartViewModel>();
    final authprovider = Authservice();

    double totalAmount = 0;
    for (int i = 0; i < cartprovider.cartData.length; i++) {
      totalAmount += (cartprovider.cartData[i].price ?? 0) *
          (cartprovider.cartItems[i].quantity ?? 0);
    }

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
              'Cart',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _loadDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (cartprovider.cartData.isEmpty) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 200),
                  Lottie.asset('assets/lottie/Animation _cart.json'),
                  SizedBox(height: 10),
                  Text(
                    'Cart is empty',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartprovider.cartData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  cartprovider.cartData[index].image ?? 'image',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          cartprovider.cartData[index].name ??
                                              'name',
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'Size: ',
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 0),
                                        Text(
                                          cartprovider.cartData[index].size
                                              .toString(),
                                          style: GoogleFonts.lato(fontSize: 17),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Qty:',
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          cartprovider.cartItems[index].quantity
                                              .toString(),
                                          style: GoogleFonts.lato(fontSize: 17),
                                        ),
                                        Spacer(),
                                        Text(
                                          '₹: ',
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          ((cartprovider
                                                      .cartData[index].price)! *
                                                  (cartprovider.cartItems[index]
                                                          .quantity)!
                                                      .toInt())
                                              .toString(),
                                          style: GoogleFonts.lato(fontSize: 18),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            cartprovider.decreaseQuantity(
                                                cartItemId: cartprovider
                                                    .cartItems[index].sId!,
                                                context: context);
                                          },
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: maincolor,
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        InkWell(
                                          onTap: () {
                                            cartprovider.increaseQuantity(
                                                cartItemId: cartprovider
                                                    .cartItems[index].sId!,
                                                context: context);
                                          },
                                          child: Icon(
                                            Icons.add_circle,
                                            color: maincolor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Status: ',
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          cartprovider
                                                  .cartItems[index].status ??
                                              'status..',
                                          style: GoogleFonts.lato(
                                              fontSize: 18, color: maincolor),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            cartprovider.removeProductFromCart(
                                                userid: authprovider.userId!,
                                                productId: cartprovider
                                                    .cartData[index].sId!,
                                                context: context);
                                            setState(() {
                                              cartprovider.cartData
                                                  .removeAt(index);
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 93,
                  color: secondaycolor.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          '₹${totalAmount.toStringAsFixed(2)}',
                          style: GoogleFonts.lato(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: maincolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentDetails(),
                              ),
                            );
                          },
                          child: Text(
                            'Order Products',
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
