import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/user/details_screen.dart';
import '../utils/contants.dart';
import '../view_model/home_view_model.dart';

class Sneakers extends StatelessWidget {
  const Sneakers({
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
        itemCount: provider.sneakers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    screen: 3,
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
                          color: Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: Hero(
                        tag: provider.sneakers[index].image!,
                        child: Image.network(
                          provider.sneakers[index].image ?? 'image',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(provider.sneakers[index].name ?? 'name'),
                    Text(
                      provider.sneakers[index].colour ?? 'colour',
                      style: TextStyle(color: Colors.red),
                    ),
                    Text('₹ ${provider.sneakers[index].price ?? 'price'}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
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
