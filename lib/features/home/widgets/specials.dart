import 'package:flutter/material.dart';

import 'package:e_commerce/features/home/widgets/product_card.dart';
import 'package:e_commerce/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce/models/product.dart';

class Specials extends StatefulWidget {
  final List<Product> products;
  final String title;
  final VoidCallback onSeeAll;
  const Specials({
    Key? key,
    required this.products,
    required this.title,
    required this.onSeeAll,
  }) : super(key: key);

  @override
  State<Specials> createState() => _SpecialsState();
}

class _SpecialsState extends State<Specials> {
  
  
  void navigateToProductDetailsScreen(Product product) {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              TextButton(
                onPressed: widget.onSeeAll,
                child: const Text(
                  "See All",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              widget.products.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 5),
                child: InkWell(
                  onTap: () => navigateToProductDetailsScreen(widget.products[index]),
                  child: ProductCard(
                    product: widget.products[index],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
