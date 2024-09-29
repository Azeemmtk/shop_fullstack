import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/staff/order_detaials.dart';
import 'package:store/utils/contants.dart';
import 'package:store/view_model/auth_viewmodel.dart';
import 'package:store/view_model/cart_viewmodel.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  late Future<void> _loadDataFuture;

  @override
  void initState() {
    super.initState();
    // Use Future.microtask to ensure _loadData is called after build phase
    _loadDataFuture = Future.microtask(() async {
      final cartProvider = Provider.of<CartViewModel>(context, listen: false);
      await cartProvider.fetchAllCarts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartViewModel>();
    final authProvider = context.watch<AuthViewmodel>();

    return Scaffold(
      body: FutureBuilder(
        future: _loadDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (cartProvider.pendingData.isEmpty) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                      child:
                          Lottie.asset('assets/lottie/Animation _cart.json')),
                  SizedBox(
                    height: 10,
                  ),
                  Text('No pending data')
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: cartProvider.pendingData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(cartProvider.pendingData[index].status);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetails(
                            index: index,
                            userid: cartProvider.pendingData[index].userid!,
                            screen: 1,
                          ),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: secindLighter,
                      shadowColor: maincolor,
                      elevation: 10,
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          //border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(cartProvider
                                      .pendingData[index].productid?.image ??
                                  'image'),
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
                                        cartProvider.pendingData[index]
                                                .productid?.name ??
                                            'name',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'Size: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 0),
                                      Text(
                                        cartProvider.pendingData[index]
                                                .productid?.size ??
                                            'size',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(
                                        width: 60,
                                      )
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
                                        cartProvider.pendingData[index].quantity
                                            .toString(),
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Spacer(),
                                      const Text(
                                        '₹: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        ((cartProvider.pendingData[index]
                                                    .productid?.price)! *
                                                (cartProvider.pendingData[index]
                                                        .quantity)!
                                                    .toInt())
                                            .toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 60,
                                      )
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
                                                .pendingData[index].status ??
                                            'status..',
                                        style: TextStyle(
                                            fontSize: 18, color: maincolor),
                                      ),
                                      const Spacer(),
                                      const SizedBox(
                                        width: 5,
                                      )
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
