import 'dart:convert';

import 'package:e_commerce/common/widgets/bottom_bar.dart';
import 'package:e_commerce/constants/error_handling.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/constants/utils.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        token: '',
        type: '',
        cart: [],
      );

      http.Response response = await http
          .post(Uri.parse("$uri/api/signup"), body: user.toJson(), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(
              msg: 'Account created! Sign in with the same credentials',
              context: context,
              seconds: 5,
            );
          });
    } catch (e) {
      showSnackBar(msg: e.toString(), context: context, isError: true);
    }
  }

  void signInUser({
    required bool mounted,
    required BuildContext context,
    required String loginValue,
    required String password,
  }) async {
    try {
      print('SigningIn');
      http.Response response = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({
            "loginValue": loginValue,
            "password": password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences preferences = await SharedPreferences.getInstance();

            if (!mounted) return;
            Provider.of<UserProvider>(context, listen: false).setUser(response.body);

            await preferences.setString("x-auth-token", jsonDecode(response.body)['token']);

            if (!mounted) return;
            Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      print('SignIn Error: ${e.toString()}');
      showSnackBar(msg: e.toString(), context: context, isError: true);
    }
  }

  Future<void> getUserData({required mounted, required BuildContext context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("x-auth-token");

      if (token == null) {
        preferences.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        if (!mounted) return;
        Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
      }
    } catch (e) {
      // showSnackBar(msg: e.toString(), context: context, isError: true);
    }
  }
}
