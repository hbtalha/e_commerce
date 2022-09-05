import 'package:flutter/material.dart';

import 'package:e_commerce/constants/global_variables.dart';

class RatingTag extends StatelessWidget {
  final double value;
  final EdgeInsetsGeometry? margin;
  const RatingTag({
    Key? key,
    required this.value,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value == 0.0
        ? const SizedBox()
        : Container(
            width: 50,
            margin: margin,
            padding:const  EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 8),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  size: 15,
                  color: GlobalVariables.secondaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  '$value',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
  }
}
