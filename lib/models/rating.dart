import 'dart:convert';

class Rating {
  final String id;
  final String userName;
  final String comment;
  final String date;
  final double rating;
  Rating({
    required this.id,
    required this.userName,
    required this.comment,
    required this.date,
    required this.rating,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'comment': comment,
      'date': date,
      'rating': rating,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      id: map['id'] ?? '',
      userName: map['userName'] ?? '',
      comment: map['comment'] ?? '',
      date: map['date'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}
