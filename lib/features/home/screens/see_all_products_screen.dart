import 'package:e_commerce/common/widgets/loader.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/features/home/services/home_services.dart';
import 'package:e_commerce/features/home/widgets/more_products.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

class SeeAllProductsScreen extends StatefulWidget {
  static const String routeName = "/see-all-producs-screen";
  const SeeAllProductsScreen({Key? key}) : super(key: key);

  @override
  State<SeeAllProductsScreen> createState() => _SeeAllProductsScreenState();
}

class _SeeAllProductsScreenState extends State<SeeAllProductsScreen> {
  HomeServices homeServices = HomeServices();
  List<Product>? discountedProducts;

  @override
  void initState() {
    super.initState();
    fetchDiscountedProducts();
  }

  void fetchDiscountedProducts() async {
    discountedProducts =
        await homeServices.fetchDiscountedProducts(context: context, isForHomeDisplay: false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Text(
              'Discounts',
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: SingleChildScrollView(
        child: discountedProducts == null
            ? const Loader()
            : MoreProducts(products: discountedProducts!),
      ),
    );
  }
}
