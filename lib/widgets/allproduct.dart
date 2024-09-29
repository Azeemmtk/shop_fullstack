import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:store/services/auth_service.dart';
import 'package:store/view_model/favourite_viewmodel.dart';

import '../Screens/user/details_screen.dart';
import '../model/product_model.dart';
import '../utils/contants.dart';
import '../view_model/home_view_model.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  late List<bool> isClickedList;

  @override
  void initState() {
    super.initState();
    final provider = context.read<HomeViewModel>();
    isClickedList = List<bool>.filled(provider.products.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();
    final favprovider = context.watch<FavouriteViewmodel>();
    final userid = Authservice();
    final data = provider.products;

    return Container(
      height: 571,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (100 / 140),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: provider.products.length,
        itemBuilder: (context, index) {
          final product = data[index];
          final isFavorited = favprovider.isFavorite(product.sId!);

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
            child: Card(
              elevation: 7,
              color: secondaycolor,
              shadowColor: maincolor,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isFavorited) {
                                  favprovider.removeFromFavourite(
                                    userid: userid.userId!,
                                    productId: product.sId!,
                                    context: context,
                                  );
                                } else {
                                  Productmodel newproduct = Productmodel(
                                    name: product.name,
                                    category: product.category,
                                    colour: product.colour,
                                    details: product.details,
                                    price: product.price,
                                    size: product.size,
                                    sId: product.sId,
                                  );

                                  favprovider.addToFavourite(
                                    userid: userid.userId!,
                                    product: newproduct,
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
                          width: 113,
                          child: Hero(
                            tag: provider.products[index].image!,
                            child: Image.network(
                              provider.products[index].image ?? 'image',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      Text(
                        provider.products[index].name ?? 'name',
                        style: GoogleFonts.lora(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        provider.products[index].colour ?? 'Color',
                        style: GoogleFonts.openSans(),
                      ),
                      Row(
                        children: [
                          Text(
                            '₹: ${provider.products[index].price ?? 'Price'}  ',
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹: ${provider.products[index].price! + 500}',
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.inactiveGray,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: CupertinoColors.inactiveGray,
                                decorationThickness: 4),
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
