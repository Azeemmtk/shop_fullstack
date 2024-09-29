import 'package:flutter/material.dart';
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
    await authService.loadUserId();
    var id = await authService.userId;
    final cartProvider = Provider.of<CartViewModel>(context, listen: false);
    if (id != null) {
      await cartProvider.fetchCartContents(id, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartViewModel>();
    final authprovider = Authservice();

    double totalAmount = 0;
    final cartData = cartProvider.cartData;
    final cartItems = cartProvider.cartItems;

    if (cartData != null && cartItems != null) {
      for (int i = 0; i < cartData.length; i++) {
        totalAmount += (cartData[i].price ?? 0) * (cartItems[i].quantity ?? 0);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Cart',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
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

          if (cartProvider.cartData.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 200),
                  Lottie.asset('assets/lottie/Animation _cart.json'),
                  SizedBox(height: 10),
                  Text('Cart is empty'),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cartData.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.cartData[index];
                      final cartItem = cartProvider.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: secindLighter,
                          shadowColor: maincolor,
                          elevation: 7,
                          child: Container(
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                    item.image ?? 'image',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            item.name ?? 'name',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            'Size: ${item.size ?? 'size'}',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Qty:',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            cartItem.quantity?.toString() ??
                                                '0',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(width: 20),
                                          const Text(
                                            '₹: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ((item.price ?? 0) *
                                                    (cartItem.quantity ?? 0))
                                                .toStringAsFixed(2),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              cartProvider.decreaseQuantity(
                                                cartItemId: cartItem.sId!,
                                                context: context,
                                              );
                                            },
                                            child: Icon(Icons.remove_circle,
                                                color: maincolor),
                                          ),
                                          const SizedBox(width: 25),
                                          InkWell(
                                            onTap: () {
                                              cartProvider.increaseQuantity(
                                                cartItemId: cartItem.sId!,
                                                context: context,
                                              );
                                            },
                                            child: Icon(Icons.add_circle,
                                                color: maincolor),
                                          ),
                                          const SizedBox(width: 5),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Status: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            cartItem.status ?? 'status..',
                                            style: TextStyle(
                                                fontSize: 18, color: maincolor),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              cartProvider
                                                  .removeProductFromCart(
                                                userid: authprovider.userId!,
                                                productId: item.sId!,
                                                context: context,
                                              );
                                            },
                                            child: const Icon(Icons.delete,
                                                color: Colors.red),
                                          ),
                                          const SizedBox(width: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 93,
                  decoration: BoxDecoration(
                      color: secondaycolor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      border: Border.all()),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          SizedBox(width: 30),
                          Text(
                            '₹${totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: maincolor),
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
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
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
