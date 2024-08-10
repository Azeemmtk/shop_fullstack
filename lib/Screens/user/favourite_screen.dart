import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../view_model/favourite_viewmodel.dart';

class Favouritrscreen extends StatefulWidget {
  const Favouritrscreen({super.key});

  @override
  State<Favouritrscreen> createState() => _FavouritrscreenState();
}

class _FavouritrscreenState extends State<Favouritrscreen> {
  Future<void>? _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = _loadData();
  }

  Future<void> _loadData() async {
    final authService = Authservice();
    await authService.loadUserId();
    var id = authService.userId;

    if (id != null) {
      final favProvider =
          Provider.of<FavouriteViewmodel>(context, listen: false);
      await favProvider.fetchFavContents(id, context); // Updated method call
    } else {
      print('User ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavouriteViewmodel>();

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

          if (favProvider.favData.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/Animation _cart.json'),
                  SizedBox(height: 10),
                  Text('Fav is empty'),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: favProvider.favData.length,
              itemBuilder: (context, index) {
                final product = favProvider.favData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.network(
                            product.image ?? 'https://via.placeholder.com/100',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                product.name ?? 'Name',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Size: ${product.size ?? 'N/A'}',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ],
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
