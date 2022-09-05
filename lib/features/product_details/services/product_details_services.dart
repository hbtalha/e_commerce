import 'dart:convert';

import 'package:e_commerce/constants/error_handling.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/constants/utils.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
    required String userName,
    required String comment,
    required String date,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/rate-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token,
          },
          body: jsonEncode({
            'id': product.id,
            'rating': rating,
            'userName': userName,
            'comment': comment,
            'date': date,
          }));

      httpErrorHandling(response: response, context: context, onSuccess: () {});
    } catch (e) {
      print(e.toString());
      showSnackBar(msg: e.toString(), context: context, isError: true);
    }
  }

  Future<Product?> fetchProductDetails(
      {required BuildContext context, required String productId}) async {
    Product? product;
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/product-details/?id=$productId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            product = Product.fromJson(response.body);
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(msg: e.toString(), context: context, isError: true);
    }

    return product;
  }
}
