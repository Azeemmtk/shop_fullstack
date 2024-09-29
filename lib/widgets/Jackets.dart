import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Screens/user/details_screen.dart';
import '../model/product_model.dart';
import '../services/auth_service.dart';
import '../utils/contants.dart';
import '../view_model/favourite_viewmodel.dart';
import '../view_model/home_view_model.dart';

class Jackets extends StatefulWidget {
  const Jackets({super.key});

  @override
  State<Jackets> createState() => _JacketsState();
}

class _JacketsState extends State<Jackets> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();
    final favProvider = context.watch<FavouriteViewmodel>();
    final userid = Authservice();

    return Container(
      height: 569,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (100 / 140),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: provider.jackets.length,
        itemBuilder: (context, index) {
          final product = provider.jackets[index];
          final isFavorited = favProvider.isFavorite(product.sId!);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    screen: 2,
                    index: index,
                  ),
                ),
              );
            },
            child: Card(
              color: secondaycolor,
              shadowColor: maincolor,
              elevation: 7,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the start
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isFavorited) {
                                  favProvider.removeFromFavourite(
                                    userid: userid.userId!,
                                    productId: product.sId!,
                                    context: context,
                                  );
                                } else {
                                  Productmodel newProduct = Productmodel(
                                    name: product.name,
                                    category: product.category,
                                    colour: product.colour,
                                    details: product.details,
                                    price: product.price,
                                    size: product.size,
                                    sId: product.sId,
                                  );

                                  favProvider.addToFavourite(
                                    userid: userid.userId!,
                                    product: newProduct,
                                    context: context,
                                  );
                                }
                              });
                            },
                            child: Icon(
                              isFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorited ? Colors.red : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: SizedBox(
                          height: 105,
                          width: 105,
                          child: Hero(
                            tag: product.image!,
                            child: Image.network(
                              product.image ?? 'image',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      Text(
                        product.name ?? 'name',
                        style: GoogleFonts.lora(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.colour ?? 'colour',
                        style: GoogleFonts.openSans(),
                      ),
                      Row(
                        children: [
                          Text(
                            '₹: ${product.price ?? 'price'}  ',
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹: ${product.price! + 500}',
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.inactiveGray,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: CupertinoColors.inactiveGray,
                                decorationThickness: 3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
