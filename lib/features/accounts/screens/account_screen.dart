import 'package:e_commerce/common/widgets/app_title.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/features/accounts/widgets/orders.dart';
import 'package:e_commerce/features/accounts/widgets/top_buttons.dart';
import 'package:e_commerce/features/accounts/widgets/username_app_bar.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const AppTitle(),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 14),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          UserNameAppBar(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(height: 20),
          Orders(),
        ],
      ),
    );
  }
}
