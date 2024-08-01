import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/widgets/Jackets.dart';
import 'package:store/widgets/Sneakers.dart';
import 'package:store/widgets/catogeries.dart';

import '../view_model/home_view_model.dart';
import '../widgets/allproduct.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;

  void onCategorySelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeViewModel>(context, listen: false).fetchProducts(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();
    return Scaffold(
      body: provider.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : provider.products.isEmpty
              ? Center(
                  child: Text('no data'),
                )
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'our products',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Catogeries(
                            name: 'All products',
                            index: 0,
                            isSelected: selectedIndex == 0,
                            onTap: onCategorySelected,
                          ),
                          Catogeries(
                            name: 'Jackets',
                            index: 1,
                            isSelected: selectedIndex == 1,
                            onTap: onCategorySelected,
                          ),
                          Catogeries(
                            name: 'Sneaker',
                            index: 2,
                            isSelected: selectedIndex == 2,
                            onTap: onCategorySelected,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      selectedIndex == 0
                          ? allproduct()
                          : selectedIndex == 1
                              ? Jackerts()
                              : Sneakers(),
                    ],
                  ),
                ),
    );
  }
}
