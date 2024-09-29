import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/staff/order_detaials.dart';
import 'package:store/utils/contants.dart';
import 'package:store/view_model/cart_viewmodel.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  late Future<void> loadDataFuture;

  @override
  void initState() {
    super.initState();
    loadDataFuture = Future.microtask(() async {
      final cartProvider = Provider.of<CartViewModel>(context, listen: false);
      await cartProvider.fetchAllCarts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartViewModel>();

    return Scaffold(
      body: FutureBuilder<void>(
        future: loadDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (cartProvider.deliveredData.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Lottie.asset('assets/lottie/Animation_cart.json'),
                  ),
                  const SizedBox(height: 10),
                  const Text('Orders not delivered /\n No orders'),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: cartProvider.deliveredData.length,
              itemBuilder: (context, index) {
                final product = cartProvider.deliveredData[index].productid;
                final quantity =
                    cartProvider.deliveredData[index].quantity ?? 0;
                final price = product?.price ?? 0;
                final imageUrl = product?.image ??
                    'assets/images/placeholder.png'; // Local placeholder

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetails(
                          index: index,
                          userid:
                              cartProvider.deliveredData[index].userid ?? '',
                          screen: 2,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: secindLighter,
                      elevation: 10,
                      shadowColor: maincolor,
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
                                imageUrl,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                      'assets/images/placeholder.png'); // Local placeholder
                                },
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        //product?.name ?? 'name'
                                        cartProvider.deliveredData[index]
                                                .productid?.name ??
                                            'names',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        'Size: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 0),
                                      Text(
                                        product?.size ?? 'size',
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                      const SizedBox(width: 60),
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
                                        quantity.toString(),
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        '₹: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        (price * quantity).toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(width: 60),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
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
                                        cartProvider
                                                .deliveredData[index].status ??
                                            'status..',
                                        style: TextStyle(
                                            fontSize: 18, color: maincolor),
                                      ),
                                      const Spacer(),
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
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
