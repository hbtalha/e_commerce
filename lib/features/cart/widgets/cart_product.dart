import 'package:e_commerce/common/widgets/loader.dart';
import 'package:e_commerce/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce/services/cart_services.dart';
import 'package:e_commerce/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CartProduct extends StatefulWidget {
  final Product product;
  final int quantity;
  final void Function(int quantity) onQuantityChanged;
  const CartProduct({
    Key? key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  CartServices cartServices = CartServices();
  bool isChangingQuantity = false;

  void changeCartProductQuantity(increaseQuantity) async {
    if (!(widget.quantity == 1 && !increaseQuantity)) {
      setState(() {
        isChangingQuantity = true;
      });
      widget.onQuantityChanged(increaseQuantity);
    }
  }

  void navigateToProductDetailsScreen(Product product) {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              InkWell(
                onTap: () => navigateToProductDetailsScreen(widget.product),
                child: CachedNetworkImage(
                  imageUrl: widget.product.gallery[0],
                  fit: BoxFit.contain,
                  height: 105,
                  width: 105,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => navigateToProductDetailsScreen(widget.product),
                      child: Column(
                        children: [
                          Container(
                            width: 235,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              widget.product.name,
                              style: const TextStyle(fontSize: 15),
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            width: 235,
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              '\$${widget.product.price}',
                              style: TextStyle(
                                color: Colors.red[400],
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          Container(
                            width: 235,
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: const Text('Eligible for FREE SHIPPING'),
                          ),
                          Container(
                            width: 235,
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: const Text(
                              'In Stock',
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 0,
                              ),
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.black12,
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () => changeCartProductQuantity(widget.quantity - 1),
                                  child: Container(
                                    width: 25,
                                    height: 22,
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.remove, size: 18),
                                  ),
                                ),
                                Container(
                                  width: 25,
                                  height: 22,
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: Text('${widget.quantity}'),
                                ),
                                InkWell(
                                  onTap: () => changeCartProductQuantity(widget.quantity + 1),
                                  child: Container(
                                    width: 25,
                                    height: 22,
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.add, size: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isChangingQuantity)
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              height: 15,
                              width: 20,
                              child: const Loader(),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
