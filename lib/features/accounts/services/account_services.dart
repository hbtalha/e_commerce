import 'package:e_commerce/constants/utils.dart';
import 'package:e_commerce/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  void logOut({
    required BuildContext context,
    required bool mounted,
  }) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context: context, msg: e.toString(), isError: true);
    }
  }
}
