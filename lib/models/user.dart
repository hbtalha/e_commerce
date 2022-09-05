import 'dart:convert';

class User {
  final String id;
  final String name;
  final String password;
  final String email;
  final String address;
  final String token;
  final String type;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.address,
    required this.token,
    required this.type,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? password,
    String? email,
    String? address,
    String? token,
    String? type,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      address: address ?? this.address,
      token: token ?? this.token,
      type: type ?? this.type,
      cart: cart ?? this.cart,
    );
  }
}
