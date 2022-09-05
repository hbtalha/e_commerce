import 'package:e_commerce/common/widgets/bottom_bar.dart';
import 'package:e_commerce/features/auth/screens/auth_screen.dart';
import 'package:e_commerce/features/cart/screens/cart_screen.dart';
import 'package:e_commerce/features/home/screens/home_screen.dart';
import 'package:e_commerce/features/home/screens/see_all_products_screen.dart';
import 'package:e_commerce/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce/features/search/screens/search_screen.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generatedRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );

    case SeeAllProductsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SeeAllProductsScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: searchQuery),
      );
    
    case ProductDetailsScreen.routeName:
      var productId = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(productId: productId),
      );

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exist!'),
                ),
              ));
  }
}
