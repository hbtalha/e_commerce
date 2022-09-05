import 'package:e_commerce/common/widgets/custom_button.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/features/cart/widgets/cart_product.dart';
import 'package:e_commerce/features/cart/widgets/flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:e_commerce/features/home/widgets/address_box.dart';
import 'package:e_commerce/features/search/screens/search_screen.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:e_commerce/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart-screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // used as a key to work around a issue in flutter_multi_select_items (https://github.com/CodeFoxLk/flutter_multi_select/issues/5)
  int key = 0;
  MultiSelectController multiSelectController = MultiSelectController();
  List<String> productIds = [];
  int selectedProductsNumber = 0;
  double totalPrice = 0.0;
  CartServices cartServices = CartServices();

  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: searchQuery);
  }

  void updateTotal(List<dynamic> cart) {
    selectedProductsNumber = multiSelectController.selectedItemsValues.length;

    final selectedProducts = cart.where(
        (element) => multiSelectController.selectedItemsValues.contains(element['product']["_id"]));

    productIds = selectedProducts.map((e) => e['product']['_id'] as String).toList();

    totalPrice = 0.0;
    selectedProducts.map((e) => totalPrice += e['quantity'] * e['product']['price']).toList();

    setState(() {});
  }

  void changeCartProductQuantity({required Product product, required quantity}) async {
    await cartServices.modifyCart(
      context: context,
      product: product,
      quantity: quantity,      
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    updateTotal(user.cart);
    ++key;
    return SafeArea(
      child: Scaffold(
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
              'Cart',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              if (productIds.isNotEmpty)
                Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: InkWell(
                      onTap: () {
                        cartServices.removeFromCart(context: context, ids: productIds);
                        multiSelectController.selectedItemsValues.clear();
                      },
                      child: const Icon(Icons.delete_outline),
                    ))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AddressBox(),
              MultiSelectCheckList(
                key: Key(key.toString()),
                controller: multiSelectController,
                items: user.cart.map((productMap) {
                  Product product = Product.fromMap(productMap['product']);
                  return CheckListCard(
                    value: product.id,
                    title: CartProduct(
                      product: product,
                      quantity: productMap['quantity'],
                      onQuantityChanged: (quantity) => changeCartProductQuantity(
                          product: product, quantity: quantity),
                    ),
                  );
                }).toList(),
                onChange: () => updateTotal(user.cart),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: kElevationToShadow[3],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '\$$totalPrice',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                      height: 30,
                      width: 10,
                      text: 'Buy ($selectedProductsNumber)',
                      onTap: () {},
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
