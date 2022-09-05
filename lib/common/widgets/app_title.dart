import 'package:e_commerce/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'e',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: GlobalVariables.secondaryColor,
          ),
          children: [
            TextSpan(
              text: '_',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'c',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'on',
              style: TextStyle(
                color: GlobalVariables.secondaryColor,
                fontSize: 30,
              ),
            ),
            TextSpan(
              text: 'm',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ]),
    );
  }
}