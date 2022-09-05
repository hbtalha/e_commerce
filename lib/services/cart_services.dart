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

class CartServices {
  Future<void> modifyCart({
    required BuildContext context,
    required Product product,
    required int quantity,
    String? successMsg,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/modify-cart'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'id': product.id!,
            'quantity': quantity,
          }));

      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(response.body)['cart'],
          );
          userProvider.setUserFromModel(user);
          if (successMsg != null) {
            showSnackBar(msg: successMsg, context: context);
          }
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(msg: e.toString(), context: context, isError: true);
    }
  }

  Future<void> removeFromCart({
    required BuildContext context,
    required List<String> ids,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(Uri.parse('$uri/api/remove-from-cart'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'ids': ids,
          }));

      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(response.body)['cart'],
          );
          showSnackBar(msg: 'Successfully Deleted', context: context);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(msg: e.toString(), context: context, isError: true);
    }
  }
}
