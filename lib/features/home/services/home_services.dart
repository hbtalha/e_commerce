import 'dart:convert';

import 'package:e_commerce/constants/error_handling.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/constants/utils.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> _fetchProducts({
    required BuildContext context,
    required String enpoint,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> products = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri$enpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            final jsonRes = jsonDecode(response.body);
            for (int i = 0; i < jsonRes.length; ++i) {
              products.add(Product.fromJson(jsonEncode(jsonRes[i])));
            }
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(msg: e.toString(), context: context, isError: true);
    }

    return products;
  }

  Future<List<Product>> fetchDiscountedProducts({
    required BuildContext context,
    required bool isForHomeDisplay,
  }) async {
    return _fetchProducts(
        context: context, enpoint: '/api/products-with-discount/$isForHomeDisplay');
  }

  Future<List<Product>> fetchMoreProducts({
    required BuildContext context,
  }) async {
    return _fetchProducts(
        context: context, enpoint: '/api/more-products');
  }

}
