import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/admin/order_screen.dart';
import 'package:store/view_model/auth_viewmodel.dart';

import '../../utils/contants.dart';
import '../../view_model/cart_viewmodel.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails(
      {super.key,
      required this.index,
      required this.userid,
      required this.screen});
  int index;
  String userid;
  int screen;

  @override
  State<OrderDetails> createState() => _OrderDetaialsState();
}

class _OrderDetaialsState extends State<OrderDetails> {
  Future<void>? _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = Future.microtask(() async {
      final authProvider = Provider.of<AuthViewmodel>(context, listen: false);
      authProvider.fetchUserDetails(widget.userid, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartprovider = context.watch<CartViewModel>();
    final data = widget.screen == 1
        ? cartprovider.pendingData
        : cartprovider.deliveredData;
    final userprovider = context.watch<AuthViewmodel>();

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
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
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
                  tag: data[widget.index].productid!.image!,
                  child: Image.network(
                    data[widget.index].productid?.image ?? 'image',
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            height: 360,
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
                      data[widget.index].productid?.name ?? 'Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                    ),
                    Text(
                      '₹ ${data[widget.index].productid?.price ?? 'price'}.0',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  color: maincolor,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Size: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(
                      data[widget.index].productid?.size ?? 'size',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Colour: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      data[widget.index].productid?.colour ?? 'colour',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Customer details ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Divider(
                  color: maincolor,
                ),
                Row(
                  children: [
                    Text(
                      'Name: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      userprovider.userDetails?['name'] ?? 'name',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Phone: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      userprovider.userDetails?['phone'] ?? 'phone',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Status: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      data[widget.index].status ?? 'phone',
                      style: TextStyle(fontSize: 20, color: maincolor),
                    ),
                  ],
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
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaycolor),
                    onPressed: () async {
                      try {
                        // Call the updateCart method to change status to "Order taken"
                        await cartprovider.updateCart(
                          cartItemId: data[widget.index].sId!,
                          updatedData: {'status': 'Order taken'},
                          context: context,
                        );
                        // Refresh the UI by fetching the cart data again
                        await cartprovider.fetchAllCarts(context);
                      } catch (e) {
                        print('Failed to update order status: $e');
                      }
                    },
                    child: Text(
                      'Take order',
                      style: TextStyle(color: maincolor),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaycolor),
                    onPressed: () async {
                      try {
                        // Call the updateCart method to change status to "Order taken"
                        await cartprovider.updateCart(
                          cartItemId: data[widget.index].sId!,
                          updatedData: {'status': 'Delivered'},
                          context: context,
                        );
                        // Refresh the UI by fetching the cart data again
                        await cartprovider.fetchAllCarts(context);
                      } catch (e) {
                        print('Failed to update order status: $e');
                      }
                      ;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Orders(),
                          ));
                    },
                    child: Text(
                      'Delivered',
                      style: TextStyle(color: maincolor),
                    ),
                  ),
                  SizedBox(
                    width: 30,
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
