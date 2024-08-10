import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/favourite_model.dart';
import '../model/product_model.dart';
import '../utils/contants.dart';

class FavouriteService {
  Future<void> addToFavourite({
    required String userid,
    required Productmodel product,
  }) async {
    final Uri url = Uri.parse('$baseurl/api/favourite/addToFavourite');

    final Map<String, dynamic> cartData = {
      'userid': userid,
      'productid': product.sId,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(cartData),
      );

      if (response.statusCode == 201) {
        print('Product added to favourite successfully');
      } else {
        throw Exception('Failed to add product to favourite');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> removeFromFavourite({
    required String userid,
    required String productId,
  }) async {
    final Uri url = Uri.parse(
        '$baseurl/api/favourite/removeFromFavourite/$userid/$productId');

    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Product removed from favourite successfully');
      } else {
        throw Exception('Failed to remove product from favourite');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<FavouriteModel>> getfavContents(String userid) async {
    final Uri url = Uri.parse('$baseurl/api/favourite/viewFavorite/$userid');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data'] is List) {
          List<FavouriteModel> wishList = (data['data'] as List)
              .map((item) =>
                  FavouriteModel.fromJson(item as Map<String, dynamic>))
              .toList();
          return wishList;
        } else {
          throw Exception('The key "data" is missing or the list is null');
        }
      } else {
        throw Exception('Failed to load favourite contents');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
