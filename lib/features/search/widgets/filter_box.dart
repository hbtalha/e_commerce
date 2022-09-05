import 'package:e_commerce/common/widgets/custom_button.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterBox extends StatelessWidget {
  final VoidCallback onFilterButtonPressed;
  const FilterBox({Key? key, required this.onFilterButtonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: kElevationToShadow[1],
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          CustomButton(width: 10, height: 25, text: "Filter", onTap: onFilterButtonPressed),
          // Eleva
        ],
      ),
    );
  }
}
