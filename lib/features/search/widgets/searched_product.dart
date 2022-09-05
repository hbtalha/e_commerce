import 'package:e_commerce/features/search/widgets/rating_stars.dart';
import 'package:e_commerce/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0.0;
    for (int i = 0; i < product.ratings.length; ++i) {
      totalRating += product.ratings[i].rating;
    }
    double avgRating = 0.0;
    if (totalRating != 0) {
      avgRating = totalRating / product.ratings.length;
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: product.gallery[0],
                fit: BoxFit.fitWidth,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: RatingStars(rating: avgRating),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
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
            ],
          ),
        )
      ],
    );
  }
}
