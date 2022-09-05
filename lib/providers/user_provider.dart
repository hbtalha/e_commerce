import 'package:e_commerce/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: "",
    password: "",
    email: "email",
    address: "",
    token: "",
    type: "",
    cart: [],
  );

  User get user => _user;

  void setUser(String source) {
    _user = User.fromJson(source);
    notifyListeners();
  }
  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
