import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/product_model.dart';
import '../utils/contants.dart';

class HomeServices {
  Future<void> addProduct({
    required Productmodel product,
    required File imageFile,
  }) async {
    final Uri url = Uri.parse('$baseurl/api/product/addProduct');
    final request = http.MultipartRequest('POST', url)
      ..fields['name'] = product.name ?? ''
      ..fields['category'] = product.category ?? ''
      ..fields['price'] = product.price.toString()
      ..fields['details'] = product.details ?? ''
      ..fields['size'] = product.size.toString()
      ..fields['colour'] = product.colour ?? ''
      ..files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      );

    try {
      final response = await request.send();
      if (response.statusCode == 201) {
        print('Product added successfully');
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Productmodel>> getProducts() async {
    try {
      final response =
          await http.get(Uri.parse('$baseurl/api/product/viewProduct'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Response data: $data');

        if (data['data'] is List) {
          var productList = (data['data'] as List)
              .map(
                  (item) => Productmodel.fromJson(item as Map<String, dynamic>))
              .toList();
          print('Product list: $productList');

          return productList;
        } else {
          throw Exception('The key "data" is missing or the list is null');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
