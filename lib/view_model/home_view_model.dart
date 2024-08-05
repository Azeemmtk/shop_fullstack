import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store/Screens/admin/admin_home_screen.dart';
import 'package:store/Screens/user/main_screen.dart';
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

  Future<void> updateProduct(
      {required Productmodel product,
      File? imageFile,
      required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();

      await _productService.updateProduct(
          product: product, imageFile: imageFile);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product Updated Successfully"),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminHomeScreen()));
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to update product: $e"),
      ));
    }
  }

  Future<void> deleteProduct({
    required String productId,
    required BuildContext context,
  }) async {
    try {
      loading = true;
      notifyListeners();

      await _productService.deleteProduct(productId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product Deleted Successfully"),
      ));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminHomeScreen(),
        ),
      );
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to delete product: $e"),
      ));
    }
  }
}
