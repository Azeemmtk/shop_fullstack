import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/utils/contants.dart';

import '../../view_model/cart_viewmodel.dart';
import '../paymentsuccesfull_screen.dart';

class PaymentDetails extends StatefulWidget {
  final double? ChTotal;

  PaymentDetails({super.key, this.ChTotal});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late double total = 0;
  String selectedPaymentMethod = 'cash_on_delivery';

  @override
  void initState() {
    super.initState();
    total = widget.ChTotal ?? 0;
  }

  void _showAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Address'),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Enter your address',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secindLighter,
                elevation: 3,
                shadowColor: maincolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secindLighter,
                elevation: 3,
                shadowColor: maincolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                // Add address logic
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Payment Method'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Cash on Delivery'),
                leading: Radio(
                  value: 'cash_on_delivery',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secindLighter,
                elevation: 3,
                shadowColor: maincolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secindLighter,
                elevation: 3,
                shadowColor: maincolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                // Payment method is already set to 'cash_on_delivery'
                Navigator.of(context).pop();
              },
              child: Text('Select'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartprovider = context.watch<CartViewModel>();
    double deliveryCharge = 30.0;
    //double totalAmount = total + deliveryCharge;
    double totalAmount = 0;
    for (int i = 0; i < cartprovider.cartData.length; i++) {
      totalAmount += (cartprovider.cartData[i].price ?? 0) *
          (cartprovider.cartItems[i].quantity ?? 0);
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Container(
          color: maincolor,
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: 15,
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.1),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 127,
                child: Text(
                  "CheckOut",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Airbnb",
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                top: 99,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 10),
                        child: Card(
                          color: secindLighter,
                          elevation: 5,
                          shadowColor: maincolor,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: ListView.builder(
                              itemCount: cartprovider.cartData.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartprovider.cartData[index].name ??
                                            'name',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
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
                                            cartprovider
                                                .cartItems[index].quantity
                                                .toString(),
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Scroll to view all",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Container(width: 350, child: Divider()),
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 20),
                        child: Row(
                          children: [
                            Text(
                              "Address:",
                              style: TextStyle(
                                  fontFamily: "Airbnb",
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 195,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secindLighter,
                                elevation: 3,
                                shadowColor: maincolor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: _showAddressDialog,
                              child: Text(
                                "Add",
                                style: TextStyle(color: maincolor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          children: [
                            Text(
                              "Payment:",
                              style: TextStyle(
                                  fontFamily: "Airbnb",
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 175,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secindLighter,
                                elevation: 3,
                                shadowColor: maincolor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: _showPaymentDialog,
                              child: Text(
                                "Select",
                                style: TextStyle(color: maincolor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 350, child: Divider()),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Sub total:",
                                  style: TextStyle(
                                      fontFamily: "Airbnb",
                                      fontSize: 17,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 180,
                                ),
                                Text(
                                  '₹${totalAmount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontFamily: "Airbnb",
                                      fontSize: 17,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Delivery:",
                                  style: TextStyle(
                                      fontFamily: "Airbnb",
                                      fontSize: 17,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 225,
                                ),
                                Text(
                                  "₹${deliveryCharge.toStringAsFixed(1)}",
                                  style: TextStyle(
                                      fontFamily: "Airbnb",
                                      fontSize: 17,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(width: 350, child: Divider()),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Total:",
                                  style: TextStyle(
                                      fontFamily: "Airbnb",
                                      fontSize: 25,
                                      color: maincolor),
                                ),
                                SizedBox(
                                  width: 160,
                                ),
                                Text(
                                  "\₹${(totalAmount + deliveryCharge).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontFamily: "Airbnb",
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "ThankYou.Enjoy.Explore",
                        style: TextStyle(
                            color: maincolor,
                            fontFamily: "Airbnb",
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        color: maincolor,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccesfull(),
                  ));
            },
            child: Container(
              height: 45,
              width: 320,
              decoration: BoxDecoration(
                color: secindLighter,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: maincolor),
              ),
              child: Center(
                child: Text(
                  "Place Order",
                  style: TextStyle(
                    color: maincolor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
