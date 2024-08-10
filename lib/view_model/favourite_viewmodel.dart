import 'package:flutter/material.dart';

import '../model/favourite_model.dart';
import '../model/product_model.dart';
import '../services/favourite_service.dart';

class FavouriteViewmodel extends ChangeNotifier {
  bool loading = false;
  final _favouriteservice = FavouriteService();
  List<String> favoriteProductIds = [];
  List<FavouriteModel> favItems = [];
  List<Productid> favData = [];

  Future<void> addToFavourite({
    required String userid,
    required Productmodel product,
    required BuildContext context,
  }) async {
    try {
      loading = true;
      notifyListeners();

      await _favouriteservice.addToFavourite(userid: userid, product: product);
      favoriteProductIds.add(product.sId!); // Add product ID to favorites list
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product added to Favourite successfully"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to add product to Favourite: $e"),
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> removeFromFavourite({
    required String userid,
    required String productId,
    required BuildContext context,
  }) async {
    try {
      loading = true;
      notifyListeners();

      await _favouriteservice.removeFromFavourite(
          userid: userid, productId: productId);
      favoriteProductIds
          .remove(productId); // Remove product ID from favorites list
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product removed from Favourite successfully"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("1-- Failed to remove product from Favourite: $e"),
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFavContents(String userid, BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      favItems = await _favouriteservice.getfavContents(userid);
      favData.clear();

      for (var favItem in favItems) {
        final productid = favItem.productid;
        if (productid != null) {
          favData.add(productid);
          favoriteProductIds.add(productid.sId!);
        }
      }

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to fetch wishlist contents: $e"),
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  bool isFavorite(String productId) {
    return favoriteProductIds.contains(productId);
  }
}
