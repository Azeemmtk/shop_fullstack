import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store/Screens/main_screen.dart';
import 'package:store/model/product_model.dart';
import 'package:store/services/product_service.dart';

class HomeViewModel extends ChangeNotifier {
  bool loading = false;
  List<Productmodel> products = [];
  List<Productmodel> jackets = [];
  List<Productmodel> sneakers = [];

  final _productService = HomeServices();

  Future<void> addProduct(
      {required Productmodel product,
      required File imageFile,
      required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();

      await _productService.addProduct(product: product, imageFile: imageFile);
      CircularProgressIndicator();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product Added Successfully"),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Mainscreen()));
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to add product: $e"),
      ));
    }
  }

  Future<void> fetchProducts(BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      products = await _productService.getProducts();

      // Filter products based on their category
      jackets =
          products.where((product) => product.category == 'jacket').toList();
      sneakers =
          products.where((product) => product.category == 'Sneakers').toList();

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to fetch products: $e"),
      ));
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
