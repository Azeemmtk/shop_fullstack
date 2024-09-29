import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/utils/contants.dart';
import 'package:store/view_model/cart_viewmodel.dart';

import '../../services/auth_service.dart';
import '../../view_model/auth_viewmodel.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  Future<void>? _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = Future.microtask(() async {
      final id = Authservice();
      await id.loadUserId();
      final authProvider = Provider.of<AuthViewmodel>(context, listen: false);
      authProvider.fetchUserDetails(id.userId!, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();
    final userprovider = context.watch<AuthViewmodel>();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<void>(
        future: _loadDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 10,
                  color: secindLighter,
                  shadowColor: maincolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userprovider.userDetails?['name'] ?? 'Name',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Username',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            userprovider.userDetails?['username'] ?? 'Username',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            userprovider.userDetails?['email'] ?? 'Email',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Phone',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            userprovider.userDetails?['phone'] ?? 'Phone',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor,
                      elevation: 7,
                      shadowColor: maincolor,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      cart.cartData.clear();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
