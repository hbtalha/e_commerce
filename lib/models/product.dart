// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:e_commerce/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final double discountValue;
  final bool hasDiscount;
  final List<String> gallery;
  final Map<String, String> details;
  final List<Rating> ratings;
  final String? id;

  Product({
    required this.name,
    required this.description,
    required this.details,
    required this.price,
    required this.discountValue,
    required this.hasDiscount,
    required this.gallery,
    this.id,
    required this.ratings,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'discountValue': discountValue,
      'hasDiscount': hasDiscount,
      'gallery': gallery,
      'id': id,
      'ratings': ratings,
      'details': details,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      discountValue: map['discountValue']?.toDouble() ?? 0.0,
      hasDiscount: map['hasDiscount'],
      gallery: List<String>.from(map['gallery']),
      details: Map<String, String>.from(((map['details']) as Map<dynamic, dynamic>)),
      id: map['_id'] ?? '',
      ratings: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}
