import 'package:e_commerce/features/accounts/services/account_services.dart';
import 'package:e_commerce/features/accounts/widgets/top_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  AccountServices accountServices = AccountServices();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TopButton(
              text: 'Your Orders',
              onTap: () {},
            ),
            TopButton(
              text: 'Turn Sellers',
              onTap: () {},
            ),
          ],
        ),
        Row(
          children: [
            TopButton(
              text: 'Log Out',
              onTap: () {
                accountServices.logOut(context: context, mounted: mounted);
              },
            ),
            TopButton(
              text: 'Your Wish List',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
