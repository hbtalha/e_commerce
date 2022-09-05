import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/constants/utils.dart';
import 'package:e_commerce/features/home/widgets/rating_tag.dart';
import 'package:e_commerce/features/product_details/screens/product_details_screen.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product.id);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 - 16 - 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2 - 16 - 8,
              height: MediaQuery.of(context).size.width / 2 - 16 - 8,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(product.gallery[0]), fit: BoxFit.cover),
              ),
              child: RatingTag(value: getAvgRating(product.ratings)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2, bottom: 8),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        color: GlobalVariables.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
