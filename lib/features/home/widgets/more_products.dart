import 'package:e_commerce/features/home/widgets/product_card.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

class MoreProducts extends StatelessWidget {
  final List<Product> products;
  final String? title;
  const MoreProducts({
    Key? key,
    required this.products,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(title != null)
        Padding(
          padding:const EdgeInsets.only(left: 16, top: 16),
          child: Text(
            title!,
            style:const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(products.length, (index) {             
              return ProductCard(
                product: products[index],
              );
            }),
          ),
        )
      ],
    );
  }
}
