import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/details_screen.dart';
import '../utils/contants.dart';
import '../view_model/home_view_model.dart';

class allproduct extends StatelessWidget {
  const allproduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();

    return Container(
      height: 582,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (100 / 140),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: provider.products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    screen: 1,
                    index: index,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: secondaycolor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: Image.network(
                        provider.products[index].image ?? 'name',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(provider.products[index].name ?? 'name'),
                    Text(
                      provider.products[index].colour ?? 'name',
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      '₹ ${provider.products[index].price ?? 'name'}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
