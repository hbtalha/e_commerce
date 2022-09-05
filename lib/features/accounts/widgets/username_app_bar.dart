import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/models/user.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserNameAppBar extends StatelessWidget {
  const UserNameAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
